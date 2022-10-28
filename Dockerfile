FROM yunnysunny/jre

ARG KAFKA_VERSION
ARG INSTALL_DIR=/opt
ARG KAFKA_HOME=${INSTALL_DIR}/kafka
RUN mkdir -p /data
RUN apt-get update && apt-get install --no-install-recommends wget tzdata -y && apt-get clean
ARG KAFKA_DATA_DIR=/data/kafka-logs
ARG KAFKA_LISTENERS=PLAINTEXT://:9092,CONTROLLER://:9093
ARG KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://localhost:9092
COPY install_kafka.sh /data/install_kafka.sh
COPY config.sh /data/config.sh
COPY util.sh /data/util.sh
RUN /data/install_kafka.sh

COPY kafka /etc/init.d/kafka

COPY start_kafka.sh /start.sh
ENV LOG_DIR=/data/app/log
ENV KAFKA_PIDFILE=/var/run/kafka/kafka.pid
ENV KAFKA_HOME=${KAFKA_HOME}
# 使用东八区时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
CMD [ "/start.sh" ]
