# jenkins-slave
Dockerfile for Jenkins slave on Centos 7

### build image
docker build -t jenkins-slave .

### build file creates a default ssh user for jenkins
username: jenkins
password: jenkins

### start container
docker run -d -p 22:22 jenkins-slave

### test login to container
ssh -p 22 jenkins@127.0.0.1
