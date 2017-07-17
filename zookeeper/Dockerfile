FROM centos:7

RUN yum install -y java-1.8.0-openjdk.x86_64
ENV JAVA_HOME=/usr/lib/jvm/jre

RUN yum install -y wget
RUN yum install -y nc
RUN yum install -y tar

WORKDIR /opt

# zookeeper
EXPOSE 2181

ARG MIRROR=http://apache.mirrors.pair.com
ARG VERSION=3.4.10

LABEL name="zookeeper" version=$VERSION

RUN wget $MIRROR/zookeeper/zookeeper-$VERSION/zookeeper-$VERSION.tar.gz
RUN tar -xzf zookeeper-$VERSION.tar.gz -C /opt
RUN mv /opt/zookeeper-$VERSION /opt/zookeeper
RUN cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg
RUN mkdir -p /tmp/zookeeper

EXPOSE 2181

WORKDIR /opt/zookeeper

VOLUME ["/opt/zookeeper/conf", "/tmp/zookeeper"]

ENTRYPOINT ["/opt/zookeeper/bin/zkServer.sh"]
CMD ["start-foreground"]