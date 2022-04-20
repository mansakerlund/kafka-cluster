

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

ssh -i   /home/maak/.ssh/kafkavm  vmadmin@40.118.127.23
ssh -i   /home/maak/.ssh/kafkavm  vmadmin@40.118.127.16
ssh -i   /home/maak/.ssh/kafkavm  vmadmin@40.118.127.19
 
 
first time kafkavmcan be copied from /mnt/c/users/mansa/.ssh/kafkavm and then get correct rights with 
chmod 600 ~/.ssh/kafkavm

 ## start commands

 cd /etc/kafka
 /usr/bin/zookeeper-server-start  /etc/kafka/zookeeper.properties
 /usr/bin/kafka-server-start  /etc/kafka/server.properties

## kafka commands
https://kafka.apache.org/quickstart

/usr/bin/kafka-topics  --create --topic test11 --bootstrap-server kafka1:9092 -replication-factor 1 --partitions 3
/usr/bin/kafka-topics --describe --topic test --bootstrap-server kafka1:9092
/usr/bin/kafka-console-producer --topic test11 --bootstrap-server kafka1:9092

/usr/bin/kafka-console-consumer --topic test --from-beginning --bootstrap-server kafka1:9092
/usr/bin/kafka-console-consumer --topic test11 --from-beginning --bootstrap-server 20.123.146.145:9092 --partition 0


## perf test commands
kafka-producer-perf-test --topic test11 --throughput -1 --num-records 1000000 --record-size 1024 --producer-props acks=all bootstrap.servers=kafka1:9092,kafka2:9092,kafka3:9092 --producer.config /path/to/ssl-perf-test.properties


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


ansible-playbook main-vm.yml -i hosts-vm

ansible-playbook main.yml -i hosts1
ansible-playbook main.yml -i hosts2


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








