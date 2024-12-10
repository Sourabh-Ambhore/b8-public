pipeline {
    agent any

    stages {
        stage('cloning prod ready from github') {
            steps {
                sh 'rm -rf *'
               git 'https://github.com/Sourabh-Ambhore/onlinebookstore_Source_code.git'
            }
        }
        stage('Maven install and build artifact') {
            steps {
               sh '''
               sudo apt install maven -y
               mvn clean package
               '''
            }
        }
        stage('copying the artifact into s3 bucket') {
            steps {
               sh '''
               aws s3 cp target/*.war s3://terraform-backup-bct/
               '''
            }
        }
    }
}
