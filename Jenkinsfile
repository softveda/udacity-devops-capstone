pipeline {
  agent any
  stages {
    stage('Linting'){
      steps{
        sh 'tidy -q -e views/*.html'
        sh 'eslint *.js'
      }
    }
    stage('Build Docker Image'){
      steps{
        sh 'docker build -t simple_node_app .'
        sh 'docker image ls -q simple_node_app:latest'
      }
    }
    stage('Run and Test App in Docker'){
      steps{
        sh 'docker run --name simple_node_app -p 8080:80 -d simple_node_app'
        sh 'sleep 30'
        sh 'curl -s http://localhost:8080'
        sh 'docker logs simple_node_app'
        sh 'docker stop simple_node_app'
      }
    }
     stage('Push Docker image to repo'){
      steps{
        sh 'docker tag simple_node_app softveda/simple_node_app:latest'
        sh 'docker push softveda/simple_node_app:latest'
        sh 'docker image rm simple_node_app:latest'
      }
    }
  }
}