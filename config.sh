#!/bin/bash
DATE=$(date '+%Y-%m-%d %H:%M:%S')
echo "${DATE} Configuration..."
. /data/util.sh

export KAFKA_CONF_FILE=$KAFKA_HOME/config/kraft/server.properties
if [ "$KAFKA_DATA_DIR" != "" ] ; then
    kafka_server_conf_set log.dirs "$KAFKA_DATA_DIR"
fi
if [ "$KAFKA_LISTENERS" != "" ] ; then
    kafka_server_conf_set listeners "$KAFKA_LISTENERS"
fi
if [ "$KAFKA_ADVERTISED_LISTENERS" != "" ] ; then
    kafka_server_conf_set advertised.listeners "$KAFKA_ADVERTISED_LISTENERS"
fi