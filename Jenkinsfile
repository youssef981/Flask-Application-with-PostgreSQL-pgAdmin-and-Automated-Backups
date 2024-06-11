pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/youssef981/Flask-Application-with-PostgreSQL-pgAdmin-and-Automated-Backups.git'
        DOCKER_COMPOSE_PATH = '.'
        DOCKER_IMAGE = 'my-flask-app'
        DOCKER_TAG = 'latest'
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
                // Build the new Docker image
                sh "docker build --no-cache -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
                // Start the Docker containers defined in the Docker Compose file
                sh 'docker-compose up -d'
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
        
        stage('Docker Push') {
            steps {
                script {
                    // Tag the Docker image for pushing to Docker Hub
                    sh "docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${env.DOCKERHUB_REPO}:${DOCKER_TAG}"
                    // Log in to Docker Hub and push the tagged image
                    sh "docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD"
                    sh "docker push ${env.DOCKERHUB_REPO}:${DOCKER_TAG}"
                    sh "docker logout"
                }
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
                // Ensure that all Docker containers are shut down at the end of the pipeline
                sh 'docker-compose down'
            }
        }
    }
}
