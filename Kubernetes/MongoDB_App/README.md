# Kubernetes: MongoDB App (KuraLabs Project)

Objective: Create an application environment with K3D to deploy an application (which consist of a MongoExpress frontend & MongoDB backend)

* **Instructions:**

(Prerequisite) 

1- Using K3d, create a cluster with a loadbalancer with port mapping “8088:8081”

     k3d cluster create clusterMongoDB --port 8088:8081@loadbalancer

2- Create a Mongo deployment yaml file with a service


3- Create a secret yaml

  Execute command below to encode username & password string
  
        echo -n example_username | base64
        
  Copy and paste the encoded username and password in secret yaml file

4- Deploy files

  Deploy the mongo database
        
        kubectl apply -f secrets.yaml
  
  Create the deployment
  
        kubectl apply -f mongodb_deployment.yaml
        
5- Create a config_map file
      
      kubectl apply -f config_map.yaml

6- Create the mongo-express application & deploy it

      kubectl apply -f mongo_express_deployment.yaml


<br>

![mondoDB_app_K8s](https://user-images.githubusercontent.com/91057035/203016452-9355f294-bbb4-47bb-91e2-706f1a1bf993.png)




  
