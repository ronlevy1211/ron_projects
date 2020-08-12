#!/bin/bash

echo "***********************************"
echo "***BUILD DOCKER IMAGE**************"
echo "***********************************"


cp ./webapp/target/webapp.war ./webapp.war 

docker build -t tomcat-image:latest .

docker tag tomcat-image ronlevy1211/tomcat-image

docker push ronlevy1211/tomcat-image

docker rmi tomcat-image:latest ronlevy1211/tomcat-image 2> /dev/null
