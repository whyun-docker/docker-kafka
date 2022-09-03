# kafka 镜像

本地测试用的 kafka 镜像，将 kafka 和 zookeeper 打入到一个镜像中，父镜像基于 yunnysunny/zookeeper。支持在 zookeeper 端口监听完成之后再开始启动 kafka，解决由于 zookeeper 未启动完成导致 kafka 初始化启动报错的问题。

镜像中数据文件目录设定为 `/data/kafka-logs` 。

## 镜像 tag

yunnysunny/kafka:${KAFKA_VERSION}

当前支持的版本有

- 3.2.1

## 使用方法

默认支持在本地使用，通过如下命令启动

```shell
docker run --name yk -p 9092:9092 yunnysunny/kafka
```

然后在宿主机中通过如下命令即可往 test 的 topic 写入数据

```shell
bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test
```

如果通过局域网或者公网访问，需要通过如下命令指定 kafka 对外暴漏的访问地址

```shell
docker run --name ykr -p your_port:9092 -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://your_ip:your_port yunnysunny/kafka
```

然后在远程机器上通过如下命令即可往 test 的 topic 写入数据

```shell
bin/kafka-console-producer.sh --broker-list your_ip:your_port --topic test
```
