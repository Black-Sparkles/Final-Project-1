pipeline {
    agent any
<<<<<<< HEAD
=======
    environment {
        IMAGE_NAME = "calculator-app"
        IMAGE_TAG = "latest"
    }
>>>>>>> d315df6c28da2c642c5ee8f3e550034984ce540a
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'project-1', url: 'https://github.com/Black-Sparkles/Final-Project-1.git'
            }
        }
<<<<<<< HEAD
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
=======
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
>>>>>>> d315df6c28da2c642c5ee8f3e550034984ce540a
            }
        }
    }
}
<<<<<<< HEAD

=======
>>>>>>> d315df6c28da2c642c5ee8f3e550034984ce540a
