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
                sh 'docker-compose down || true'
                sh 'docker-compose up -d --build'
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
