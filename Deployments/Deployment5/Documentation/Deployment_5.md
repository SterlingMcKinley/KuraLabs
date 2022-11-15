# **Deployment5**

In Deployment 5, an AWS infrastructure will be created and a Flask application will be deployed via **Terraform**.

The tools I used in this project:
*  Git
*  GitHub
*  Jenkins
*  AWS EC2
*  AWS ECS / Fargate
*  Docker
*  Terraform
<br>

# **Step 1: Create & Configure EC2 instances**
* Created an Jenkins Server on EC2 instance via AWS CLI
    * Install & confgure Jenkins (ensure to configure AWS_ACCESS_KEY & AWS_SECRET_KEY)
    * Install Docker Pipeline Plugin
    * Connect Github repository to Jenkins via personal access token.
    
* Created a Docker Server & Terraform Server on 2 EC2 instances in two different availability zones within a VPC
    * Copy key file (.pem) to both EC2 instances
    
* Create two Jenkins agent profiles (an agent on each server)

![instances](https://user-images.githubusercontent.com/91057035/202013951-cbd4be4d-467e-4f6d-9151-5ba26f0ad7b3.png)
<br>

![agents](https://user-images.githubusercontent.com/91057035/202014813-55c8d18e-35a1-4b75-a2ac-1711c15d1a46.png)
<br>

# **Step 2: Create IAM Role**

* Create ECS Task Role for AmazonECSTaskExecutionRolePolicy Policy (Role: ecsTaskEx)


# **Step 3: Create a pipeline files & IaC files**

* Create docker files
  * docker-compose.yaml
  * dockerfile & config file (nginx)
  * dockerfiles (gunicorn-flask)

  
* Update Terraform files
  * specify the container/images
  * configure Role ARN for ECS tasks

* Create a Jenkinsfile with the following stages:
  *  Build - (virtual env)
  *  Test - (py.test)
  *  Docker - (Create container)
  *  Docker - (Push to DockerHub)
  *  Terraform - (Deploy to AWS ECS)
  *  Terraform - (Destroy ECS)


# **Step 4: Create a Pipeline build in Jenkins**
* Create a “multibranch build” to clone the contents of the GitHub repository.
* Jenkins will reference multiple files in the GitHub repository, while deploying/executing the declared stages and steps within the Jenkinsfile.


![docker](https://user-images.githubusercontent.com/91057035/202026040-d43397b5-c093-4e69-ab26-83a3dc28bcb7.jpg)
<br>

![cluster1](https://user-images.githubusercontent.com/91057035/202028031-fed00101-52c7-42c7-abd8-3cb2392a1bc1.jpg)
<br>

![task](https://user-images.githubusercontent.com/91057035/202028476-3308b65a-67d3-4e2e-b358-fda937f8a392.jpg)
<br>

![complete](https://user-images.githubusercontent.com/91057035/202026911-62872ba2-4e8f-4a76-8c87-377c9634cfe1.jpg)
<br>

![ALB](https://user-images.githubusercontent.com/91057035/202028555-2aab804a-0a99-4e59-a87a-1694297103f9.jpg)
<br>

![url](https://user-images.githubusercontent.com/91057035/202027694-5d074d3f-6450-43b8-925f-0abdfba915b9.jpg)
<br>


