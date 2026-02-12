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

        stage('SAST - SonarQube') {
            steps {
                withSonarQubeEnv('SonarQubeScanner') {
                    sh 'sonar-scanner -Dsonar.projectKey=Annive_Juliana'
                }
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
       
        stage('Image Scan') {
            steps {
                sh '''
                if command -v trivy >/dev/null 2>&1; then
                  if docker images | grep -q "annive_juliana"; then
                    trivy image annive_juliana || true
                  else
                    echo "Image Docker 'annive_juliana' introuvable, étape ignorée."
                  fi
                else
                  echo "Trivy non installé, étape ignorée."
                fi
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh 'rm -rf /var/www/html/*'
                sh 'cp -r * /var/www/html/'
            }
        }
    }
}
