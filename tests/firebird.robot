*** Settings ***
Library    SSHLibrary
Resource    api.resource

*** Test Cases ***
Check if firebird is installed correctly
    ${output}  ${rc} =    Execute Command    add-module ${IMAGE_URL} 1
    ...    return_rc=True
    Should Be Equal As Integers    ${rc}  0
    &{output} =    Evaluate    ${output}
    Set Suite Variable    ${module_id}    ${output.module_id}

Check if firebird can be configured
    ${rc} =    Execute Command    api-cli run module/${module_id}/configure-module --data '{"host":"firebird.domain.org","http2https": true,"lets_encrypt": true}'
    ...    return_rc=True  return_stdout=False
    Should Be Equal As Integers    ${rc}  0

Check firebird path is configured
    ${ocfg} =   Run task    module/${module_id}/get-configuration    {}
    Set Suite Variable     ${HOST}    ${ocfg['host']}
    Set Suite Variable     ${HTTP2HTTPS}    ${ocfg['http2https']}
    Set Suite Variable     ${LE_ENCRYPT}    ${ocfg['lets_encrypt']}
    Set Suite Variable     ${TZ}    ${ocfg['tz']}
    Set Suite Variable     ${TCP_PORT_FIREBIRD}    ${ocfg['port']}
    Set Suite Variable     ${FIREBIRD_DATABASE_DEFAULT_CHARSET}    ${ocfg['charset']}
    Should Not Be Empty    ${HOST}
    Should Be True    ${HTTP2HTTPS}
    Should Be True    ${LE_ENCRYPT}

Check if firebird works as expected
    Wait Until Keyword Succeeds    20 times    3 seconds    Ping firebird

Check if firebird is removed correctly
    ${rc} =    Execute Command    remove-module --no-preserve ${module_id}
    ...    return_rc=True  return_stdout=False
    Should Be Equal As Integers    ${rc}  0

*** Keywords ***
Ping firebird
    ${out}  ${err}  ${rc} =    Execute Command    curl -k -f -H 'Host: firebird.domain.org' https://127.0.0.1/login
    ...    return_rc=True  return_stdout=True  return_stderr=True
    Should Be Equal As Integers    ${rc}  0
    Should Contain    ${out}    <title>pgAdmin
