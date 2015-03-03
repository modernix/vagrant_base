#!/bin/bash

# elevate our status in the world
sudo -i
HOST_NAME=""
UCD_HOST=""
UCD_IP=""
JRE_PATH="/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.75.x86_64/jre"

# disable iptables (this is just a demo so it's ok)
chkconfig iptables off

hostname $HOST_NAME
sed -i "s/HOSTNAME=.*/HOSTNAME=$HOST_NAME/g" /etc/sysconfig/network
echo -e "$( hostname -I | awk '{ print $2 }' )\t$HOST_NAME" >> /etc/hosts
echo -e $UCD_IP"\t"$UCD_HOST >> /etc/hosts

# install java
#mkdir -p /opt/IBM
#tar -xvf /vagrant/ibm-java*x86_64.tgz -C /opt/IBM
export JAVA_HOME=$JRE_PATH
#export JAVA_HOME=$JRE_PATH

yum upgrade -y

# install bind_utils
yum install -y bind-utils java-1.7.0-openjdk.x86_64 unzip expect spawn erlang python avahi avahi-tools # needed by the engine and web install.sh scripts
yum --nogpgcheck localinstall /vagrant/nss-mdns-0.10-8.el6.x86_64.rpm
#service avahi-daemon start

service messagebus restart
sleep 15s

service avahi-daemon start

cd /tmp
wget https://$UCD_HOST:8443/tools/ibm-ucd-agent.zip --no-check-certificate
unzip ibm-ucd-agent.zip
cd ibm-ucd-agent-install
echo -e 'locked/agent.home=/opt/urbancode/ucdagent' >> installed.properties
echo -e 'locked/agent.name='$HOST_NAME >> installed.properties
echo -e 'locked/agent.mutual_auth=false' >> installed.properties
echo -e 'IBM\ UrbanCode\ Deploy/java.home='$JAVA_HOME >> installed.properties
echo -e 'locked/agent.jms.remote.host='$UCD_HOST >> installed.properties
echo -e 'locked/agent.jms.remote.port=7918' >> installed.properties
./install-agent-from-file.sh installed.properties

chmod ug+x /etc/rc.d/init.d/functions
cd /opt/urbancode/ucdagent/bin/init
sed -i "s/AGENT_USER=.*/AGENT_USER=root/g" agent
sed -i "s/AGENT_GROUP=.*/AGENT_GROUP=root/g" agent
cd /etc/init.d
ln -s /opt/urbancode/ucdagent/bin/init/agent ucdagent
chkconfig ucdagent on
service ucdagent start
