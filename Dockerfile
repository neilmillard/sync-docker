# BitTorrent Sync
#
# VERSION               0.1

# AlpineLinux with glibc
#  -  https://www.gnu.org/software/libc/
#  -  https://github.com/andyshinn/alpine-pkg-glibc

FROM alpine:latest
MAINTAINER Neil Millard <neil@neilmillard.com>
ENV GLIBC_VERSION 2.23-r1
RUN apk add --update curl ca-certificates bash && \
    curl -o /tmp/glibc.apk -L "https://github.com/andyshinn/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk" && \
    apk add --allow-untrusted /tmp/glibc.apk && \
    curl -o /tmp/glibc-bin.apk -L "https://github.com/andyshinn/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk" && \
    apk add --allow-untrusted /tmp/glibc-bin.apk && \
    /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc/usr/lib && \
    rm -rf /tmp/* /var/cache/apk/* &&  \
    echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf

LABEL com.getsync.version="2.3.3"

ADD https://download-cdn.getsync.com/2.3.3/linux-x64/BitTorrent-Sync_x64.tar.gz /tmp/sync.tgz
RUN tar -xzf /tmp/sync.tgz -C /usr/sbin btsync && rm -f /tmp/sync.tgz

COPY btsync.conf /etc/
COPY run_sync /opt/
RUN mkdir -p /var/run/btsync && \
	mkdir -p /mnt/sync/folders && \
	mkdir -p /mnt/sync/config

EXPOSE 8888
EXPOSE 55555

VOLUME /mnt/sync

ENTRYPOINT ["/opt/run_sync"]
CMD ["--log", "--config", "/etc/btsync.conf"]
