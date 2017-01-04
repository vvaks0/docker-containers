#!/bin/bash

wget --quiet http://mirror.cogentco.com/pub/apache/phoenix/apache-phoenix-4.9.0-HBase-1.2/bin/apache-phoenix-4.9.0-HBase-1.2-bin.tar.gz
tar -xzf apache-phoenix-4.9.0-HBase-1.2-bin.tar.gz
rm -f apache-phoenix-4.9.0-HBase-1.2-bin.tar.gz
ln -s /opt/apache-phoenix-4.9.0-HBase-1.2-bin /opt/phoenix

cp /opt/phoenix/phoenix-server-4.9.0-HBase-1.2.jar /opt/hbase/lib/
cp /opt/phoenix/phoenix-core-4.9.0-HBase-1.2.jar /opt/hbase/lib/
