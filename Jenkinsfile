pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Priyanshu498/tomcat-deploy.git'
            }
        }
        
        stage('Run Ansible Playbook') {
            steps {
                sshagent(['tom-1-key.pem']) { 
                    sh 'ls -al'
                    sh '''
                    ansible-playbook -i ./tomcat-Role/tomcat/aws_ec2.yml ./tomcat-Role/tomcat/playbook.yml
                    '''
                }
            }
        }
    }
    post {
        success {
            echo 'Deployment successful'
        }
        failure {
            echo 'Deployment failed'
        }
    }
}
