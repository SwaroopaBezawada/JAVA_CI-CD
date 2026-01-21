pipeline {
  agent any

  environment {
    AWS_REGION = "eu-west-2"
    ECR_REPO   = "regapp"
    IMAGE_TAG  = "latest"
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build WAR with Maven (Java 21)') {
      steps {
        sh 'mvn clean package'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh "docker build -t ${ECR_REPO}:${IMAGE_TAG} ."
      }
    }

    stage('Security Scan (Trivy)') {
      steps {
        sh '''
          if ! command -v trivy >/dev/null 2>&1; then
            echo "Trivy not installed on agent. Install trivy or use a dockerized trivy scan."
            exit 1
          fi
          trivy image --severity HIGH,CRITICAL --no-progress ${ECR_REPO}:${IMAGE_TAG} || true
        '''
      }
    }

    stage('Login to ECR + Push Image') {
      steps {
        sh '''
          AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
          ECR_URI=${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}

          aws ecr describe-repositories --repository-names ${ECR_REPO} --region ${AWS_REGION} >/dev/null 2>&1 || \
            aws ecr create-repository --repository-name ${ECR_REPO} --image-scanning-configuration scanOnPush=true --region ${AWS_REGION}

          aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

          docker tag ${ECR_REPO}:${IMAGE_TAG} ${ECR_URI}:${IMAGE_TAG}
          docker push ${ECR_URI}:${IMAGE_TAG}
        '''
      }
    }

    stage('Deploy to ECS (Terraform)') {
      steps {
        sh '''
          cd infra/terraform-ecs-fargate
          terraform init
          terraform apply -auto-approve
        '''
      }
    }
  }
}
