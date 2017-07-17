FROM centos:7
ENV SCALA_VERSION 2.10
ENV KAFKA_VERSION 0.10.2.0
ENV KAFKA_HOME /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"

RUN yum install -y wget
RUN yum install -y iproute
RUN yum install -y net-tools
RUN yum install -y java-1.8.0-openjdk.x86_64

RUN wget -q http://apache.mirrors.spacedump.net/kafka/"$KAFKA_VERSION"/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -O /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz
RUN tar xfz /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -C /opt
RUN rm /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz

ADD scripts/start-kafka.sh /usr/bin/start-kafka.sh

EXPOSE 9092

CMD start-kafka.sh
