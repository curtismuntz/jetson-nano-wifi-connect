# From https://github.com/balena-io/wifi-connect/blob/master/Dockerfile.template
#FROM resin/%%RESIN_MACHINE_NAME%%-debian
FROM balenalib/aarch64-debian

RUN [ "cross-build-start" ]

RUN install_packages dnsmasq wireless-tools wget

WORKDIR /usr/src/app

RUN curl https://api.github.com/repos/balena-io/wifi-connect/releases/latest -s \
    | grep -hoP 'browser_download_url": "\K.*aarch64\.tar\.gz' \
    | xargs -n1 curl -Ls \
    | tar -xvz -C /usr/src/app/

COPY start.sh .

CMD ["bash", "start.sh"]
RUN [ "cross-build-end" ]
