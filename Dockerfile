FROM ubuntu:18.04

ENV CONFLUENT_VERSION=5.0 \
    JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64


# install pre-requisites and Confluent
RUN set -x \
    && apt-get update \
    && apt-get install -y openjdk-8-jre-headless wget netcat-openbsd software-properties-common \
    && wget -qO - http://packages.confluent.io/deb/$CONFLUENT_VERSION/archive.key | apt-key add - \
    && add-apt-repository "deb [arch=amd64] http://packages.confluent.io/deb/$CONFLUENT_VERSION stable main" \
    && apt-get update \
    && apt-get install -y confluent-platform-oss-2.11 \
    && apt-get install xz-utils

ADD confluent-hub-client-latest.tar.gz /tmp/KAFKACONNECT && tar -C /tmp/ -xf /tmp/confluent-hub-client-latest.tar.gz

RUN cd /tmp/confluent-hub-client-latest/bin

RUN confluent-hub install confluentinc/kafka-connect-jdbc:latest
