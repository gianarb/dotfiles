# required dependency:

* git
* stow

# install
```
curl -fsSL https://goo.gl/jV2ZpH | bash
```

# notes
* To set keyboard layout `setxkbmap -layout gb`
* Suspend laptop when closed

Modify this `/etc/systemd/logind.conf`. This configuration suspend the laptop
1sec after it's closed.
```
#  This file is part of systemd.
#
#  systemd is free software; you can redistribute it and/or modify it
#  under the terms of the GNU Lesser General Public License as published by
#  the Free Software Foundation; either version 2.1 of the License, or
#  (at your option) any later version.
#
# Entries in this file show the compile time defaults.
# You can change settings by editing this file.
# Defaults can be restored by simply deleting this file.
#
# See logind.conf(5) for details.

[Login]
#NAutoVTs=6
#ReserveVT=6
#KillUserProcesses=no
#KillOnlyUsers=
#KillExcludeUsers=root
#InhibitDelayMaxSec=5
#HandlePowerKey=poweroff
#HandleSuspendKey=suspend
#HandleHibernateKey=hibernate
#HandleLidSwitch=suspend
#HandleLidSwitchDocked=ignore
#PowerKeyIgnoreInhibited=no
#SuspendKeyIgnoreInhibited=no
#HibernateKeyIgnoreInhibited=no
#LidSwitchIgnoreInhibited=yes
#HoldoffTimeoutSec=30s
#IdleAction=ignore
#IdleActionSec=30min
#RuntimeDirectorySize=10%
#RemoveIPC=yes
#InhibitorsMax=8192
#SessionsMax=8192
#UserTasksMax=33%
HandleLidSwitch=suspend
HoldoffTimeoutSec=1s
```
According with this systemd service: `/usr/lib/systemd/suspend@.service`
```
[Unit]
Description=User suspend actions
Before=sleep.target

[Service]
User=%I
Type=forking
Environment=DISPLAY=:0
ExecStart=/home/gianarb/.dotfiles/bin/i3exit lock
ExecStartPost=/usr/bin/sleep 1

[Install]
WantedBy=sleep.target
```
