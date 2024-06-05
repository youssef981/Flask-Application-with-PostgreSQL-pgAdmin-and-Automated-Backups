pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/<your-username>/<your-repo>.git'
        DOCKER_COMPOSE_PATH = '.' // Jenkinsfile is in the same directory
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: "${env.REPO_URL}"
            }
        }

        stage('Build and Deploy') {
            steps {
                sh 'docker-compose down'
                sh 'docker-compose up -d --build'
            }
        }

        stage('Backup Database') {
            steps {
                sh 'docker-compose run backup'
            }
        }
    }
}
