# ns8-firebird

Firebird is an open-source SQL relational database management system that supports Linux, Microsoft Windows, macOS and other Unix platforms. The database forked from Borland's open source edition of InterBase in 2000 but the code has been largely rewritten since Firebird 1.5.

This module is based on Firebird RDBMS version 3.0.11.

## Install

Instantiate the module with:

    add-module ghcr.io/nethserver/firebird:latest 1

The output of the command will return the instance name.
Output example:

    {"module_id": "firebird1", "image_name": "firebird", "image_url": "ghcr.io/nethserver/firebird:latest"}

## Configure

Let's assume that the firebird instance is named `firebird1`.

Launch `configure-module`, by setting the following parameters:
- `<MODULE_PARAM1_NAME>`: <MODULE_PARAM1_DESCRIPTION>
- `<MODULE_PARAM2_NAME>`: <MODULE_PARAM2_DESCRIPTION>
- ...

Example:

    api-cli run module/firebird1/configure-module --data '{}'

The above command will:
- start and configure the firebird instance
- (describe configuration process)
- ...

Send a test HTTP request to the firebird backend service:

    curl http://127.0.0.1/firebird/

## Smarthost setting discovery

Some configuration settings, like the smarthost setup, are not part of the
`configure-module` action input: they are discovered by looking at some
Redis keys.  To ensure the module is always up-to-date with the
centralized [smarthost
setup](https://nethserver.github.io/ns8-core/core/smarthost/) every time
firebird starts, the command `bin/discover-smarthost` runs and refreshes
the `state/smarthost.env` file with fresh values from Redis.

Furthermore if smarthost setup is changed when firebird is already
running, the event handler `events/smarthost-changed/10reload_services`
restarts the main module service.

See also the `systemd/user/firebird.service` file.

This setting discovery is just an example to understand how the module is
expected to work: it can be rewritten or discarded completely.

## Uninstall

To uninstall the instance:

    remove-module --no-preserve firebird1

## Testing

Test the module using the `test-module.sh` script:


    ./test-module.sh <NODE_ADDR> ghcr.io/nethserver/firebird:latest

The tests are made using [Robot Framework](https://robotframework.org/)

## UI translation

Translated with [Weblate](https://hosted.weblate.org/projects/ns8/).

To setup the translation process:

- add [GitHub Weblate app](https://docs.weblate.org/en/latest/admin/continuous.html#github-setup) to your repository
- add your repository to [hosted.weblate.org]((https://hosted.weblate.org) or ask a NethServer developer to add it to ns8 Weblate project
