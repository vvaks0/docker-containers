#!/bin/sh

# Optional ENV variables:
# * ADVERTISED_HOST: the external ip for the container, e.g. `docker-machine ip \`docker-machine active\``
# * ADVERTISED_PORT: the external port for Kafka, e.g. 9092
# * ZK_CHROOT: the zookeeper chroot that's used by Kafka (without / prefix), e.g. "kafka"
# * LOG_RETENTION_HOURS: the minimum age of a log file in hours to be eligible for deletion (default is 168, for 1 week)
# * LOG_RETENTION_BYTES: configure the size at which segments are pruned from the log, (default is 1073741824, for 1GB)
# * NUM_PARTITIONS: configure the default number of log partitions per topic

# Configure advertised host/port if we run in helios
#if [ ! -z "$HELIOS_PORT_kafka" ]; then
#    ADVERTISED_HOST=`echo $HELIOS_PORT_kafka | cut -d':' -f 1 | xargs -n 1 dig +short | tail -n 1`
#    ADVERTISED_PORT=`echo $HELIOS_PORT_kafka | cut -d':' -f 2`
#fi
#listeners=PLAINTEXT://ADVERTISED_HOST:ADVERTISED_PORT
#advertised.listeners=PLAINTEXT://ADVERTISED_HOST:ADVERTISED_PORT

tee $KAFKA_HOME/config/server.properties <<-'EOF'
advertised.host.name=ADVERTISED_HOST
advertised.port=ADVERTISED_PORT
advertised.listeners=PLAINTEXT://ADVERTISED_HOST:ADVERTISED_PORT
num.partitions=1
log.retention.hours=1
log.retention.bytes=1000000000
zookeeper.connect=localhost:2181
delete.topic.enable=true
EOF

#ADVERTISED_HOST=$(ifconfig -a eth0 |grep -Po 'inet ([0-9.]+)'|grep -Po '([0-9.]+)')
ADVERTISED_HOST=$CONTAINER_HOST
# Set the external host and port
echo "advertised host: $ADVERTISED_HOST"
sed -r -i "s;ADVERTISED_HOST;$ADVERTISED_HOST;" $KAFKA_HOME/config/server.properties
#sed -r -i "s/#(advertised.host.name)=(.*)/\1=$ADVERTISED_HOST/g" $KAFKA_HOME/config/server.properties

ADVERTISED_PORT=$BROKER_PORT
echo "advertised port: $ADVERTISED_PORT"
sed -r -i "s;ADVERTISED_PORT;$ADVERTISED_PORT;" $KAFKA_HOME/config/server.properties
#sed -r -i "s/#(advertised.port)=(.*)/\1=$ADVERTISED_PORT/g" $KAFKA_HOME/config/server.properties

# wait for zookeeper to start up
nohup $KAFKA_HOME/bin/zookeeper-server-start.sh $KAFKA_HOME/config/zookeeper.properties >> zookeeper.log &
sleep 5

LOG_RETENTION_HOURS=1
# Allow specification of log retention policies
    echo "log retention hours: $LOG_RETENTION_HOURS"
    sed -r -i "s/(log.retention.hours)=(.*)/\1=$LOG_RETENTION_HOURS/g" $KAFKA_HOME/config/server.properties

LOG_RETENTION_BYTES=1000000000
    echo "log retention bytes: $LOG_RETENTION_BYTES"
    sed -r -i "s/#(log.retention.bytes)=(.*)/\1=$LOG_RETENTION_BYTES/g" $KAFKA_HOME/config/server.properties

NUM_PARTITIONS=1
# Configure the default number of log partitions per topic
    echo "default number of partition: $NUM_PARTITIONS"
    sed -r -i "s/(num.partitions)=(.*)/\1=$NUM_PARTITIONS/g" $KAFKA_HOME/config/server.properties

# Enable/disable auto creation of topics
if [ ! -z "$AUTO_CREATE_TOPICS" ]; then
    echo "auto.create.topics.enable: $AUTO_CREATE_TOPICS"
    echo "auto.create.topics.enable=$AUTO_CREATE_TOPICS" >> $KAFKA_HOME/config/server.properties
fi

# Run Kafka
$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties
