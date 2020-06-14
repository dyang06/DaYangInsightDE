#!/bin/sh
# getDevTools.sh
# java python3 scala
# pip sbt
# DY200614

cd ~
echo $PWD

ch anoteDistributions.sh

# get Development Tools
sudo yum groupinstall "Development Tools"

# get java and python3
yes | sudo yum install $java_dist $python3_dist 

# set JAVA_HOME
# $file $(which java)
# /usr/bin/java: symbolic link to `/etc/alternatives/java'
# $file /etc/alternatives/java
# /etc/alternatives/java: symbolic link to `/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.252.b09-2.amzn2.0.1.x86_64/jre/bin/java'
# $javaHome="/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.252.b09-2.amzn2.0.1.x86_64/jre"
# THIS IS HOW TO FIND JAVA_HOME (already set in setDistributionNames.sh)
# WHICH NEEDS UPDATE!!
sudo sed -i -e "/export PATH/i\JAVA_HOME=\"$javaHome\"" \
  -e '/export PATH/i\PATH=$JAVA_HOME/bin:$PATH' \
  -e '/export PATH/i\ ' \
  $HOME/.bash_profile
. $HOME/.bash_profile

# get scala
yes | sudo rpm -i $scala_bin_url

# setup pip and sbt
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py  

curl https://bintray.com/sbt/rpm/rpm | sudo tee /etc/yum.repos.d/bintray-sbt-rpm.repo
yes | sudo yum install sbt 
