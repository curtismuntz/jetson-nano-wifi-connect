#!/usr/bin/env bash

# export DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket

# wget --spider http://google.com 2>&1
# 4. Is there an active WiFi connection?
iwgetid -r


if [ $? -eq 0 ]; then
    printf 'Skipping WiFi Connect\n'
else
    printf 'Starting WiFi Connect\n'
    ./wifi-connect --portal-interface=wlan0 --portal-ssid TEGRA
fi

printf 'WiFi-Connect successful.\n'
sleep infinity
