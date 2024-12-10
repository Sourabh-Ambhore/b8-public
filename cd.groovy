pipeline {
    agent any

    stages {
        stage('copying artifact from s3 bucket') {
            steps {
                sh '''
                rm -rf * 
                sudo aws s3 cp s3://terraform-backup-bct/onlinebookstore.war .
                '''
            }
        }
        stage('deploying on tomcat') {
            steps {
                sh '''
                wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.98/bin/apache-tomcat-9.0.98.zip
                unzip apache-tomcat-9.0.98.zip
                cp *.war apache-tomcat-9.0.98/webapps/.
                cd apache-tomcat-9.0.98/bin && chmod 777 *
                bash /var/lib/jenkins/workspace/cd/apache-tomcat-9.0.98/bin/catalina.sh start
                bash /var/lib/jenkins/workspace/cd/apache-tomcat-9.0.98/bin/startup.sh
                '''
            }
        }
    }
}
