# kafka 镜像

本地测试用的 kafka 镜像，基于最新版本的 kafka 安装包构建，去除了 zookeeper 的依赖。

镜像中数据文件目录设定为 `/data/kafka-logs` 。

## 镜像 tag

yunnysunny/kafka:${KAFKA_VERSION}

当前支持的版本有

- 3.3.1
- 3.3.2
- 3.4.1
- 3.5.0
- 3.5.1

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
