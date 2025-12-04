# 02 — Docker Setup Deep Dive for Jenkins CI/CD

This document provides a complete, detailed explanation of how Docker integrates with Jenkins.  
It covers EVERYTHING you need to understand:

- Why Jenkins needs Docker  
- Why we mount `/var/run/docker.sock`  
- How to validate the mount  
- How Jenkins communicates with Docker  
- Why we install Docker CLI inside the Jenkins container  
- How Docker builds work inside pipelines  
- How to verify images  
- How to fix permissions  

This file is part of your DevOps learning documentation.

---

# **1. Why Docker Is Essential in CI/CD**

Docker is required in CI/CD pipelines because it enables:

- **Portable, reproducible environments**  
- **Consistent builds** across all developers and environments  
- **Isolated test executions**  
- **Packaging applications into images**  
- **Deploying to Kubernetes (EKS, AKS, GKE)**  
- **Artifact versioning** using image tags  
- **Continuous Delivery** using immutable containers  

In your pipeline, Jenkins:
- Clones your code  
- Runs tests inside a Node container  
- Builds a Docker image  
- Tags the image  
- Pushes or deploys it (in future steps)

This is impossible without Docker.

---

# **2. Why Jenkins Needs the Docker Socket Mount**

Since Jenkins runs **inside a Docker container**, it does NOT have its own Docker Engine.  
A Docker Engine can only run on a **host OS**, not inside another container by default.

To allow Jenkins to issue Docker commands like:
```bash

docker build
docker run
docker tag
docker push
```

we give Jenkins access to the **host machine’s Docker daemon** by mounting:

/var/run/docker.sock


### ✔ The Docker socket = the *control interface* of Docker.

Whatever app has access to the socket can tell Docker to:

- Build images  
- Run containers  
- Delete images  
- Tag images  
- Push to registries  

### **When you mount docker.sock:**

The Jenkins container uses the **host’s Docker daemon** as if it were local.

This is the command that makes it possible:
```bash

-v /var/run/docker.sock:/var/run/docker.sock
```

This mount is essential — without it, Jenkins pipelines fail 


Running Jenkins with Correct Docker Integration

Correct container startup:

```bash

sudo docker run -d \
  --name jenkins \
  -p 8080:8080 \
  -p 50000:50000 \
  -v /var/jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkins/jenkins:lts
```
