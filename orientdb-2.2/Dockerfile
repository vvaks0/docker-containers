FROM centos:7

RUN yum install -y java-1.8.0-openjdk.x86_64
ENV JAVA_HOME=/usr/lib/jvm/jre
ENV ORIENTDB_VERSION 2.2.14
ENV ORIENTDB_DOWNLOAD_URL ${ORIENTDB_DOWNLOAD_SERVER:-http://central.maven.org/maven2/com/orientechnologies}/orientdb-community/$ORIENTDB_VERSION/orientdb-community-$ORIENTDB_VERSION.tar.gz

RUN yum install -y wget
RUN yum install -y nc
RUN yum install -y tar

WORKDIR /opt
RUN mkdir /opt/orientdb
RUN wget  $ORIENTDB_DOWNLOAD_URL
RUN tar -xvzf orientdb-community-$ORIENTDB_VERSION.tar.gz -C /opt/orientdb --strip-components=1
RUN rm orientdb-community-$ORIENTDB_VERSION.tar.gz
RUN rm -rf /orientdb/databases/*

ENV PATH /opt/orientdb/bin:$PATH

VOLUME ["/opt/orientdb/backup", "/opt/orientdb/databases", "/opt/orientdb/config"]

WORKDIR /opt/orientdb

#OrientDb binary
EXPOSE 2424

#OrientDb http
EXPOSE 2480

# Default command start the server
CMD ["server.sh"]