pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/djomou/Annive_Juliana.git',
                    credentialsId: 'github-token'
            }
        }

        stage('Build') {
            steps {
                sh 'echo "Construction du site statique..."'
            }
        }

        stage('Test') {
            steps {
                sh 'test -f "joyeux anniversaire Juliana.html"'
            }
        }

        stage('SAST') {
            steps {
                sh '''
                if command -v sonar-scanner >/dev/null 2>&1; then
                  sonar-scanner -Dsonar.projectKey=Annive_Juliana || true
                else
                  echo "SonarQube Scanner non installé, étape ignorée."
                fi
                '''
            }
        }

        stage('Dependency Scan') {
            steps {
                sh '''
                if [ -f package.json ]; then
                  if command -v npm >/dev/null 2>&1; then
                    npm audit --json || true
                  else
                    echo "npm non installé, étape ignorée."
                  fi
                else
                  echo "Pas de package.json, étape ignorée."
                fi
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t annive_juliana:latest .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'Credential-docker', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh '''
                    echo "$PASS" | docker login -u "$USER" --password-stdin
                    docker tag annive_juliana:latest $USER/annive_juliana:latest
                    docker push $USER/annive_juliana:latest
                    '''
                }
            }
        }

        stage('Image Scan') {
            steps {
                sh '''
                if command -v trivy >/dev/null 2>&1; then
                  trivy image $USER/annive_juliana:latest || true
                else
                  echo "Trivy non installé, étape ignorée."
                fi
                '''
            }
        }
    }
}
