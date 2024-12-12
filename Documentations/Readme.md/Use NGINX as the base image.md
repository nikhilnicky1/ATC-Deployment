# **Dockerfile Documentation**

##### This guide provides an explanation and usage instructions for the provided Dockerfile, which is designed to create a lightweight web application image using NGINX.

# Steps :
### 1. Create a dockerfile
#### **`Dockerfile`**
```bash
# Use NGINX as the base image
FROM nginx:latest

# Set the working directory
WORKDIR /usr/share/nginx/html

# Copy the static HTML content to the NGINX root directory
COPY index.html .

# Expose the default HTTP port
EXPOSE 80

# Run NGINX
CMD ["nginx", "-g", "daemon off;"]
```

### 2. Building the Docker Image

- Navigate to the directory containing the Dockerfile and index.html file.
```bash
cd kuberetes-deployment-files
```
- Build the Docker image:
```bash
docker build -t static-webapp:latest .
```
### 3. Running the Docker Container

- Run the container:
```bash
docker run -d -p 80:80 static-webapp:latest
# This maps port 80 on the host machine to port 80 in the container.
```

### 4. Access the application in your browser:
**http://localhost:80**

### 5. Pushing the Image to a Repository
- Tag the image
```bash
docker tag static-webapp:latest chittimallanikhil:web-app:latest
```
- Login in to the DockerHub
```bash
docker login
# login with the credentials of the Docker Hub
```
- Push the image to Docker Hub:
```bash
docker push chittimallanikhil:web-app:latest 
```





