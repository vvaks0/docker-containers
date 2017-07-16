#!/bin/bash

wget http://apache.mirrors.pair.com/phoenix/apache-phoenix-4.9.0-HBase-1.2/bin/apache-phoenix-4.9.0-HBase-1.2-bin.tar.gz
tar -xzf apache-phoenix-4.9.0-HBase-1.2-bin.tar.gz
rm -f apache-phoenix-4.9.0-HBase-1.2-bin.tar.gz
ln -s /opt/apache-phoenix-4.9.0-HBase-1.2-bin /opt/phoenix

cp /opt/phoenix/phoenix-4.9.0-HBase-1.2-server.jar /opt/hbase/lib/
cp /opt/phoenix/phoenix-core-4.9.0-HBase-1.2.jar /opt/hbase/lib/

