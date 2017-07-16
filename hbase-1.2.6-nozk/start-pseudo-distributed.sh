#!/bin/bash

# Set the external zookeeper host and port based on environment variables passed into the container

echo "zookeeper hosts: $ZK_HOST_IP"

echo "zookeeper hostnames: $ZK_HOSTNAME"
sed -r -i "s;ZK_HOSTNAME;$ZK_HOSTNAME;" /opt/hbase/conf/hbase-site.xml

echo "zookeeper port: $ZK_PORT"
sed -r -i "s;ZK_PORT;$ZK_PORT;" /opt/hbase/conf/hbase-site.xml

#cat /etc/hosts|sed '/'"$ZK_HOSTNAME"'/d' > /etc/hosts
echo "$ZK_HOST_IP $ZK_HOSTNAME" >> /etc/hosts

#IFS=', ' read -r -a ZK_HOST_IP <<< "$ZK_HOST_IP"
#for ZK_HOST in $(echo $ZK_HOSTNAME | sed "s/,/ /g")
#do
#    echo "$ZK_HOST"
#done

/opt/hbase/bin/hbase regionserver start > logregion.log 2>&1 &

/opt/hbase/bin/hbase master start --localRegionServers=0
