pipeline {
    agent any

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

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("jenkins-test-image")
                }
            }
        }

        stage('Post-Build Message') {
            steps {
                echo "Docker image built successfully!"
            }
        }
    }
}
