#!/bin/bash
set -e
source ../scripts/read_param.sh

export KAFKA_VERSION=3.1.0
TAG_LATEST=yunnysunny/kafka-single:latest
TAG_CURRENT=yunnysunny/kafka-single:${KAFKA_VERSION}

docker pull registry.cn-hangzhou.aliyuncs.com/whyun/base:zookeeper-3.7.0
docker build . -f ./single.Dockerfile -t ${TAG_LATEST} -t ${TAG_CURRENT} --build-arg KAFKA_VERSION=${KAFKA_VERSION}
if [ "$NEED_PUSH" = "1" ] ; then
    docker push ${TAG_LATEST}
    docker push ${TAG_CURRENT}
fi