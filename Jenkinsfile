pipeline {
    agent {
        label 'agent-windows'// ou agent any si tu veux exécuter partout
    }

    environment {
        DOCKERHUB_USER = "morlayecisse1196"
        DOCKER_IMAGE   = "${DOCKERHUB_USER}/node-backend"
        DOCKER_TAG     = "1.${BUILD_NUMBER}"

        // RECEIVER_NOTIFICATION_EMAIL = "morlayecis0003@gmail.com"
        // SENDER_NOTIFICATION_EMAIL   = "bobcodeur@gmail.com"
        // SMTP_CREDENTIALS_ID         = "gmail-credentials"
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo "Clonage du dépôt Git..."
                git branch: 'main', url: 'https://github.com/morlayecisse1196/projet-devops.git'
            }
        }

        stage('Install dependencies') {
            steps {
                echo "Installation des dépendances Node.js..."
                bat 'npm install'
            }
        }

        stage('Build') {
            steps {
                echo "Construction du projet Node.js..."
                bat 'npm run build || echo "Pas de build défini"'
            }
        }

        stage('Test') {
            steps {
                echo "Exécution des tests..."
                bat 'npm test || echo "Pas de tests définis"'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Construction de l'image Docker..."
                bat "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
            }
        }

        stage('Pubat Docker Image') {
            steps {
                echo "Poussée de l'image Docker vers DockerHub..."
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials',
                                usernameVariable: 'DOCKER_USER',
                                passwordVariable: 'DOCKER_PASS')]) {
                    bat '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker pubat "$DOCKER_IMAGE:$DOCKER_TAG"
                        docker logout
                    '''
                }
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                echo "Déploiement du backend Node.js avec Docker Compose 🚀"
                bat "docker-compose up -d --build"
            }
        }
    }

    post {
        success {
            echo "Déploiement réussi ✅"
            // emailext (
            //     from: "${SENDER_NOTIFICATION_EMAIL}",
            //     to: "${RECEIVER_NOTIFICATION_EMAIL}",
            //     subject: "Déploiement Réussi : ${env.JOB_NAME} #${env.BUILD_NUMBER}",
            //     body: """
            //         <p>Bonjour,</p>
            //         <p>Le déploiement du job <b>${env.JOB_NAME}</b> (build #${env.BUILD_NUMBER}) a été effectué avec succès.</p>
            //         <p>Voir les détails : <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></p>
            //         <p>Cordialement.</p>
            //     """
            // )
        }

        failure {
            echo "Le pipeline a échoué ❌"
            // emailext (
            //     from: "${SENDER_NOTIFICATION_EMAIL}",
            //     to: "${RECEIVER_NOTIFICATION_EMAIL}",
            //     subject: "Échec du Déploiement : ${env.JOB_NAME} #${env.BUILD_NUMBER}",
            //     body: """
            //         <p>Bonjour,</p>
            //         <p>Le pipeline <b>${env.JOB_NAME}</b> (build #${env.BUILD_NUMBER}) a échoué.</p>
            //         <p>Veuillez consulter les logs : <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></p>
            //         <p>Cordialement.</p>
            //     """
            // )
        }
    }
}
