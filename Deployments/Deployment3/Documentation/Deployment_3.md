# **Deployment 3**


In Deployment 3, a CI/CD pipeline will be created (from start to finish) to deploy a Flask application.

The tools I used in this project:
*  Git
*  GitHub
*  Jenkins
*  AWS VPC
*  AWS EC2 instance (Linux – Ubuntu distribution)
*  Nginx
*  Gunicorn 
<br>

# **Step 1: Create AWS environment**
* Create a VPC
* Create two subnets
* Create an internet gateway
* Create a routing table
* Create three EC2 instances ( security group, ssh key pair & ingress rules)
  - one EC2 instance in a default VPC (execute script to install packages)
  - two EC2 instances in a customized VPC with two availibility zones (execute script to install packages)

![ec2](https://user-images.githubusercontent.com/91057035/195975102-925b9d69-e3fd-48a0-bc87-c81cc80bb44b.png)

<br>

# **Step 2: Install Jenkins**
* Install the Jenkins master on EC2 instance (default VPC)
* Configure & connect a Jenkins agent to Jenkins master (customized VPC)
* Connect Github repository to Jenkins via personal access token

![jenkins](https://user-images.githubusercontent.com/91057035/195975184-b6acab01-4408-4d6f-a916-24ca40df3f86.png)

<br>

# **Step 3: Deploy the Flask application**
* Create a “multibranch build” to clone, build and test the contents of the repository.
* There will be 6 stages:
   - Build stage: building virtual environment
   - Test 1 stage: Bash script 1
   - Test 2 stage: Bash script 2
   - Test 3 stage: Py.test
   - Clean stage: checking and/or terminating specific running process ids
   - Deployment stage: Cloning the Flask application respository, starting a virtual environment to install package requirements & Gunicorn
* The Flask application will be AUTOMATICALLY deployed to a Nginx server ( installed on the ec2 instance within the customized VPC). 
* Gunicorn translates requests it gets from Nginx server into a format which the Flask application can handle, and makes sure the code is executed when needed.

(Initial automated deployment)

![deploy1](https://user-images.githubusercontent.com/91057035/195975360-c67c93dd-bdd3-410a-b0ec-7eb663e716c7.png)
<br>

(additional validation test and resolving an issue)

![deploy2](https://user-images.githubusercontent.com/91057035/195975561-5096630d-e680-4457-bb76-2a8902106f1c.png)


![url-shortener](https://user-images.githubusercontent.com/91057035/195975629-f07f773b-3de7-4746-90a7-02579dc8e750.png)

# **Issues**
After deploying the Flask application to the Nginx server & Gunicorn delivers the Flask application, the webpage would not display. 
However, the webpage would display if the deployment step was still alive or running. This theory was tested by adding a sleep command into the Deploy stage which generated the application webpage. 
To resolve the issue, a jenkins plugin called "Pipeline Keep Running Step" was installed.
I updated the gunicorn command within the Deploy stage with the following: JENKINS_NODE_COOKIE=stayAlive gunicorn -w 4 application:app -b 0.0.0.0:5000 --daemon

That updated entry allowed the application to remain alive after the automated deployment is complete.

   
