# Simple Node.js Web App

This is a simple Node.js web app using the Express framework. It serves the index.html file.
The app can be containerize using Docker and deployed to any Kubernetes cluster. There is an example delpoyment config file to run it in AWS Elastic Kubernetes Service (EKS) from a Docker image in a AWS Elastic Container Repository (ECR).  

This is the Capstone project for Udacity Devops Engineering Nanodegree.

---

## Running the App in Docker
1. Open a terminal and clone the project repository, then  navigate to the project folder. 
```bash
git clone https://github.com/softveda/udacity-devops-capstone.git
cd udacity-devops-capstone
```

2. Create Docker Image for the app 
```bash
docker build -t simple_node_app .
```

3. Run the app in Docker container
```bash
 docker run --name simple_node_app -p 8080:80 -d simple_node_app
```

4. Test the app using Curl
```bash
curl -s http://localhost:8080
```
This should show the contents of *index.html* on the console
Alternately open your web browser and browse to the URL http://localhost:8080


5. Check the logs
```bash
docker logs -f simple_node_app
```

This should write some logs to terminal like  
```
Simple node web app listening on port 80
::ffff:192.168.65.3 - - [19/Apr/2020:01:24:46 +0000] "GET / HTTP/1.1" 200 337
```

6. Stop the running Docker container
```bash
 docker stop simple_node_app
```

## Tagging and Uploading Docker image
1. Create a new repository on Docker hub named simple_web_app

2. Tag the image
``` bash
docker tag simple_node_app:latest <docker account>/simple_node_app:latest
```

3. Push the image to Docker hub
``` bash
docker push <docker account>/simple_node_app:latest
```

## Deploy the Docker image to local Kubernetes Cluster
1. Deploy the application and service to Kubernetes
```bash
kubectl apply -f app-deployment.yml
```

2. Check that pods, deployment and service are created and running 
```bash
kubectl get all
```

3. Test the app using Curl
```bash
curl -s http://localhost:8080
```
This should show the contents of *index.html* on the console.  
Alternately open your web browser and browse to the URL http://localhost:8080

5. Check the logs
```bash
kubectl logs deployment.apps/simple-web-app
```

This should write some logs to terminal like  
```
Simple node web app listening on port 80
::ffff:192.168.65.3 - - [19/Apr/2020:01:24:46 +0000] "GET / HTTP/1.1" 200 337
```

6. Delete the kubernetes deployment and service
```bash
kubectl delete deployment.apps/simple-web-app
kubectl delete service/simple-web-app
```

---
## Project Files
- **Application files**
  - **app.js** - This is the Node.js web application
  - **views\index.html** - This is the default index.html file
  - **.eslintrc** - ESLint configuration file
  - **.gitignore** - This has the files that should not be added to the git repository
- **Docker files**
  - **Dockerfile** - This is the docker build file to containerize the app inside Docker
  - **.dockerignore** - This has the files that should not be copied when building the Docker image
- **Script files**
  - **run_docker.sh** - This script will build the Docker image of the app and run the app inside the container
  - **upload_docker.sh** - This script uploads the Docker image to Docker hub repository
  - **run_kubernetes.sh** - This script deploys the Docker image to a Kubernetes cluster and runs the app in pods.