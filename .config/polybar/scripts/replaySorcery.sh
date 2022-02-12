#!/usr/bin/env bash

STATUS=$(systemctl --user status replay-sorcery | grep "Active")
STATUS=$(echo ${STATUS:13} | cut -d' ' -f1)

if [[ "$STATUS" == "active" ]]; then
    systemctl --user stop replay-sorcery
    notify-send "Replay Sorcery is disabled"
else
    systemctl --user start replay-sorcery
    notify-send "Replay Sorcery is enabled"
fi
