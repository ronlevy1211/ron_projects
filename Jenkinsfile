pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                sh '''
		    echo "************************"
		    echo "***BUILD WAR ARTIFACT***"
	            echo "************************"
	 	    docker run --rm -v /root/hello-world/:/hello-world -v /root/.m2:/root/.m2 -w /hello-world maven:3-alpine mvn -B -DskipTests clean install package
		    
		    echo "************************"
		    echo "***BUILD DOCKER IMAGE***"
	    	    echo "************************"
		    cp ./webapp/target/webapp.war ./webapp.war
      		    docker build -t tomcat-image:latest .
		    docker tag tomcat-image ronlevy1211/tomcat-image
		    '''
            }
        }
        stage('Test') {
            steps {
                sh '''
			echo "**********"
			echo "***TEST***"
			echo "**********"
			docker run --rm -v /root/hello-world/:/hello-world -v /root/.m2:/root/.m2 -w /hello-world maven:3-alpine mvn test
		'''
            }
        }
	stage('Push') {
	    steps {
		sh '''
			docker push ronlevy1211/tomcat-image
			docker rmi tomcat-image:latest ronlevy1211/tomcat-image 2> /dev/null
		'''
 	    }
    	} 
        stage('Deploy') {
            steps {
		sh '''
			echo "************************"
			echo "**DEPLOY TO KUBERNETES**"
			echo "************************"
			ssh ansible@172.31.17.254 "ansible-playbook -i /opt/k8s/hosts /opt/k8s/deployment.yml;ansible-playbook -i /opt/k8s/hosts /opt/k8s/service.yml;"
		'''
            }
        }
    }
}


