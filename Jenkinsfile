pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = 'dockerhub-creds'  
        DOCKER_IMAGE = 'oluwatoyosi/calculator-app'
    }

    stages {
        stage('Clone') {
            steps {
                git branch: 'project-1', url: 'https://github.com/Black-Sparkles/Final-Project-1.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE}:latest")
                }
            }
        }

        stage('Login to DockerHub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_HUB_CREDENTIALS}") {
                        echo "Logged in to Docker Hub"
                    }
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_HUB_CREDENTIALS}") {
                        dockerImage.push('latest')
                    }
                }
            }
        }

        stage('Run Container') {
            steps {
                sh 'docker rm -f calculator || true'
                sh "docker run -d --name calculator -p 9000:8080 ${DOCKER_IMAGE}:latest"
            }
        }
    }
}
