#!/bin/bash

# Email a piece of journal
jctl_args="-n10 -b -q --priority=3 SYSLOG_IDENTIFIER=systemd"

user=$(id -nu)
host=$(hostname -s)
subject="[$host] Errors detected while monitoring journal"
message="Journal:\n$(journalctl $jctl_args)\n"

echo "mailing fail report to user $user"
echo -e "$message" | mail -s "$subject" $user
sleep 5
