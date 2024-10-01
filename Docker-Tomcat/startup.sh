#!/bin/sh
set -e

# Start Tomcat
exec "$CATALINA_HOME/bin/catalina.sh" run
