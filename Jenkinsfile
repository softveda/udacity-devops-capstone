pipeline {
  agent any
  stages {
    stage('Linting') {
      steps {
        sh 'tidy -q -e views/*.html'
        sh 'eslint *.js'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t simple_node_app .'
        sh 'docker image ls -q simple_node_app:latest'
      }
    }

    stage('Run and Test App in Docker') {
      steps {
        sh 'docker run --name simple_node_app -p 80:80 -d simple_node_app'
        sh 'sleep 5'
        sh 'curl -s http://localhost:80'
        sh 'docker logs simple_node_app'
        sh 'docker stop simple_node_app'
        sh 'docker rm simple_node_app'
      }
    }

    stage('Push image to DockerHub') {
      steps {
        withDockerRegistry(credentialsId: 'docker-hub-credentials', url: 'https://index.docker.io/v1/') {
          sh 'docker tag simple_node_app softveda/simple_node_app:$BUILD_NUMBER'
          sh 'docker tag simple_node_app softveda/simple_node_app:latest'
          sh 'docker push softveda/simple_node_app:$BUILD_NUMBER'
          sh 'docker push softveda/simple_node_app:latest'
        }

      }
    }

    stage('Push image to ECR') {
      steps {
        withDockerRegistry(credentialsId: 'docker-ecr-credentials', url: 'https://915323986442.dkr.ecr.us-west-2.amazonaws.com/simple_node_app') {
          sh 'docker tag simple_node_app 915323986442.dkr.ecr.us-west-2.amazonaws.com/simple_node_app:$BUILD_NUMBER'
          sh 'docker push 915323986442.dkr.ecr.us-west-2.amazonaws.com/simple_node_app:$BUILD_NUMBER'
        }

        sh 'docker image rm -f simple_node_app:latest'
      }
    }

    stage('Check EKS') {
      steps {
        sh 'eksctl get cluster --name=basic-cluster --region=us-west-2'
        sh 'kubectl get svc'
      }
    }

  }
}