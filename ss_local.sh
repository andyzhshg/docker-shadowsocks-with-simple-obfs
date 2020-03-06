#!/bin/sh

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
