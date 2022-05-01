

## Credits
Heavily inspired by
https://github.com/aleonsan/ansible-kafka
https://github.com/sleighzy/ansible-kafka


confluents playbooks can be found here
https://github.com/confluentinc/cp-ansible/tree/7.0.1-post/playbooks

## Ansible insitallation Wsl

https://www.thomaspreischl.de/ansible-wsl-windows/

sudo apt-add-repository ppa:ansible/ansible
 sudo apt-get update
# sudo apt-get install ansible
 sudo apt install python3-pip
 sudo pip3 install pywinrm
 sudo pip3 install pyvmomi
 sudo pip3 install ansible
 sudo pip3 install ansible[azure]


 ## ssh

 ssh -i c:/users/mansa/.ssh/kafkavm  vmadmin@20.123.146.145
 ssh -i c:/users/mansa/.ssh/kafkavm  vmadmin@20.123.146.147
 ssh -i c:/users/mansa/.ssh/kafkavm  vmadmin@20.123.145.202
 


# ssh wsl 

ssh -i   /home/maak/.ssh/kafkavm  vmadmin@40.113.99.153
ssh -i   /home/maak/.ssh/kafkavm  vmadmin@40.118.127.16
ssh -i   /home/maak/.ssh/kafkavm  vmadmin@40.118.127.19
 
 
first time kafkavmcan be copied from /mnt/c/users/mansa/.ssh/kafkavm and then get correct rights with 
chmod 600 ~/.ssh/kafkavm

 ## start commands

 cd /etc/kafka
 sudo /usr/bin/zookeeper-server-start  /etc/kafka/zookeeper.properties

 sudo /usr/bin/kafka-server-start  /etc/kafka/server.properties

 export KAFKA_OPTS='-javaagent:/etc/kafka/exporter/jmx_prometheus_javaagent-0.13.0.jar=7070:/etc/kafka/exporter/config.yml'
 sudo /usr/bin/kafka-server-start  /etc/kafka/server.properties

 export KAFKA_OPTS="-javaagent:/etc/kafka/exporter/jmx_prometheus_javaagent-0.13.0.jar=7070:/etc/kafka/exporter/config.yml" sudo /usr/bin/kafka-server-start  /etc/kafka/server.properties

sudo export 
sudo EXTRA_ARGS=-javaagent:/etc/kafka/exporter/jmx_prometheus_javaagent-0.13.0.jar=7070:/etc/kafka/exporter/config.yml /usr/bin/kafka-server-start  /etc/kafka/server.properties

### connect
/usr/bin/connect-distributed /etc/kafka/connect.properties

### schema registry
sudo /usr/bin/schema-registry-start /etc/schema-registry/schema-registry.properties


## hosts
ssh -i ~/.ssh/kafkavm vmadmin@20.101.143.102
ssh -i ~/.ssh/kafkavm vmadmin@20.101.143.52
ssh -i ~/.ssh/kafkavm vmadmin@20.101.143.142
ssh -i ~/.ssh/kafkavm vmadmin@20.101.143.116
ssh -i ~/.ssh/kafkavm vmadmin@20.101.143.39


# connect with sshpass

yum install sshpass

sshpass -p 'x6&4BMaRdJ+B_h5Z' ssh -o StrictHostKeyChecking=no vmadmin@20.105.250.55
sshpass -p 'x6&4BMaRdJ+B_h5Z' ssh -o StrictHostKeyChecking=no vmadmin@20.105.249.201
sshpass -p 'x6&4BMaRdJ+B_h5Z' ssh -o StrictHostKeyChecking=no vmadmin@20.105.249.248



sshpass -p 'x6&4BMaRdJ+B_h5Z' ssh -o StrictHostKeyChecking=no vmadmin@20.234.165.137
sshpass -p 'x6&4BMaRdJ+B_h5Z' ssh -o StrictHostKeyChecking=no vmadmin@20.234.165.136
sshpass -p 'x6&4BMaRdJ+B_h5Z' ssh -o StrictHostKeyChecking=no vmadmin@20.234.163.143





## kafka commands
https://kafka.apache.org/quickstart

/usr/bin/kafka-topics  --create --topic test11 --bootstrap-server kafka1:9092 -replication-factor 2 --partitions 12
/usr/bin/kafka-topics --describe --topic test --bootstrap-server kafka1:9092
/usr/bin/kafka-console-producer --topic test11 --bootstrap-server kafka1:9092

/usr/bin/kafka-console-consumer --topic test --from-beginning --bootstrap-server kafka1:9092
/usr/bin/kafka-console-consumer --topic test11 --from-beginning --bootstrap-server 20.123.146.145:9092 --partition 0


## perf test commands
kafka-producer-perf-test --topic test11 --throughput -1 --num-records 1000000 --record-size 1024 --producer-props acks=all bootstrap.servers=kafka1:9092,kafka2:9092,kafka3:9092 --producer.config /path/to/ssl-perf-test.properties

kafka-producer-perf-test --topic test11 --throughput -1 --num-records 20000000 --record-size 1024 --producer-props acks=all bootstrap.servers=kafka1:9092,kafka2:9092,kafka3:9092 

kafka-producer-perf-test --topic test12 --throughput -1 --num-records 20000000 --record-size 1024 --producer-props acks=all bootstrap.servers=kafka1:9092,kafka2:9092,kafka3:9092 

kafka-producer-perf-test --topic test13 --throughput -1 --num-records 20000000 --record-size 1024 --producer-props acks=all bootstrap.servers=kafka1:9092,kafka2:9092,kafka3:9092 

kafka-producer-perf-test --topic test14 --throughput -1 --num-records 20000000 --record-size 1024 --producer-props acks=all bootstrap.servers=kafka1:9092,kafka2:9092,kafka3:9092 

kafka-producer-perf-test --topic test15 --throughput -1 --num-records 20000000 --record-size 1024 --producer-props acks=all bootstrap.servers=kafka1:9092,kafka2:9092,kafka3:9092 



/usr/bin/kafka-topics  --create --topic test12 --bootstrap-server kafka1:9092 -replication-factor 1 --partitions 15

/usr/bin/kafka-topics  --create --topic test13 --bootstrap-server kafka1:9092 -replication-factor 1 --partitions 15

/usr/bin/kafka-topics  --create --topic test14 --bootstrap-server kafka1:9092 -replication-factor 1 --partitions 15

/usr/bin/kafka-topics  --create --topic test15 --bootstrap-server kafka1:9092 -replication-factor 1 --partitions 15

/usr/bin/kafka-topics  --create --topic test16 --bootstrap-server kafka1:9092 -replication-factor 1 --partitions 15



kafka-producer-perf-test --topic test12 --throughput -1 --num-records 1000000 --record-size 1024 --producer-props acks=all bootstrap.servers=kafka1:9092,kafka2:9092,kafka3:9092


kafka-producer-perf-test --topic test13 --throughput -1 --num-records 10000000 --record-size 1024 --producer-props acks=all bootstrap.servers=kafka1:9092,kafka2:9092,kafka3:9092

kafka-producer-perf-test --topic test14 --throughput -1 --num-records 10000000 --record-size 1024 --producer-props acks=all bootstrap.servers=kafka1:9092,kafka2:9092,kafka3:9092

kafka-producer-perf-test --topic test15 --throughput -1 --num-records 10000000 --record-size 1024 --producer-props acks=all bootstrap.servers=kafka1:9092,kafka2:9092,kafka3:9092

kafka-producer-perf-test --topic test16 --throughput -1 --num-records 10000000 --record-size 1024 --producer-props acks=all bootstrap.servers=kafka1:9092,kafka2:9092,kafka3:9092

kafka-producer-perf-test --topic test17 --throughput -1 --num-records 10000000 --record-size 1024 --producer-props acks=all bootstrap.servers=kafka1:9092,kafka2:9092,kafka3:9092

kafka-producer-perf-test --topic test18 --throughput -1 --num-records 10000000 --record-size 1024 --producer-props acks=all bootstrap.servers=kafka1:9092,kafka2:9092,kafka3:9092

kafka-producer-perf-test --topic test19 --throughput -1 --num-records 10000000 --record-size 1024 --producer-props acks=all bootstrap.servers=kafka1:9092,kafka2:9092,kafka3:9092

kafka-producer-perf-test --topic test20 --throughput -1 --num-records 10000000 --record-size 1024 --producer-props acks=all bootstrap.servers=kafka1:9092,kafka2:9092,kafka3:9092

kafka-producer-perf-test --topic test21 --throughput -1 --num-records 10000000 --record-size 1024 --producer-props acks=all bootstrap.servers=kafka1:9092,kafka2:9092,kafka3:9092


https://developers.redhat.com/articles/2021/07/19/benchmarking-kafka-producer-throughput-quarkus#the_test_environment
https://strimzi.io/blog/2020/10/15/producer-tuning/


# why parititon???
/usr/bin/kafka-console-consumer --topic test11 --from-beginning --bootstrap-server kafka1:9092 --partition 0







 ## hosts file for playsgorund
 sudo nano /etc/hosts

add entry for
127.0.0.1 zookeeper1
127.0.0.1 kafka1


 ## run playbook from wsl

 - before running unlock localhost private keystore and add to ssh client in current session only
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/kafkavm

# adjusts disks before running vm
ansible-playbook main-vm.yml -i hosts
ansible-playbook main-tooling.yml -i hosts
ansible-playbook main-zookeeper.yml -i hosts
ansible-playbook main-kafka.yml -i hosts
ansible-playbook main-connect.yml -i hosts
ansible-playbook main-schema-registry.yml -i hosts


 ## Troubleshooting

### Trouble
 When running playbook this is received
 "[WARNING]: Ansible is being run in a world writable directory (/mnt/c/code/Vattenfall/kafkaansible/src/ansible), ignoring it as an
ansible.cfg source. For more information see https://docs.ansible.com/ansible/devel/reference_appendices/config.html#cfg-in-world-        
writable-dir"

Fix with chown to limit access


## WSL Ubuntu
update
sudo apt update


upgrade
sudo apt upgrade


## Docs refernces Ansible

Command vs Shell: https://linuxhint.com/shell-vs-command-modules-ansible/#:~:text=The%20shell%20module%20executes%20commands,executes%20on%20all%20selected%20nodes.


## chmod

sudo chmod -R u=rwx,g=rwx,o=rwx  kafka

## Running zookeeper as a service

systemd commands 
https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units

### start after reboot of vm
sudo systemctl enable kafka


### start

sudo systemctl start zookeeper.service

and 

    systemctl daemon-reload 

for releoading on cent os


folder: /etc/systemd/system
file: zookeeper.service

file content (see below):


[Unit]
Description=Confluent ZooKeeper
After=network.target network-online.target remote-fs.target

[Service]
Type=forking
User=root
Group=root
Environment="KAFKA_JMX_OPTS=-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=10020 -Dcom.sun.management.jmxremote.local.only=true -Dcom.sun.management.jmxremote.authenticate=false"
Environment="LOG_DIR=/var/log/zookeeper"
# Uncomment the following line to enable authentication for the zookeeper
# Environment="KAFKA_OPTS=-Djava.security.auth.login.config=/etc/kafka/zookeeper_server_jaas.conf -Djava.security.krb5.conf=/etc/krb5.conf"
ExecStart=/usr/bin/zookeeper-server-start -daemon /etc/kafka/zookeeper.properties
ExecStop=/usr/bin/zookeeper-server-stop
SuccessExitStatus=143

[Install]
WantedBy=multi-user.target


## running kafka as a service

for commands see zookeeper above

folder: /etc/systemd/system
file: kafka.service

[Unit]
Description=Confluent Kafka Broker
After=network.target network-online.target remote-fs.target zookeeper.service

[Service]
Type=forking
User=root
Group=root
Environment="KAFKA_JMX_OPTS=-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=10030 -Dcom.sun.management.jmxremote.local.only=true -Dcom.sun.management.jmxremote.authenticate=false"
Environment="LOG_DIR=/var/log/kafka"
# Uncomment the following line to enable authentication for the broker
# Environment="KAFKA_OPTS=-Djava.security.auth.login.config=/etc/kafka/kafka-jaas.conf -Djava.security.krb5.conf=/etc/krb5.conf"
ExecStart=/usr/bin/kafka-server-start -daemon /etc/kafka/server.properties
ExecStop=/usr/bin/kafka-server-stop
SuccessExitStatus=143

[Install]
WantedBy=multi-user.target


## running promethues as a service


## network security
az network nsg create --resource-group vfkafka-dev-wes-rg --location westeurope --name vfkafka-dev-wes-nsg
az network nsg rule create --resource-group vfkafka-dev-wes-rg --nsg-name vfkafka-dev-wes-nsg --name vfkafka-dev-wes-nsg-rule-2181 --protocol tcp --priority 1000 --destination-port-range 2181
az network nsg rule create --resource-group vfkafka-dev-wes-rg --nsg-name vfkafka-dev-wes-nsg --name vfkafka-dev-wes-nsg-rule-2181 --protocol tcp --priority 1000 --destination-port-range 22

az network vnet subnet update --resource-group vfkafka-dev-wes-rg --vnet-name vfkafka-dev-wes-vnet --name vfkafka-dev-wes-subnet-kafka --network-security-group vfkafka-dev-wes-nsg


## add news disks
https://docs.microsoft.com/en-us/azure/virtual-machines/linux/attach-disk-portal

lsblk // disk inventory 

partition new disk
sudo parted /dev/sdc --script mklabel gpt mkpart xfspart xfs 0% 100%
sudo mkfs.xfs /dev/sdc1
sudo partprobe /dev/sdc1

mount new disk
sudo mkdir /datadrive
sudo mount /dev/sdc1 /datadrive

reappear after reboot
sudo nano /etc/fstab



# prometheus (start with )

get local ip address
https://ipinfo.io/

need to open 9090 on promethues server

need to open 7070 on all kafka brokers so that prometheus can scrape

start kafka with agent
sudo EXTRA_ARGS=-javaagent:/etc/kafka/exporter/jmx_prometheus_javaagent-0.13.0.jar=7070:/etc/kafka/exporter/config.yml /usr/bin/kafka-server-start  /etc/kafka/server.properties


validate by checking that port is open
 sudo ss -tunelp | grep 7070

start prometheus server
 sudo /usr/local/bin/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/var/lib/prometheus --web.console.templates=/etc/prometheus/consoles --web.console.libraries=/etc/prometheus/console_libraries --web.listen-address=0.0.0.0:9090 --web.external-url=

need to open ports 9090 to access server


link promethues
https://computingforgeeks.com/monitor-apache-kafka-with-prometheus-and-grafana/


https://www.confluent.io/blog/monitor-kafka-clusters-with-prometheus-grafana-and-confluent/


# kafka connect 

curl commands examples
https://developer.confluent.io/learn-kafka/kafka-connect/rest-api/


http://www.openkb.info/2019/12/how-to-submit-rest-requests-to.html

delete
 curl -s -XDELETE "http://localhost:8083/connectors/name-of-connector"

 curl -s -XDELETE "http://localhost:8083/connectors/s3-sink-avro1"
 curl -s -XDELETE "http://localhost:8083/connectors/s3-sink-avro2"
 curl -s -XDELETE "http://localhost:8083/connectors/datagen-pageviews"
 


http data gen JSON example
curl -v -X POST http://localhost:8083/connectors -H "Content-Type: application/json" --data-binary @- << EOF
{
  "name": "datagen-pageviews",
  "config": {
    "connector.class": "io.confluent.kafka.connect.datagen.DatagenConnector",
    "kafka.topic": "pageviews",
    "quickstart": "pageviews",
    "key.converter": "org.apache.kafka.connect.storage.StringConverter",
    "value.converter": "org.apache.kafka.connect.json.JsonConverter",
    "value.converter.schemas.enable": "false",
    "max.interval": 100,
    "iterations": 10000,
    "tasks.max": "1"
  }
}
EOF


http data gen AVRO example
curl -v -X POST http://localhost:8083/connectors -H "Content-Type: application/json" --data-binary @- << EOF
{
  "name": "datagen-avro4",
  "config": {
    "connector.class": "io.confluent.kafka.connect.datagen.DatagenConnector",
    "kafka.topic": "datagen-avro4",
    "quickstart": "pageviews",
    "key.converter": "org.apache.kafka.connect.storage.StringConverter",
    "value.converter": "io.confluent.connect.avro.AvroConverter",        
    "value.converter.schemas.enable": "true",
    "value.converter.schema.registry.url": "http://localhost:7070",
    "max.interval": 100,
    "iterations": 10000,
    "tasks.max": "1"
  }
}
EOF









httpsgenreal example
curl -v -X POST https://v1.poc.com:8083/connectors \
--cacert /opt/mapr/conf/ssl_truststore.pem  -u mapr:mapr \
-H "Content-Type: application/json" \
--data-binary @- << EOF
{          
    "name": "mysql-source-dist",
    "config": {
      "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
      "tasks.max": "1",
      "connection.url": "jdbc:mysql://v4.poc.com:3306/hive?user=hive&password=hive",
      "table.whitelist": "TBLS",
      "mode": "incrementing",
      "incrementing.column.name": "TBL_ID",
      "topic.prefix": "/tmp/hivemeta:tbls"
 }
}
EOF

### s3 example JSON

curl -v -X POST http://localhost:8083/connectors -H "Content-Type: application/json" --data-binary @- << EOF
{
  "name": "s3-sink",
  "config": {
    "connector.class": "io.confluent.connect.s3.S3SinkConnector",
    "tasks.max": "1",
    "topics": "datagen-avro3",
    "s3.region": "eu-north-1",
    "s3.bucket.name": "sbabsparkdemo",
    "s3.part.size": "5242880",
    "flush.size": "1",
    "storage.class": "io.confluent.connect.s3.storage.S3Storage",
    "format.class": "io.confluent.connect.s3.format.json.JsonFormat",
    "schema.generator.class": "io.confluent.connect.storage.hive.schema.DefaultSchemaGenerator",
    "partitioner.class": "io.confluent.connect.storage.partitioner.DefaultPartitioner",
    "key.converter": "org.apache.kafka.connect.storage.StringConverter",
    "value.converter": "org.apache.kafka.connect.json.JsonConverter",
    "value.converter.schemas.enable": "false",
    "schema.compatibility": "NONE",
    "name": "s3-sink"
  }
}
EOF


### s3 example AVRO writeing to json

curl -v -X POST http://localhost:8083/connectors -H "Content-Type: application/json" --data-binary @- << EOF
{
  "name": "s3-sink-avro3",
  "config": {
    "connector.class": "io.confluent.connect.s3.S3SinkConnector",
    "tasks.max": "1",
    "topics": "datagen-avro3",
    "s3.region": "eu-north-1",
    "s3.bucket.name": "sbabsparkdemo",
    "s3.part.size": "5242880",
    "flush.size": "1000",
    "storage.class": "io.confluent.connect.s3.storage.S3Storage",
    "format.class": "io.confluent.connect.s3.format.json.JsonFormat",
    "schema.generator.class": "io.confluent.connect.storage.hive.schema.DefaultSchemaGenerator",
    "partitioner.class": "io.confluent.connect.storage.partitioner.DefaultPartitioner",
    "key.converter": "org.apache.kafka.connect.storage.StringConverter",
    "value.converter": "io.confluent.connect.avro.AvroConverter",        
    "value.converter.schemas.enable": "true",
    "value.converter.schema.registry.url": "http://localhost:7070",
    "name": "s3-sink-avro3"
  }
}
EOF


### s3 example AVRO writeing to parquet

curl -v -X POST http://localhost:8083/connectors -H "Content-Type: application/json" --data-binary @- << EOF
{
  "name": "s3-sink-avro4",
  "config": {
    "connector.class": "io.confluent.connect.s3.S3SinkConnector",
    "tasks.max": "1",
    "topics": "datagen-avro4",
    "s3.region": "eu-north-1",
    "s3.bucket.name": "sbabsparkdemo",
    "s3.part.size": "5242880",
    "flush.size": "1000",
    "storage.class": "io.confluent.connect.s3.storage.S3Storage",
    "format.class": "io.confluent.connect.s3.format.parquet.ParquetFormat",
    "schema.generator.class": "io.confluent.connect.storage.hive.schema.DefaultSchemaGenerator",
    "partitioner.class": "io.confluent.connect.storage.partitioner.DefaultPartitioner",
    "key.converter": "org.apache.kafka.connect.storage.StringConverter",
    "value.converter": "io.confluent.connect.avro.AvroConverter",        
    "value.converter.schemas.enable": "true",
    "value.converter.schema.registry.url": "http://localhost:7070",
    "name": "s3-sink-avro4"
  }
}
EOF


kafka-topics --bootstrap-server=kafka1:9092 --describe --topic "datagen-avro4"


