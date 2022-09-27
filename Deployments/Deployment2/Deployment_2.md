Deployment 2


In Deployment 2, a CI/CD pipeline will be created (from start to finish) to deploy a Flask application. 

The tools I used in this project:
*  GitHub
*  Jenkins
*  AWS CLI
*  AWS EC2 instance (Linux – Ubuntu distribution)
*  AWS Elastic Beanstalk
*  AWSEB CLI

# **Step 1: Create AWS environment**
* Create EC2 instance ( security group, ssh key pair & ingress rules)
* Install Jenkins on Jenkins server EC2
* Install AWS CLI on Jenkins server EC2
* Install  AWS EB CLI  on Jenkins server EC2

There are multiple ways to create the AWS environment, however AWS CLI was utilized to install/configure a Jenkins server on EC2 instance. I will provide the commands utilized below:
	
  * Creating Security Group

        aws ec2 create-security-group --group-name sg_deployment2 --description "Security Group for Deployment2" --vpc-id vpc-022b848c736e8e44b
    
  * Adding specific ingress (inbound) rules to the security group
  
  `aws ec2 authorize-security-group-ingress --group-id sg-0df4283eb8a5803e4 --protocol tcp --port 22 --cidr 0.0.0.0/0`
    
    
  `aws ec2 authorize-security-group-ingress --group-id sg-0df4283eb8a5803e4 --protocol tcp --port 80 --cidr 0.0.0.0/0`
    
    
  `aws ec2 authorize-security-group-ingress --group-id sg-0df4283eb8a5803e4 --protocol tcp --port 8080 --cidr 0.0.0.0/0`
        
  * Creating Key Pair
  
`aws ec2 create-key-pair --key-name keypair_deployment2 --query ‘KeyMaterial’  --output text > keypair_deployment2.pem`

`chmod 400 keypair_deployment2.pem`
        
  * Create ec2 instance with Jenkins user_data file to install Jenkins
        
`aws ec2 run-instances --image-id ami-052efd3df9dad4825 --count 1 --instance-type t2.micro --key-name keypair_deployment2 --security-group-ids sg-0df4283eb8a5803e4 --user-data file://user_data.txt`
        
`aws ec2 create-tags --resources i-05e43de19e8bd5357 --tags Key=KuraLabs,Value=Deployment2`
         
         
<br>     
         
EC2 instance created
      
![ec2_instance](https://user-images.githubusercontent.com/91057035/192648009-67af9b09-b135-44be-8e93-d3f1211c8942.png)

<br>
<br>

* Created a Jenkins user account in AWS

`aws iam create-user --user-name EB-user`

`aws iam tag-user --user-name EB-user --tags Key=KuraLabs,Value=Deployment2`

`aws iam attach-user-policy --policy-arn arn:aws:iam::aws:policy/AdministratorAccess --user-name EB-user`

`aws iam create-access-key --user-name EB-user`

<br>

Newly created user {EB-user} in the AWS console 

![eb-user1](https://user-images.githubusercontent.com/91057035/192649672-bd43c9d4-7d26-4d4d-908c-9f0b927a9b89.png)

<br>

![eb-user2](https://user-images.githubusercontent.com/91057035/192649701-10571775-820e-4688-bd35-b1eb80b7bdda.png)

***(the access key ID and access key will be needed later.)***

<br>

SSH into the ec2 instance to verify Jenkins installation

![jenkins_status](https://user-images.githubusercontent.com/91057035/192649910-53d1df54-662c-485b-9c25-8d6a6281c870.png)

* Install & configure AWS CLI on Jenkins EC2 instance:

`curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"`

`unzip awscliv2.zip`

`sudo ./aws/install`

`aws –version`

<br>

![aws_install](https://user-images.githubusercontent.com/91057035/192650407-cae3718e-85f0-43fb-82c8-d9335a925c90.png)

<br>

* Switch to Jenkins user to configure aws

(To successfully configure aws, the access key ID and access key for EB-user will be required. This step is significant because it allows access to the AWS account.)

`sudo su – Jenkins -s /bin/bash`

`aws configure`

* Install  AWS EB CLI  on Jenkins server EC2

`pip install awsebcli –upgrade –user`

`eb –version`

# Step2: Connect GitHub to Jenkins Server & Execute Build/Test

* Forked  Deployment 2 repository (which will connect to Jenkins server as Github Branch source)

* Create a personal access token as a method of authentication to GitHub

* Once the access is established, create a “multibranch build” to clone, build and test the contents of the repository.


     -If the multibranch build passes the build and test phases, the application is ready to be deployed.
     
<br>

![pipeline](https://user-images.githubusercontent.com/91057035/192651684-625197c5-708d-40d2-995a-6801f8b75756.png)

<br>

# Step 3: Deploy application from Elastic Beanstalk CLI

* As the Jenkins user, navigate to a workspace . The standard path /var/lib/Jenkins/<workspace>	-

  (Replaced workspace with the directory of the project name built by Jenkins. The path my workspace was different than the standard.)

  Path: ~/workspace/url-shortener_main/

* In the project directory “url-shortener_main” and as the Jenkins user, execute the following commands:
		
  `eb init`
  
	`eb create`

  
 ![ebcli_deploy](https://user-images.githubusercontent.com/91057035/192652516-ca81758b-0e8b-4b67-af1d-14545758d7ed.png)
 
  <br>
  
 ![eb_console](https://user-images.githubusercontent.com/91057035/192652562-587e064e-d31e-4797-aba3-3e15189642f7.png)

<br>
  
# Step 4: Add a deployment stage to the pipeline

* In the Deployment 2 repository, edit the Jenkinsfile to add a deployment stage (below) then commit the file to the repository.
  
<br>

  ```
stage ('Deploy') {
 steps {
   sh '/var/lib/jenkins/.local/bin/eb deploy url-shortener-dev'
  }
}
```
  
# Step 5: Modify or add to the pipeline

In this step, additional tests was added to the pipeline. 
   
  ```
stage('Test') {
  steps{
    sh '''#!/bin/bash
    date
    whoami
    echo "NAME WHAT THING YOU LEARNED IN DEPLOYMENT #2...."
    echo " "
    cowsay I LEARNED GROOOOOOOVY LOL
    '''
  }
}
```

<br>

  ```
stage('Test 2') {
  steps {
    sh '''#!/bin/bash
    echo "This is a 2nd test script"
    echo "Date : `date`"
    echo "Hostname : `hostname`"
    '''
  }
}
```
  
# Project Overview:
Deployment 2 provided more hands-on experience with AWS, creating CI/CD pipelines, Jenkins, writing Jenkinsfile in Groovy language, creating Tests for pipelines and automation.<br>
  
I ran into an issue testing the application. In the first two builds, the build stage passed successfully. However, the test stage failed twice before I figured out what the issue was. The root cause of the issue was a Python package dependency not updated on the EC2 instance that the Jenkins server runs on. Once updated the package, the next two builds and test were successful.
Each time I created the pipeline, I got faster and more efficient. Repetition, practice and creativity will surely benefit the task of creating pipelines.
