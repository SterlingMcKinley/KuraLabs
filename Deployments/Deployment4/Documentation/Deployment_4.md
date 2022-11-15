# **Deployment 4**


In Deployment 4, an AWS infrastructure will be created and a Flask application will be deployed via **Terraform**.

The tools I used in this project:
*  Git
*  GitHub
*  Jenkins
*  AWS VPC
*  AWS EC2 instance (Linux – Ubuntu distribution)
*  Terraform
<br>

# **Step 1: Create AWS environment in a default VPC**
* Create an EC2 instance
    * Install & confgure Jenkins (ensure to configure AWS_ACCESS_KEY & AWS_SECRET_KEY)
    * Connect Github repository to Jenkins via personal access token.
    * Install Terraform

![ec2 instance](https://user-images.githubusercontent.com/91057035/199311774-2803efd8-16ce-46d8-92df-e305c520a775.jpg)

# **Step 2: Create a Pipeline build in Jenkins**
* Create a “multibranch build” to clone the contents of the repository.
* Using Terraform, create a VPC
  * VPC CIDR Block
  * Subnet(s)
  * Gateways
  * Route Table(s)
  * Security Group (Ingress & Egress)
* Deploy a Flask application into the newly created VPC via Terraform

![tf](https://user-images.githubusercontent.com/91057035/199312093-be5efdbc-d90a-4a14-9baa-b3b697a0c873.jpg)
<br>

![VPC](https://user-images.githubusercontent.com/91057035/199312430-f3f501e4-8da3-47e1-acc0-c526824bc506.jpg)
<br>

![Before](https://user-images.githubusercontent.com/91057035/199312763-36a80435-0a59-4899-81af-1aac0fc4ce2d.jpg)
<br>

![subnet1](https://user-images.githubusercontent.com/91057035/199314219-ec32ed7d-936e-4cf2-be10-e67aa2e6a0b3.jpg)
<br>

![subnet2](https://user-images.githubusercontent.com/91057035/199314254-8e20c86c-6b38-4e51-b59c-3ed0e859cf71.png)
<br>

# **Step 3: Add test stages to the deployment pipeline**
* add test stages
  * Test 1 stage: Bash script 1
  * Test 2 stage: Bash script 2
  * Destroy stage



![After](https://user-images.githubusercontent.com/91057035/199321929-7796180e-c89e-428a-ae0b-6e072e04191e.jpg)
<br>

# **Overview**
Terraform is a powerful tool! Some benefits of Terraform: 1- cloud agnostic, 2- automates infrastructure, 3- infrastructure can be configured via code (IaC), 4- reduces development cost, & 5- decreases time to provision infrastructure. Deployment 4 was fulfilling. I truly enjoyed being able to spin up infrastructure within minutes. Incorporating Terraform in a CICD pipeline will enable deployment with simple small code changes and lower the probability of human error.

# **Issues**
In this deployment, I ran into a couple of Terraform issues. I did not call or reference a couple of variables correctly. After updating the declared variable Terraform files deployed with no issues.



