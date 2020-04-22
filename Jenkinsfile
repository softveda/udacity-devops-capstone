pipeline {
  agent any

  environment {
    APP_NAME = "simple_node_app"
  }

  parameters {
    choice(name: 'DEP_VERSION', choices: ['Blue', 'Green'], description: 'Deployment Version')
  }
  
  stages {

    stage('Linting') {
      steps {
        sh 'tidy -q -e views/*.html'
        sh 'eslint *.js'
        sh 'hadolint Dockerfile'
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
      post {
        always {
          sh 'docker image rm -f softveda/simple_node_app:$BUILD_NUMBER'
          sh 'docker image rm -f softveda/simple_node_app:latest'
        }
      }
    }

    stage('Create ECR repository') {
      steps {
        //sh 'chmod +x ./create-stack.sh'
        //sh './create-stack.sh simple-node-app us-west-2 cfn-ecr.yml'
        sh 'aws cloudformation deploy --stack-name simple-node-app-repo --region us-west-2 --template-file cfn-ecr.yml --parameter-overrides RepositoryName=
simple_node_app'
      }
    }

    stage('Push image to ECR') {
      steps {
        sh 'docker tag simple_node_app 915323986442.dkr.ecr.us-west-2.amazonaws.com/simple_node_app:$BUILD_NUMBER'
        sh 'docker push 915323986442.dkr.ecr.us-west-2.amazonaws.com/simple_node_app:$BUILD_NUMBER'
        sh 'docker tag 915323986442.dkr.ecr.us-west-2.amazonaws.com/simple_node_app:latest'
        sh 'docker push 915323986442.dkr.ecr.us-west-2.amazonaws.com/simple_node_app:latest'        
      }
      post {
        always {
          sh 'docker image rm -f 915323986442.dkr.ecr.us-west-2.amazonaws.com/simple_node_app:$BUILD_NUMBER'
          sh 'docker image rm -f 915323986442.dkr.ecr.us-west-2.amazonaws.com/simple_node_app:latest'
        }
      }
    }

    stage('Provision EKS cluster') {
      environment {
        EKS_STATUS = sh (script:'eksctl get cluster --name=basic-cluster --region=us-west-2', returnStatus: true)
      }
      steps {
        echo "EKS cluster status: $EKS_STATUS"
      }
    }

    stage('Deploy to EKS') {
      steps {
        echo "Deployment Version: ${params.DEP_VERSION}"
        sh 'kubectl get svc'        
      }
    }

  }
}