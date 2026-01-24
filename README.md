# ns8-firebird

Firebird is an open source SQL relational database management system that supports Linux, Microsoft Windows, macOS, and other Unix platforms. The database is derived from Borland's OpenBase open source release in 2000, but the code has been largely rewritten since Firebird 1.5.

This module is based on Firebird 3.0.11 SuperServer.

## Features

• The default user is: SYSDBA, the password is: masterkey

• The default Firebird port is TCP 3050 but you can be changed in Settings

• The default Firebird database character set you can be changed in Settings

• The Timezone setting of the Firebird server you can be changed in Settings

• Enabling or disabling the Firebird TCP port on the firewall (if disabled, it is still accessible via VPN)

• The location of the databases (VOLUME) is in the default /var/lib/firebird/data directory

• Backup

## Install

Installation via Software Center:

• Add the repository https://raw.githubusercontent.com/sipi58/ns8-nethforge/repomd/ns8/updates/ to the Software Repositories and reload the repositories.

• Install the Firebird module from the Software Center

To install the latest version using CLI:

    add-module ghcr.io/sipi58/firebird:latest 1

## Configure

Set the Firebird Database Character set according to the encoding you want to use, using a standard notation, e.g. ISO-8859-2, UTF8, etc.

Set the Firebird TCP port number, it can be freely defined, but be aware that other services can also use the desired port number. It is recommended to use the default 3050 or similar ports (3051-3059). This can be helpful if you want to install multiple Firebird servers.

Set the Firebird server Time zone value according to the php rules. e.g. Europe/Budapest, America/New_York.

Set the Firebird port Enable/Disable on Firewall to open the Firebird TCP port on the firewall at startup or not. In the latter case, the port will still be available via VPN.

## Uninstall

Uninstallation is possible via the software center by clicking on the Instances label of the Firebird module, clicking on the three dots in the window that opens, and selecting Uninstall. Please note that when uninstalling the module, all data stored in the pod will be deleted!

If you need this data, back it up in advance.

The module can be removed via CLI with the following command:

    remove-module --no-preserve firebird1
