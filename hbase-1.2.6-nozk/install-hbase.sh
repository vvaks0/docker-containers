#! /bin/bash

wget http://apache.mirrors.pair.com/hbase/1.2.6/hbase-1.2.6-bin.tar.gz
tar xzf hbase-1.2.6-bin.tar.gz -C /opt/
mv /opt/hbase-1.2.6 /opt/hbase

rm hbase-1.2.6-bin.tar.gz
