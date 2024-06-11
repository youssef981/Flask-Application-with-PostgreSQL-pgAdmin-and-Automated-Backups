pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "my-node-app"
        DOCKER_TAG = "1.0"
        CONTAINER_NAME = "my-node-app"
        DOCKERHUB_REPO = "erramlysalma/my-node-app"
    }

    stages {
        stage("Checkout") {
            steps {
                checkout scm
            }
        }
        stage("Clean Up Old Container") {
            steps {
                script {
                    // Stop and remove the old container if it exists
                    sh """
                    if [ \$(docker ps -aq -f name=${CONTAINER_NAME}) ]; then
                        docker stop ${CONTAINER_NAME} || true
                        docker rm ${CONTAINER_NAME} || true
                    fi
                    """
                }
            }
        }
        stage("Remove Old Image") {
            steps {
                script {
                    // Remove the old image if it exists
                    sh """
                    if [ \$(docker images -q ${DOCKER_IMAGE}:${DOCKER_TAG}) ]; then
                        docker rmi ${DOCKER_IMAGE}:${DOCKER_TAG} || true
                    fi
                    """
                }
            }
        }
        stage("Build Image") {
            steps {
                // Build the new Docker image
                sh "docker build --no-cache -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
            }
        }
        stage("Run New Container") {
            steps {
                // Run the new Docker container with the updated image
                sh "docker run -d --name ${CONTAINER_NAME} -p 82:3000 ${DOCKER_IMAGE}:${DOCKER_TAG}"
            }
        }
        stage('Docker Push') {
            steps {
                script {
                    // Push the Docker image to Docker Hub
                    sh "docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD"
                    sh "docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKERHUB_REPO}:${DOCKER_TAG}"
                    sh "docker push ${DOCKERHUB_REPO}:${DOCKER_TAG}"
                    sh "docker logout"
                }
            }
        }
    }
}
