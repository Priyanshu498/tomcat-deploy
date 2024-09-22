pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                // Git repository se code checkout karna
                git branch: 'main', url: 'https://github.com/Priyanshu498/tomcat-deploy.git'
            }
        }
        stage('Install Ansible') {
            steps {
                // Ansible install karne ka step
                sh '''
                sudo apt update
                sudo apt install ansible -y
                '''
            }
        }
        stage('Run Ansible Playbook') {
            steps {
                // Debugging ke liye files ki list print karna
                sh 'ls -al'

                // Playbook ko correct path ke sath run karna
                sh '''
                ansible-playbook -i ./tomcat-Role/tomcat/aws_ec2.yml ./tomcat-Role/tomcat/playbook.yml
                '''
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

