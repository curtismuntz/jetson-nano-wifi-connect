This repo contains an example of how to use [balena's wifi-connect](https://github.com/balena-io/wifi-connect) project from a container to auto-configure your Nvidia Jetson Nano's wifi. Theoretically, this container should be portable to the other Jetson devices (TX1/TX2) but from my testing it will not work out of the box using the built-in Broadcom WiFi chipset on the TX1 and TX2.

This container currently checks if it is able to reach http://google.com for its condition to start the wifi-connect software. In the event google is un-pingable, it will begin hosting its own access point providing the user a location to enter SSID/password credentials. Once configured, it will sleep indefinitely.

# Run manually
This container can be ran via:

```!bash
docker run --rm -it \
      --privileged \
      --network=host \
      --name=wifi-connect \
      -v /run/dbus:/host/run/dbus/system_bus_socket \
      murtis/jetson-wifi-connect
```

Alternatively, you can add this to your `docker-compose.yml` file and bring up all your containers as part of one command.

```!bash
docker-compose up
```

# Run automatically
You can set up a systemd service that will call docker at boot. An example would look similar to the following (making a file called `/etc/systemd/system/jetson-wifi-connect.service`:

```!bash
# /etc/systemd/system/jetson-wifi-connect.service

[Unit]
Description=Jetson Wifi-connect Service
Requires=docker.service
After=docker.service

[Service]
# Install the docker compose script here.
WorkingDirectory=/opt/jetson-wifi-conect
ExecStart=/usr/bin/docker-compose up
ExecStop=/usr/bin/docker-compose down
TimeoutStartSec=0
Restart=on-failure
StartLimitIntervalSec=60
StartLimitBurst=3

[Install]
WantedBy=multi-user.target
```

Note that this service calls the compose file from the `/opt/jetson-wifi-connect` directory. You'll need to make that directory and copy the `docker-compose.yml` file there.

This service can then be enabled by: `sudo systemctl enable jetson-wifi-connect`


# TODO
* User providable wifi config checks
* User providable sleep duration
