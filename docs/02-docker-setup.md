# Docker Setup and Integration with Jenkins

## Why mount docker.sock?
Mounting /var/run/docker.sock allows Jenkins to build Docker images on the host.

## Verify Docker Access
docker ps
docker images

## Inspect Jenkins Container
docker inspect jenkins | grep docker.sock

## Build Images from Jenkins Pipeline
Jenkins will build:
- jenkins-test-app:<build-number>
- jenkins-test-app:latest
