#!/bin/bash

echo "Configuration..."
. /data/util.sh

INSTALL_DIR=/opt
KAFKA_DIR=$INSTALL_DIR/kafka
export KAFKA_CONF_FILE=$KAFKA_DIR/config/server.properties
kafka_server_conf_set log.dirs "$KAFKA_DATA_DIR"