#!/bin/sh

if [ ${PROXY_IP} ]
then
    cat /redsocks.conf.tpl | sed "s/PROXY_IP/${PROXY_IP}/" | sed "s/PROXY_PORT/${PROXY_PORT}/" > /redsocks.conf

    # clear all existing rules
    iptables -F

    # do not redirect proxy provider
    iptables -t nat -A OUTPUT -d ${PROXY_IP} -j RETURN

    # do not redirect local access
    iptables -t nat -A OUTPUT -d 10.0.0.0/8 -j RETURN
    iptables -t nat -A OUTPUT -d 172.16.0.0/16 -j RETURN
    iptables -t nat -A OUTPUT -d 192.168.0.0/16 -j RETURN
    iptables -t nat -A OUTPUT -d 127.0.0.0/8 -j RETURN
    iptables -t nat -A OUTPUT -d 0.0.0.0/8 -j RETURN
    iptables -t nat -A OUTPUT -d 169.254.0.0/16 -j RETURN
    iptables -t nat -A OUTPUT -d 224.0.0.0/4 -j RETURN
    iptables -t nat -A OUTPUT -d 240.0.0.0/4 -j RETURN

    # redirect all other accesses to redsocks service
    iptables -t nat -A OUTPUT -p tcp -j REDIRECT --to-ports 12345

    # run redsocks
    redsocks -c /redsocks.conf &    
fi

PLUGIN_ARG=""
if [ ${PLUGIN} ]
then
    PLUGIN_ARG="--plugin ${PLUGIN}"
fi

PLUGIN_OPS_ARG=""
if [ ${PLUGIN_OPS} ]
then
    PLUGIN_OPS_ARG="--plugin-opts ${PLUGIN_OPS}"
fi

privoxy --no-daemon /etc/privoxy/config &

ss-local -b 0.0.0.0 -l 1086 \
    -s ${SERVER_HOST} \
    -p ${SERVER_PORT} \
    -k ${PASSWORD} \
    -m ${METHOD} \
    ${PLUGIN_ARG} \
    ${PLUGIN_OPS_ARG}
