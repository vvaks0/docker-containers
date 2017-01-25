#! /bin/bash

wget --quiet http://www-us.apache.org/dist/hbase/1.1.8/hbase-1.1.8-bin.tar.gz
tar xzf hbase-1.1.8-bin.tar.gz -C /opt/
ln -s /opt/hbase-1.1.8 /opt/hbase

rm hbase-1.1.8-bin.tar.gz
