pipeline {
    agent any   // Exécute sur n'importe quel agent disponible

    stages {
        stage('Checkout') {
            steps {
                // Récupère le code source depuis Git
                git branch: 'main', url: 'https://github.com/morlayecisse1196/projet-devops.git'
            }
        }

        stage('Install dependencies') {
            steps {
                // Installe les dépendances Node.js
                sh 'npm install'
            }
        }

        stage('Build') {
            steps {
                // Lance le build (si défini dans package.json)
                sh 'npm run build'
            }
        }

        stage('Test') {
            steps {
                // Exécute les tests unitaires
                sh 'npm test'
            }
        }

        stage('Deploy') {
            steps {
                // Exemple de déploiement (à adapter selon ton infra)
                echo 'Déploiement de l’application...'
            }
        }
    }

    post {
        success {
            echo 'Pipeline exécuté avec succès ✅'
        }
        failure {
            echo 'Pipeline échoué ❌'
        }
    }
}
