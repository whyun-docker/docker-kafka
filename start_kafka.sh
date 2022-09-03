#! /bin/bash
mkdir -p /data/app/log/
rm -rf /var/run/kafka/kafka.pid
/data/config.sh

/etc/init.d/zookeeper start
/etc/init.d/kafka start

while true
do
    PID=$(cat $KAFKA_PIDFILE)
    if ps -p $PID > /dev/null
    then
        sleep 1
    else
        echo "kafka not running"
        exit 1
    fi
done
