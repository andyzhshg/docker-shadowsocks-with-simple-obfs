FROM alpine:latest

RUN apk update && apk add --no-cache build-base git autoconf automake gettext pcre-dev libtool asciidoc xmlto udns-dev c-ares-dev libev-dev libsodium-dev mbedtls-dev linux-headers privoxy && \
    git clone https://github.com/shadowsocks/shadowsocks-libev /tmp/shadowsocks-libev && \
    cd /tmp/shadowsocks-libev && git submodule update --init --recursive && \
    ./autogen.sh && ./configure && make && make install  && \
    git clone https://github.com/shadowsocks/simple-obfs.git /tmp/simple-obfs && \
    cd /tmp/simple-obfs && git submodule update --init --recursive && \
    ./autogen.sh && ./configure && make && make install  && \
    apk del build-base git autoconf automake gettext libtool asciidoc xmlto linux-headers && \
    rm -rf /tmp/shadowsocks-libev && rm -rf /tmp/simple-obfs

ADD privoxy.config /etc/privoxy/config
ADD ss_local.sh /ss_local.sh

EXPOSE 1086/tcp
EXPOSE 1087/tcp

CMD ["/ss_local.sh"]
