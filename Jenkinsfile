pipeline {
    agent any
    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Select action: apply or destroy')
    }
    environment {
        TERRAFORM_WORKSPACE = "/Users/priyanshu/.jenkins/workspace/tool_deploy/tomcat-infra/"
        INSTALL_WORKSPACE = "/Users/priyanshu/.jenkins/workspace/tool_deploy/tomcat/"
        // Update PATH to include the directory where Terraform is installed
        PATH = "${env.PATH}:/opt/homebrew/bin" // Use env.PATH instead of PATH
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
                // Run Terraform plan
                sh "cd ${env.TERRAFORM_WORKSPACE} && terraform plan"
            }
        }

        stage('Approval For Apply') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                // Prompt for approval before applying changes
                input message: "Do you want to apply Terraform changes?", ok: "Yes"
            }
        }

        stage('Terraform Apply') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                // Apply the changes
                sh "cd ${env.TERRAFORM_WORKSPACE} && terraform apply -auto-approve"
            }
        }

        stage('Approval for Destroy') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                // Prompt for approval before destroying resources
                input message: "Do you want to Terraform Destroy?", ok: "Yes"
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                // Destroy the infrastructure
                sh "cd ${env.TERRAFORM_WORKSPACE} && terraform destroy -auto-approve"
            }
        }

        stage('Tool Deploy') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                sshagent(['tomcat']) { 
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
