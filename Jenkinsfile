pipeline {
    agent any
    environment {
        IMAGE_NAME = "calculator-app"
        IMAGE_TAG = "latest"
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'project-1', url: 'https://github.com/Black-Sparkles/Final-Project-1.git'
            }
        }
        stage('Build WAR Package') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }
        stage('Run Docker Container') {
            steps {
                sh "docker run -d -p 8080:8080 ${IMAGE_NAME}:${IMAGE_TAG}"
            }
        }
    }
}
