pipeline {
    agent {
        docker {
            image 'maven:3.8.4-openjdk-11'
        }
    }
    environment {
        IMAGE_NAME = "calculator-app"
        IMAGE_TAG = "latest"
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'project-1', url: 'https://github.com/<your-username>/proj-mdp-152-155.git'
            }
        }
        stage('Build WAR Package') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    sh "docker run -d -p 8080:8080 ${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }
    }
}


