#!/bin/bash
umask 002
echo "::10" > /config/auth
sleep 60 && \
    deluge-console -c /config \
        "config -s listen_interface $(ip route get 1 | awk '{print $7;exit}')" && \
    [ -e /var/run/pia/pia_port ] && \
        deluge-console -c /config \
            "config -s listen_ports ($(cat /var/run/pia/pia_port), $(cat /var/run/pia/pia_port))" &
deluge-web --fork --config /config
deluged -d -L info --config /config
