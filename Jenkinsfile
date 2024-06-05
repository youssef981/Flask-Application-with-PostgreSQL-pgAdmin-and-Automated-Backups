pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/youssef981/Flask-Application-with-PostgreSQL-pgAdmin-and-Automated-Backups.git'
        DOCKER_COMPOSE_PATH = '.' // Jenkinsfile is in the same directory
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    // Debug step to print Git version and environment details
                    sh 'git --version'
                    sh 'env'
                }
                // Clone the repository
                git branch: 'master', url: "${env.REPO_URL}"
            }
        }

        stage('Build and Deploy') {
            steps {
                script {
                    // Debug step to print Docker version
                    sh 'docker --version'
                    sh 'docker-compose --version'
                }
                // Bring down any existing containers
                sh 'docker-compose down || true' // Ignore errors if no containers are running
                // Build and bring up the containers
                sh 'docker-compose up -d --build'
            }
        }

        stage('Backup Database') {
            steps {
                // Run the backup service
                sh 'docker-compose run backup'
            }
        }
    }

    post {
        always {
            script {
                // Ensure that all containers are brought down at the end of the pipeline
                sh 'docker-compose down'
            }
        }
        failure {
            script {
                // Additional debug information if the pipeline fails
                echo 'Pipeline failed! Gathering debug information...'
                sh 'docker-compose logs'
            }
        }
    }
}
