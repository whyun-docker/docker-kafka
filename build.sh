#!/bin/bash
set -e

export KAFKA_VERSION=3.3.2
TAG_LATEST=yunnysunny/kafka:latest
TAG_CURRENT=yunnysunny/kafka:${KAFKA_VERSION}

docker pull yunnysunny/jre
docker build . -f ./Dockerfile -t ${TAG_LATEST} -t ${TAG_CURRENT} \
--build-arg KAFKA_VERSION=${KAFKA_VERSION}
if [ "$NEED_PUSH" = "1" ] ; then
    docker push ${TAG_LATEST}
    docker push ${TAG_CURRENT}
fi