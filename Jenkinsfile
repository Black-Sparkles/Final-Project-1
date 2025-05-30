pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'project-1', url: 'https://github.com/Black-Sparkles/Final-Project-1.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("calculator-app:${env.BUILD_NUMBER}")
                }
            }
        }
        stage('Run Container') {
            steps {
                script {
                    docker.image("calculator-app:${env.BUILD_NUMBER}")
                          .run("-d -p 8080:8080")
                }
            }
        }
    }
}

