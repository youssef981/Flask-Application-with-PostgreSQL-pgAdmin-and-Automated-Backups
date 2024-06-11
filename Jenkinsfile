pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/youssef981/Flask-Application-with-PostgreSQL-pgAdmin-and-Automated-Backups.git'
        DOCKER_COMPOSE_PATH = '.'
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    sh 'git --version'
                    sh 'env'
                }
                git branch: 'master', url: "${env.REPO_URL}"
            }
        }

        stage('Build and Deploy') {
            steps {
                script {
                    sh 'docker --version'
                    sh 'docker-compose --version'
                }
                // Shut down existing Docker containers and remove volumes to avoid old code being used
                sh 'docker-compose down -v || true'
                // Remove old Docker images
                sh 'docker image prune -f'
                // Build and start the Docker containers in detached mode
                sh 'docker-compose up -d --build'
                // Wait for the Flask application to be ready
                sh '''
                    echo "Waiting for the Flask application to be ready..."
                    while ! curl -s http://localhost:5000/; do
                        sleep 5
                    done
                    echo "Flask application is up and running!"
                '''
            }
        }

        stage('Backup Database') {
            steps {
                sh 'docker-compose run backup'
            }
        }
    }

    post {
        failure {
            script {
                echo 'Pipeline failed! Gathering debug information...'
                sh 'docker-compose logs'
            }
        }
        cleanup {
            script {
                echo 'Cleanup step - Docker containers will remain up and running.'
            }
        }
    }
}
