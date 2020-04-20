pipeline {
  agent any
  stages {
    stage('Linting'){
      steps{
        sh 'tidy -q -e views/*.html'
      }
      steps{
        sh 'eslint *.js'
      }
    }
    stage('Docker Image'){
      steps{
        sh 'echo building Docker image'
      }
    }
  }
}