#! /bin/bash
mkdir -p /data/app/log/
rm -rf /var/run/kafka/kafka.pid

/etc/init.d/zookeeper start
/etc/init.d/kafka start
