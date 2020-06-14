#!/bin/sh
# setup.nodes.SparkWorker.sh
# DY200614

cd "$(dirname "$0")"
echo $PWD
sh anoteCluster.sh
sh getDevTools.sh

# get spark 
wget https://archive.apache.org/dist/spark/spark-2.4.6/spark-2.4.6-bin-hadoop2.7.tgz
tar xvf spark-2.4.6-bin-hadoop2.6.tgz

sudo mv spark-2.4.6-bin-hadoop2.6/    /usr/local/spark

# add spark and javaHome to PATH
sparkPath="/usr/local/spark"
# $javaHome is set in getDevTools.sh
sudo sed -i '0,s#PATH=.*#PATH=$PATH:$sparkPath/bin:$HOME/.local/bin:$HOME/bin#' \
  /home/ec2-user/.bash_profile
. /home/ec2-user/.bash_profile


# edit spark-env.sh
sudo sed "$ a \n\
# contents of conf/spark-env.sh \n\
export SPARK_MASTER_HOST=localhost
export JAVA_HOME=$javaHome \n\
# For PySpark use \n\
export PYSPARK_PYTHON=python3 \n\
# Oversubscription \n\
export SPARK_WORKER_CORES=8" \
  $sparkPath\conf/spark-env.sh.template \
  $sparkPath\conf/spark-env.sh

sudo sed "$ a \n\
# contents of conf/slaves \n\
10.0.0.6 \n\
10.0.0.6 \n\
10.0.0.6 " \
  $sparkPath\conf/slaves.template \
  $sparkPath\conf/slaves.sh

sh spark-2.4.6-bin-without-hadoop/sbin/start-all.sh

# get kafka-python and babo3
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py
jre-1.8.0-openjdk-1.8.0.252.b09-2.amzn2.0.1.x86_64