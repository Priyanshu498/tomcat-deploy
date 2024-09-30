#!/bin/bash

TOMCAT_VERSION=$1

if [ -z "$TOMCAT_VERSION" ]; then
  echo "Usage: $0 <TOMCAT_VERSION>"
  echo "Example: $0 10.1.26"
  exit 1
fi

# Determine the OS type
OS=$(cat /etc/os-release | grep '^ID=' | cut -d '=' -f 2 | tr -d '"')

# Function to install Tomcat on Ubuntu
install_tomcat_ubuntu() {
   
     echo "Installing Tomcat on Ubuntu..."

    # For security purposes, Tomcat should run under a separate, unprivileged user
    sudo useradd -m -d /opt/tomcat -U -s /bin/false tomcat

    # Update the package manager
    sudo apt update

    # Install the JDK
    sudo apt install -y default-jdk

    # Check the version of the available Java installation
    java -version

    # Go to tmp dir
    cd /tmp

    # The wget command downloads resources from the Internet
    TOMCAT_MAJOR_VERSION=$(echo $TOMCAT_VERSION | cut -d. -f1)
    wget https://dlcdn.apache.org/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -P /tmp

    # Create necessary directories
    sudo mkdir -p /opt/tomcat/latest

    # Extract the archive
    sudo tar xf /tmp/apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /opt/tomcat/latest --strip-components=1

    # Grant tomcat ownership over the extracted installation
    sudo chown -R tomcat:tomcat /opt/tomcat/latest
    sudo chmod -R u+x /opt/tomcat/latest/bin

    # Configuring admin user
    sudo bash -c 'cat <<EOF > /opt/tomcat/latest/conf/tomcat-users.xml
<tomcat-users>
    <role rolename="manager-gui"/>
    <user username="manager" password="19@priyanshu" roles="manager-gui"/>
    <role rolename="admin-gui"/>
    <user username="admin" password="19@priyanshu" roles="manager-gui,admin-gui"/>
</tomcat-users>
EOF'

    # Create systemd service file
    sudo bash -c 'cat <<EOF > /etc/systemd/system/tomcat.service
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/default-java
Environment=CATALINA_PID=/opt/tomcat/latest/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat/latest
Environment=CATALINA_BASE=/opt/tomcat/latest
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"
Environment="JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom"

ExecStart=/opt/tomcat/latest/bin/startup.sh
ExecStop=/opt/tomcat/latest/bin/shutdown.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
EOF'

    # Reload the systemd daemon
    sudo systemctl daemon-reload

    # Start the Tomcat service
    sudo systemctl start tomcat

    echo "Tomcat installation in Ubuntu completed successfully"

    # Check the status
    sudo systemctl status tomcat

    # Update the context.xml file
    sudo bash -c 'cat <<EOF > /opt/tomcat/latest/webapps/manager/META-INF/context.xml
<?xml version="1.0" encoding="UTF-8"?>
<!--
  Licensed to the Apache Software Foundation (ASF) under one or more
  contributor license agreements.  See the NOTICE file distributed with
  this work for additional information regarding copyright ownership.
  The ASF licenses this file to You under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with
  the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
-->
<Context antiResourceLocking="false" privileged="true">
  <CookieProcessor className="org.apache.tomcat.util.http.Rfc6265CookieProcessor"
                   sameSiteCookies="strict" />
  <!--Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\\.\d+\\.\d+\\.\d+|::1|0:0:0:0:0:0:0:1" /-->
  <Manager sessionAttributeValueClassNameFilter="java\\.lang\\.(?:Boolean|Integer|Long|Number|String)|org\\.apache\\.catalina\\.filters\\.CsrfPreventionFilter\\\$LruCache(?:\\\$1)?|java\\.util\\.(?:Linked)?HashMap"/>
</Context>
EOF'

    echo "context.xml updated successfully"
}

# Function to install Tomcat on Red Hat (RHEL/CentOS)
install_tomcat_rhel() {
    echo "Installing Tomcat on Red Hat..."

    # For security purposes, Tomcat should run under a separate, unprivileged user
    sudo useradd -m -d /opt/tomcat -U -s /bin/false tomcat

    # Update the package manager
    sudo yum update

    # Install the JDK
    sudo yum install -y java-1.8.0-openjdk wget

    # Check the version of the available Java installation
    java -version

    # Go to tmp dir
    cd /tmp

    # The wget command downloads resources from the Internet
    TOMCAT_MAJOR_VERSION=$(echo $TOMCAT_VERSION | cut -d. -f1)
    wget https://dlcdn.apache.org/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -P /tmp

    # Extract the archive
    sudo tar xf /tmp/apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /opt/tomcat

    # Grant tomcat ownership over the extracted installation
    sudo chown -R tomcat:tomcat /opt/tomcat
    sudo chmod -R u+x /opt/tomcat/bin

    # Configuring admin user
    sudo bash -c 'cat <<EOF > /opt/tomcat/conf/tomcat-users.xml
<tomcat-users>
    <role rolename="manager-gui"/>
    <user username="manager" password="19@priyanshu" roles="manager-gui"/>
    <role rolename="admin-gui"/>
    <user username="admin" password="19@priyanshu" roles="manager-gui,admin-gui"/>
</tomcat-users>
EOF'

    # Create systemd service file
    sudo bash -c 'cat <<EOF > /etc/systemd/system/tomcat.service
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/default-java
Environment=CATALINA_PID=/opt/tomcat/latest/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat/latest
Environment=CATALINA_BASE=/opt/tomcat/latest
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"
Environment="JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom"

ExecStart=/opt/tomcat/latest/bin/startup.sh
ExecStop=/opt/tomcat/latest/bin/shutdown.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
EOF'

    # Reload the systemd daemon
    sudo systemctl daemon-reload

    # Start the Tomcat service
    sudo systemctl start tomcat

    echo "Tomcat installation in Red Hat completed successfully"

    # Check the status
    sudo systemctl status tomcat

    # Update the context.xml file
    sudo bash -c 'cat <<EOF > /opt/tomcat/webapps/manager/META-INF/context.xml
<?xml version="1.0" encoding="UTF-8"?>
<!--
  Licensed to the Apache Software Foundation (ASF) under one or more
  contributor license agreements.  See the NOTICE file distributed with
  this work for additional information regarding copyright ownership.
  The ASF licenses this file to You under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with
  the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
-->
<Context antiResourceLocking="false" privileged="true">
  <CookieProcessor className="org.apache.tomcat.util.http.Rfc6265CookieProcessor"
                   sameSiteCookies="strict" />
  <!--Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\\.\d+\\.\d+\\.\d+|::1|0:0:0:0:0:0:0:1" /-->
  <Manager sessionAttributeValueClassNameFilter="java\\.lang\\.(?:Boolean|Integer|Long|Number|String)|org\\.apache\\.catalina\\.filters\\.CsrfPreventionFilter\\\$LruCache(?:\\\$1)?|java\\.util\\.(?:Linked)?HashMap"/>
</Context>
EOF'

    echo "context.xml updated successfully"
}

# Install Tomcat based on OS type
case "$OS" in
  ubuntu)
    install_tomcat_ubuntu
    ;;
  rhel|centos)
    install_tomcat_rhel
    ;;
  *)
    echo "Unsupported OS: $OS"
    exit 1
    ;;
esac

echo "Tomcat installation and configuration completed."
