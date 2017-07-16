FROM centos:7

RUN yum install -y java-1.8.0-openjdk.x86_64
ENV JAVA_HOME=/usr/lib/jvm/jre
ENV HBASE_MANAGES_ZK=false

RUN yum install -y wget
RUN yum install -y nc
RUN yum install -y tar

WORKDIR /opt

ADD ./install-hbase.sh /opt
RUN ./install-hbase.sh

RUN /opt/hbase/bin/hbase-config.sh

ADD hbase-site.xml /opt/hbase/conf/hbase-site.xml
ADD start-pseudo-distributed.sh /opt/hbase/bin/start-pseudo-distributed.sh

# HBase Master API port
EXPOSE 60000
# HBase Master Web UI
EXPOSE 60010
# Regionserver API port
EXPOSE 60020
# HBase Regionserver web UI
EXPOSE 60030

WORKDIR /opt/hbase/bin

ENV PATH=$PATH:/opt/hbase/bin

CMD /opt/hbase/bin/start-pseudo-distributed.sh
