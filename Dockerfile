FROM yunnysunny/zookeeper:3.7.1

ARG KAFKA_VERSION

COPY install_kafka.sh /data/install_kafka.sh
RUN /data/install_kafka.sh

COPY config.sh /data/config.sh
COPY util.sh /data/util.sh
ARG KAFKA_DATA_DIR=/data/kafka-logs
ARG KAFKA_LISTENERS=PLAINTEXT://:9092
ARG KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://localhost:9092
RUN /data/config.sh

COPY kafka /etc/init.d/kafka

COPY start_kafka.sh /start.sh
ENV LOG_DIR=/data/app/log
ENV KAFKA_PIDFILE=/var/run/kafka/kafka.pid
CMD [ "/start.sh" ]