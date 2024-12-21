# SimpleAPIWithCICD
# Steps
1. create the api using asp.NET
2. create dockerfile
3. create kubernetes(deployment.yaml, service.yaml)

# Docker 
dockerfile is a script that automates:
- setting up the enviroment for your application
- buildning and publishing your application 
- running the application in a lightweight container

### For a ASP.NET Core Web API project, the dockerfile typically: 
1. Pulls a base image(ASP.NET runtime and SDK images)
2. Restores dependencies, builds and publishes the project
3. Configures the runtime enviroment for the application
4. exposes a port and sets the command to run the app

### Build the docker image
docker build -t simpleapi-image .

### run the docker container
docker run -d -p 8080:8080 --name simpleapi-container simpleapi-image

The app will be accessible at http://localhost:8080/swagger.

# Kubernetes
## Key Concepts
- Cluster: A group of machines(nodes) managed by Kubernetes
- Node: A single machine in the cluster, which can be physical or virtual
- Pod The smallest deployable unit in Kubernetes, which contains one or more containers
- Deployment: Manages a set of identical pods
- Service: Exposes your application to the network, allowing communication between pods or external users


## Run kubernetes
1. check if you have kubernetes: 
	kubectl version --client
	kubectl cluster-info

2. start kubernets: minikube start
3. check status: minikube status, host, kubelet and apiserver should be running
4. switch to minikube? : kubectl config use-context minikube
5. open the dashboard: minikube dashboard

after you have started kubernetes:
create the necessary yaml files deployment, service
the yaml files such as: ConfigMap, Secret, Ingress are optional, therer proably exist more optional yaml files we can add  

### Deployment
after you created deployment file do: 
minikube kubectl -- apply -f deployment.yaml

if the dashboard shows failure, try to do minikube image load simpleapi-image and see if its sucessful/running(the circles should be green)

get the current deployments: minikube kubectl -- get deployments

### Service
By default, the api is only acessible within kubernetes cluster. To expose it externally, you must create a service. 

after creating the service.yaml, do: 
minikube kubectl -- apply -f service.yaml

to access the api externally, you can retrieve the external ip adress of service by: 
minikube kubectl -- get services 

Look for the port number in the PORT(S) column associated with your simpleapi-service. 
Access your API using the IP address of any worker node in your cluster and the NodePort. For example: http://worker-node-ip:node-port/swagger

worker-node-ip you get it by: minikube ip

or you can simply run the command: 
minikube service weatherapi-service



