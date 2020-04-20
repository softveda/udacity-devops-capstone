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
  }
}