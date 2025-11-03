pipeline {
    agent any

    environment {
        DOCKERHUB = credentials('dockerhub')
        FRONTEND_IMAGE = "niranjangaikwad5050/fullstack-frontend"
        BACKEND_IMAGE = "niranjangaikwad5050/fullstack-backend"
        KUBECONFIG = "/var/lib/jenkins/.kube/config"
    }

    stages {

        stage('Clone Repo') {
            steps {
                git branch: 'main',
                url: 'https://github.com/niranjangaikwad80/devops-fullstack-app.git'
            }
        }

        stage('Build Images') {
            steps {
                sh '''
                    docker build -t $BACKEND_IMAGE:${BUILD_NUMBER} backend/
                    docker build -t $FRONTEND_IMAGE:${BUILD_NUMBER} frontend/
                '''
            }
        }

        stage('Push Images') {
            steps {
                sh '''
                    echo $DOCKERHUB_PSW | docker login -u $DOCKERHUB_USR --password-stdin

                    docker push $BACKEND_IMAGE:${BUILD_NUMBER}
                    docker push $FRONTEND_IMAGE:${BUILD_NUMBER}
                '''
            }
        }

        stage('Update Image version in manifest') {
            steps {
                sh '''
                    sed -i "s|niranjangaikwad5050/fullstack-backend:.*|niranjangaikwad5050/fullstack-backend:${BUILD_NUMBER}|g" K8s/backend.yaml
                    sed -i "s|niranjangaikwad5050/fullstack-frontend:.*|niranjangaikwad5050/fullstack-frontend:${BUILD_NUMBER}|g" K8s/frontend.yaml
                '''
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                    kubectl apply -f K8s/ --validate=false
                    kubectl rollout status deployment/backend
                    kubectl rollout status deployment/frontend
                '''
            }
        }
    }
}
