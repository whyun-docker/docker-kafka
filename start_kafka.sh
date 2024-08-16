#! /bin/bash
mkdir -p /data/app/log/
rm -rf /var/run/kafka/kafka.pid
/data/config.sh

/etc/init.d/kafka start
RESTART_THRESHOLD=${RESTART_THRESHOLD:-10}
RESTART_COUNT=0
while [ $RESTART_COUNT -le "$RESTART_THRESHOLD" ]
do
    PID=$(cat $KAFKA_PIDFILE)
    if ps -p $PID > /dev/null
    then
        sleep 1
    else
        DATE=$(date '+%Y-%m-%d %H:%M:%S')
        echo "${DATE} ===kafka not running==="
        tail -100 /data/app/log/server.log
        RESTART_COUNT=$((RESTART_COUNT+1))
        echo "===restart kafka=== $RESTART_COUNT"
        /etc/init.d/kafka start
    fi
done
exit 1
