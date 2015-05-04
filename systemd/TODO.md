TODO
====

* can vncserver be made socket activated, like xorg?

* make sure the sync + shutdown still works fine

* Cleanup the xorg services

* remove as much as systemctl's from services as I can.

* make synced.target into a RefuseManualStart thing. Note, the fake-sync would fail I guess

* add notifications via jwatch:
  - emacs shutdown
  - imminent shutdown

* sync units should wait until the last commit is done!

* socket activated sshmux.serivce
  - currently, I can't use systemd-socket-proxy, because it produces an error. Look at
    ssh-proxy.service for more details.

* test mpv screensaver inhibition for xautolock. Setup xautolock, etc.

## Systemd issues

* systemd-inhibit, systemctl poweroff, etc. can't be run unprivileged outside a session