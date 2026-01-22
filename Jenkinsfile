pipeline {
    agent {
        label 'agent-windows'
    }

    environment {
        DOCKERHUB_USER = "morlayecisse1196"
        DOCKER_IMAGE   = "${DOCKERHUB_USER}/node-backend"
        DOCKER_TAG     = "1.${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo "Clonage du dépôt Git..."
                git branch: 'main',
                    url: 'https://github.com/morlayecisse1196/projet-devops.git'
            }
        }

        stage('Install dependencies') {
            steps {
                echo "Installation des dépendances Node.js..."
                bat 'npm install'
            }
        }

        stage('Test') {
            steps {
                echo "Exécution des tests (si définis)..."
                bat 'npm test || echo Aucun test défini'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Construction de l’image Docker..."
                bat "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
            }
        }

        stage('Push Docker Image') {
            steps {
                echo "Push de l’image vers DockerHub..."
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credentials',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    bat '''
                        echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin
                        docker push %DOCKER_IMAGE%:%DOCKER_TAG%
                        docker logout
                    '''
                }
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                echo "Déploiement avec Docker Compose..."
                bat 'docker compose up -d --build'
            }
        }
    }

    post {
        success {
            echo "Déploiement réussi ✅"
        }
        failure {
            echo "Le pipeline a échoué ❌"
        }
    }
}
