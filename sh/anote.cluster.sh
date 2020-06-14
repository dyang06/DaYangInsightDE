#!/bin/sh
# anote.cluster.sh
# DY200614

# zookeeper 
export zookeeperIp="10.0.0.6"
export zookeeperPort=2181
# kafka broker
declare -A kafkaIps
kafkaIps[0]="10.0.0.7"
kafkaIps[1]="10.0.0.8"
kafkaIps[2]="10.0.0.9"
export kafkaIps
export kafkaPort=9092
#echo ${kafkaIps[0]} 

# spark master
export sparkMasterIp="10.0.0.10"
declare -A sparkWorkerIps
sparkWorkerIps[0]="10.0.0.11"
sparkWorkerIps[1]="10.0.0.12"
sparkWorkerIps[2]="10.0.0.13"
sparkWorkerIps[3]="10.0.0.14"
export sparkWorkerIps

