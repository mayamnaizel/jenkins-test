# Jenkins Setup on AWS (Using Docker)

## 1. Create an EC2 Instance
- Ubuntu 22.04
- t2.micro or t3.medium
- Allow ports 22, 8080, 50000
- Install Docker

## 2. Install Docker
sudo apt update
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker

## 3. Run Jenkins Container
sudo docker run -d \
  --name jenkins \
  -p 8080:8080 \
  -p 50000:50000 \
  -v /var/jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkins/jenkins:lts

## 4. Retrieve Admin Password
docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword

## 5. Initial Setup
- Install suggested plugins
- Create admin user
- Install “Docker Pipeline” plugin

Jenkins server is now ready.
