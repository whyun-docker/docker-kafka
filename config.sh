#!/bin/bash

echo "Configuration..."
. /data/util.sh

INSTALL_DIR=/opt
KAFKA_DIR=$INSTALL_DIR/kafka
export KAFKA_CONF_FILE=$KAFKA_DIR/config/server.properties
if [ "$KAFKA_DATA_DIR" != "" ] ; then
    kafka_server_conf_set log.dirs "$KAFKA_DATA_DIR"
fi
if [ "$KAFKA_LISTENERS" != "" ] ; then
    kafka_server_conf_set listeners "$KAFKA_LISTENERS"
fi
if [ "$KAFKA_ADVERTISED_LISTENERS" != "" ] ; then
    kafka_server_conf_set advertised.listeners "$KAFKA_ADVERTISED_LISTENERS"
fi