# Create input-topic and produce sample data (on docker host)
export KAFKA_HEAP_OPTS="-Xmx1g" 
kafka-topics --zookeeper localhost:2181 --list
kafka-topics --zookeeper localhost:2181 --create --topic data-input --partitions 10 --replication-factor 2
kafka-topics --zookeeper localhost:2181 --create --topic data-output --partitions 1 --replication-factor 2
kafka-console-producer --bootstrap-server localhost:19092 --topic input-topic

# Build docker image and run it
docker build --tag pakala27/kafka-cli:v1 .

docker run -it --add-host zookeeper:172.17.0.1 --add-host kafka1:172.17.0.1 --add-host kafka2:172.17.0.1 --name kafka-cli pakala27/kafka-cli:v1 bash
docker run  --add-host zookeeper:172.17.0.1 --add-host kafka1:172.17.0.1 --add-host kafka2:172.17.0.1 --name kafka-cli pakala27/kafka-cli:v1 

# Delete topic and reset consumer group to earliest
kafka-topics --zookeeper localhost:2181  --delete --topic data-output
kafka-consumer-groups --bootstrap-server localhost:19092 --describe --group grp1
kafka-consumer-groups --bootstrap-server localhost:19092 --reset-offsets --to-earliest --group grp1 --topic input-topic --execute
