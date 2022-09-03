# kafka 镜像

本地测试用的 kafka 镜像，将 kafka 和 zookeeper 打入到一个镜像中，父镜像基于 yunnysunny/zookeeper。支持在 zookeeper 端口监听完成之后再开始启动 kafka，解决由于 zookeeper 未启动完成导致 kafka 初始化启动报错的问题。

镜像中数据文件目录设定为 `/data/kafka-logs` 。

目前仅支持通过 localhost 进行访问，不支持

## 镜像 tag

yunnysunny/kafka:${KAFKA_VERSION}

当前支持的版本有

- 3.2.1

## 使用方法

```shell
docker run --name yk -p 9092:9092 yunnysunny/kafka
```