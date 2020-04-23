pipeline {
  agent any

  environment {
    APP_NAME = "simple_node_app"
    AWS_ACCOUNT = "915323986442"
  }
  
  parameters {
    string(name: 'EKS_CLUSTER', defaultValue: 'basic-cluster', description: 'EKS Cluster Name')
  }
  
  stages {

    stage('Create EKS Cluster') {
      when {
        expression { environment name: 'JOB_NAME', value: 'udacity-devops-capstone-aws/$BRANCH_NAME'}
      }
      steps {
        echo "Creating EKS Cluster: ${params.EKS_CLUSTER}"
        sh 'eksctl create cluster -f cluster.yml'
        sh 'aws eks list-clusters --region=us-west-2 --output=text'
      }
    }
  }
}