pipeline {
    agent any
    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Select action: apply or destroy')
    }
    environment {
        TERRAFORM_WORKSPACE = "/var/lib/jenkins/workspace/tool_deploy/tomcat-infra/"
        INSTALL_WORKSPACE = "/var/lib/jenkins/workspace/tool_deploy/tomcat/"
       
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Priyanshu498/tomcat-deploy.git'

            }
        }
        stage('Terraform Init') {
            steps {
                sh "cd ${env.TERRAFORM_WORKSPACE} && terraform init"
            }
        }
        stage('Terraform Plan') {
            steps {
                sh "cd ${env.TERRAFORM_WORKSPACE} && terraform plan"
            }
        }
        stage('Approval For Apply') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                input "Do you want to apply Terraform changes?"
            }
        }
        stage('Terraform Apply') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                sh """
                cd ${env.TERRAFORM_WORKSPACE}
                terraform apply -auto-approve
                mkdir -p ${env.INSTALL_WORKSPACE}
                sudo cp ${env.TERRAFORM_WORKSPACE}/tom-1-key.pem ${env.INSTALL_WORKSPACE}/
                sudo chown jenkins:jenkins ${env.INSTALL_WORKSPACE}/tom-1-key.pem
                sudo chmod 400 ${env.INSTALL_WORKSPACE}/tom-1-key.pem
                """
            }
        }
        stage('Approval for Destroy') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                input "Do you want to Terraform Destroy?"
            }
        }
        stage('Terraform Destroy') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                sh "cd ${env.TERRAFORM_WORKSPACE} && terraform destroy -auto-approve"
            }
        }
        stage('Tool Deploy') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                sshagent(['tom-1-key.pem']) {
                    script {
                        
                        sh """
                            cd ${env.INSTALL_WORKSPACE}
                            ansible-playbook -i aws_ec2.yaml playbook.yml  
                        """                               
                    }   
                }
            }
        }
    }
    post {
        success {
            echo 'Deployment Succeeded!'
        }
        failure {
            echo 'Deployment Failed!'
        }
    }
}
