# Jenkinsfile Explained (CI Pipeline)

The pipeline performs:

1. Checkout from GitHub
2. Install dependencies (npm install)
3. Run tests (npm test)
4. Build Docker image
5. Tag Docker image
6. Print post-build message

## Why use docker.image('node:18').inside?
This ensures npm and node are always available.
No need to install node in Jenkins.

## Docker Build Logic
docker.build("${IMAGE_NAME}:${IMAGE_TAG}")

## Image Tagging
docker tag jenkins-test-app:7 jenkins-test-app:latest
