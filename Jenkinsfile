pipeline {
    agent any

    environment {
        DOCKERHUB = credentials('dockerhub')
        FRONTEND_IMAGE = "niranjangaikwad5050/fullstack-frontend"
        BACKEND_IMAGE = "niranjangaikwad5050/fullstack-backend"
    }

    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'main',
                url: 'https://github.com/niranjangaikwad80/devops-fullstack-app.git'
            }
        }

        stage('Build Backend Image') {
            steps {
                sh 'docker build -t $BACKEND_IMAGE:latest backend/'
            }
        }

        stage('Build Frontend Image') {
            steps {
                sh 'docker build -t $FRONTEND_IMAGE:latest frontend/'
            }
        }

        stage('Login and Push Images') {
            steps {
                sh 'echo $DOCKERHUB_PSW | docker login -u $DOCKERHUB_USR --password-stdin'
                sh 'docker push $BACKEND_IMAGE:latest'
                sh 'docker push $FRONTEND_IMAGE:latest'
            }
        }

    }
}
