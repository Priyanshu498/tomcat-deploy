# Use a minimal image as parent
FROM openjdk:11-jdk-slim

# Environment variables
ENV TOMCAT_MAJOR=9 \
    TOMCAT_VERSION=9.0.95 \
    CATALINA_HOME=/opt/tomcat

# init
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get install -y fonts-dejavu && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt

# install tomcat
RUN curl -jkSL -o /tmp/apache-tomcat.tar.gz http://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    tar -C /opt -xzf /tmp/apache-tomcat.tar.gz && \
    ln -s /opt/apache-tomcat-$TOMCAT_VERSION $CATALINA_HOME

# cleanup
RUN rm -rf /tmp/*

EXPOSE 8080

# Copy the startup script
COPY startup.sh /opt/startup.sh

# Ensure the startup.sh script is executable
RUN chmod +x /opt/startup.sh

ENTRYPOINT ["/opt/startup.sh"]

WORKDIR $CATALINA_HOME
