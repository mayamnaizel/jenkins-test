# 03 — Jenkins Pipeline Explained (Deep Dive)

This document explains the full Jenkins pipeline used in the `jenkins-test` repository.  
It breaks down each stage, how Docker is used, why Node runs inside a container,  
and how the pipeline produces a versioned Docker image.

This is part of your complete CI/CD learning documentation.

---

# **1. What This Pipeline Does**

Your Jenkins Pipeline performs a full CI workflow:

1. Checks out code from GitHub  
2. Installs dependencies inside a Node.js Docker container  
3. Runs automated tests  
4. Builds a Docker image using your Dockerfile  
5. Tags the image using Jenkins build number  
6. Creates a `latest` tag  
7. Outputs success messages  

At the end of the build, you have a **versioned Docker image** ready for:
- pushing to AWS ECR  
- deploying to Kubernetes (EKS)  
- running locally  

---

# **2. Full Jenkins Pipeline (Reference)**

```groovy
pipeline {
    agent any

    environment {
        IMAGE_NAME = "jenkins-test-app"
        IMAGE_TAG = "${env.BUILD_NUMBER}"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/master']],
                    userRemoteConfigs: [[
                        url: 'https://github.com/mayamnaizel/jenkins-test.git',
                        credentialsId: 'github-credentials'
                    ]]
                ])
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    docker.image('node:18').inside {
                        sh 'npm install'
                    }
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    docker.image('node:18').inside {
                        sh 'npm test'
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }

        stage('Tag Latest') {
            steps {
                script {
                    sh "docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest"
                }
            }
        }

        stage('Post Build Message') {
            steps {
                echo "Docker image built successfully: ${IMAGE_NAME}:${IMAGE_TAG}"
            }
        }
    }
}
```
