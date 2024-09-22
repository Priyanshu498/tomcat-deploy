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
                // Ansible install karne ka step (assuming Ubuntu/Debian)
                sh 'sudo apt update && sudo apt install ansible -y'
            }
        }
        stage('Run Ansible Playbook') {
            steps {
                // Ansible playbook ko execute karna
                sh 'ansible-playbook -i aws_ec2.yml playbook.yml'
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
