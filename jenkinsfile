def tfCmd(String command, String options = '') {
	ACCESS = "export AWS_PROFILE=${PROFILE} && export TF_ENV_profile=${PROFILE}"
	sh ("echo ${command} ${options}") 
	sh ("cd $WORKSPACE/terraform && ${ACCESS} && terraform init && terraform ${command} ${options}")
        }
pipeline {
  agent any
	environment {
		AWS_DEFAULT_REGION = "${params.AWS_REGION}"
		PROFILE = "${params.PROFILE}"
		ACTION = "${params.ACTION}"
		PROJECT_DIR = "terraform"
  }
	
	parameters {

		choice (name: 'AWS_REGION',
				choices: ['eu-central-1','us-west-1', 'us-west-2'],
				description: 'Pick A regions defaults to eu-central-1')
		string (name: 'ENV_NAME',
			   defaultValue: 'tf-customer1',
			   description: 'Env or Customer name')
		choice (name: 'ACTION',
				choices: [ 'plan', 'apply', 'destroy'],
				description: 'Run terraform plan / apply / destroy')
		string (name: 'PROFILE',
			   defaultValue: 'rajinder',
			   description: 'Optional. Target aws profile defaults to rajinder')
		
    }
	stages {
		stage('Checkout & Environment Prep'){
			steps {
				script {
							withCredentials([
							[ $class: 'AmazonWebServicesCredentialsBinding',
								accessKeyVariable: 'AWS_ACCESS_KEY_ID',
								secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
								credentialsId: 'rajinder',
								]])
							{
							try {
								echo "Setting up Terraform"
								def tfHome = tool name: 'Terraform', type: 'terraform'
									env.PATH = "${tfHome}:${env.PATH}"
									currentBuild.displayName += "[$AWS_REGION]::[$ACTION]"
									sh("""
										/usr/bin/aws configure --profile ${PROFILE} set aws_access_key_id ${AWS_ACCESS_KEY_ID}
										/usr/bin/aws configure --profile ${PROFILE} set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}
										/usr/bin/aws configure --profile ${PROFILE} set region ${AWS_REGION}
										export AWS_PROFILE=${PROFILE}
										export TF_ENV_profile=${PROFILE}
										""")
							} catch (ex) {
                                                                echo 'Err: Incremental Build failed with Error: ' + ex.toString()
								currentBuild.result = "UNSTABLE"
							}
						}
					}
				}
			}
		
		stage('terraform plan') {
			when { anyOf
					{
						environment name: 'ACTION', value: 'plan';
						environment name: 'ACTION', value: 'apply'
					}
				}
			steps {
				dir("${PROJECT_DIR}") {
					script {
							withCredentials([
								[ $class: 'AmazonWebServicesCredentialsBinding',
									accessKeyVariable: 'AWS_ACCESS_KEY_ID',
									secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
									credentialsId: 'rajinder',
									]])
								{
								try {
									tfCmd('plan', '-detailed-exitcode -out=tfplan')
								} catch (ex) {
									if (ex == 2 && "${ACTION}" == 'apply') {
										currentBuild.result = "UNSTABLE"
									} else if (ex == 2 && "${ACTION}" == 'plan') {
										echo "Update found in plan tfplan"
									} else {
										echo "Try running terraform again in debug mode"
									}
								}
							}
						
					}
				}
			}
		}
	}
 }
