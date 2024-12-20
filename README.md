# SimpleAPIWithCICD
## steps
1. create the api using asp.NET
2. create dockerfile

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
docker build -t simple-api .

### run the docker container
docker run -d -p 8080:80 --name simple-api-container simple-api

The app will be accessible at http://localhost:8080.
If your API uses HTTPS, you may need to map port 443: