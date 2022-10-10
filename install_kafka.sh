#!/bin/bash
#title          :kafka_install.sh
#description    :The script to install kafka
#author         :Motty Cohen
#date           :05-Feb-2015
#usage          :/bin/bash install_kafka.sh

#KAFKA_VERSION=$1
KAFKA_FILENAME=kafka_2.13-$KAFKA_VERSION
KAFKA_ARCHIVE_NAME=$KAFKA_FILENAME.tgz

#https://mirrors.tuna.tsinghua.edu.cn/apache/kafka/2.7.0/kafka_2.13-2.7.0.tgz
KAFKA_DOWNLOAD_ADDRESS=https://mirrors.tuna.tsinghua.edu.cn/apache/kafka/$KAFKA_VERSION/$KAFKA_ARCHIVE_NAME

KAFKA_FULL_DIR=$INSTALL_DIR/$KAFKA_FILENAME
KAFKA_SERVICE=kafka

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root."
   exit 1
fi

echo "Downloading: $KAFKA_DOWNLOAD_ADDRESS..."
[ -e "$KAFKA_ARCHIVE_NAME" ] && echo 'kafka archive already exists.'
if [ ! -e "$KAFKA_ARCHIVE_NAME" ]; then
  wget -q $KAFKA_DOWNLOAD_ADDRESS
  if [ $? -ne 0 ]; then
    echo "Not possible to download kafka."
    exit 1
  fi
fi

echo "Cleaning up..."
rm -f "$KAFKA_HOME"
rm -rf "$KAFKA_FULL_DIR"
rm -rf "/var/run/$KAFKA_SERVICE/"
rm -f "/etc/init.d/$KAFKA_SERVICE"

echo "Installation to $KAFKA_FULL_DIR ..."
mkdir $KAFKA_FULL_DIR
tar -zxvf $KAFKA_ARCHIVE_NAME -C $INSTALL_DIR

echo "Creating symbolic link: to $KAFKA_HOME ..."
ln -s $KAFKA_FULL_DIR/ $KAFKA_HOME


echo "Cleaning archive..."
rm -f "$KAFKA_ARCHIVE_NAME"

echo "Generate config file..."
/data/config.sh
cat $KAFKA_HOME/config/kraft/server.properties

echo "Formatting log dir..."
KAFKA_CLUSTER_ID="$($KAFKA_HOME/bin/kafka-storage.sh random-uuid)"
$KAFKA_HOME/bin/kafka-storage.sh format -t $KAFKA_CLUSTER_ID \
  -c $KAFKA_HOME/config/kraft/server.properties
