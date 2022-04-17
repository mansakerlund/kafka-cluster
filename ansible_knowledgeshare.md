---
marp: true
---

# Ansible

---

# Use cases

- OS Configuration (users, firewalls etc)
- Software deployment
- Software configuration

---

# How it works

1. Management node reads next command from playbook
2. Management node uses SSH to send tasks to a set of VMs. A tasks is in most cases a python script
performing some action/commands on the VM 

rinse and repeat

---

# Requirements

Management node: Ansible + Python 3.8+ 
Managed hosts: Python + SSH + SFTP (or SCP)

- some commands require additional requirements
- raw/script module does not need python

---

# Ansible terminology

- Inventory
- Tasks and modules
- Playbook
- Roles 
- Templates
- Handlers
- Forks/serials

---

# Inventory

Inventory = Host list

---

# Inventory example

    [zookeeper_servers]
    zookeeper1 zk_id=1 
    zookeeper2 zk_id=2 

    [kafka_brokers]
    kafka1 kafka_broker_id=1   
    kafka2 kafka_broker_id=2
    kafka3 kafka_broker_id=3

---

# Task

name
module : parameters 
with_item - list of items to apply command on
when - conditional basically an if clause

modules are python script in most cases, exceptions are raw and shell

---

# Task - sammple modules

yum – Install or remove packages by using the yum package manager
copy – Copies a file from the local machine to the hosts
file – Sets the attribute of a file, symlink, or directory
service – Starts, stops, or restarts a standard Linux service

https://docs.ansible.com/ansible/latest/collections/index.html#list-of-collections

---

# Task - more modules

command – Executes a command on a remote node, no dependency on a shell
shell – Execute commands in nodes (supports redirection/piping)
raw – Executes a low-down and dirty SSH command

---

# Task example

    name: set port policy kafka
    firewalld: port={{ item }}/tcp permanent=true state=enabled immediate=yes
    with_items:
      - 9092
      - 9093

---

# Playbook

A structured way to organise tasks, could be compared
to helm charts or tfs/azure pipelines 

--- 

#  Roles

A set of related tasks. It is common to stack roles for
a host for example: Users+Firewall+Kafka

Organised by sub folders for tasks, handlers, library, files, templates, vars, defaults and meta.


---

# Playbook + Roles Example

 main.yml 
│ ├group_vars
│   └roles
│       ├firewall
│       │   ├handlers
│       │   └tasks
│       ├kafka
│       │   ├handlers
│       │   ├tasks
│       │   └templates

---

# Playbook + Roles Example

main.yml

    - hosts: kafka_brokers
      become: true
      roles:
        - firewall
        - kafka
---


# Templates

File templates

example of use: create config files, sql commands,
mails

see jinja templates

--- 

# Vars - some usages and their precedence (last wins)

- role/defaults/main.yml
- inventory group_vars folder
- inventory host_vars
- role/vars/main.yml
- set_fact task
- command line with -e

https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html#understanding-variable-precedence

---

# Template and vars example

group_vars/all.yml

zookeeper:
  configuration:
    client_port: 2181
    peer_port: 2888
    sync_limit: 2 

---

# Template and vars example

Inventory

    [zookeeper_servers]
    zookeeper1 zk_id=1 
    zookeeper2 zk_id=2 

    [kafka_brokers]
    kafka1 kafka_broker_id=1   
    kafka2 kafka_broker_id=2
    kafka3 kafka_broker_id=3

--- 

# Template and vars example

    syncLimit={{ zookeeper.configuration.sync_limit }}
    {% for server in groups["zookeeper_servers"] %}
        server.{{ loop.index }}={{ server }}:{{ zookeeper.configuration.peer_port }}:{{ zookeeper.configuration.election_port }}
    {% endfor %}

---

# Handlers and notifications

handlers are deferred tasks

they run:
    after play(all tasks) 
or
    when flush_handlers task is run

---

# Handlers example

    - name: start zookeeper
      command: sudo systemctl start confluent-kafka

    - name: stop zookeeper
      command: sudo systemctl stop confluent-kafka

    - name: status zookeeper
      command: sudo systemctl start confluent-kafka

---

# Handlers example

    name: set zookeeper configuration
    template: src=templates/zookeeper.properties.j2 dest={{ _zookeeper_config_path }}/zookeeper.properties force=yes
    notify: start zookeeper
---

# Forks and serial

forks = tasks(commands) at the same time on different hosts

serial = playbooks run at the same on different hosts





