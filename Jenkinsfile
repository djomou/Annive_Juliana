pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/djomou/Annive_Juliana.git'
            }
        }

        stage('Build') {
            steps {
                sh 'echo "Construction du site statique..."'
            }
        }

        stage('Test') {
            steps {
                sh 'test -f joyeux anniversaire Juliana.html'
            }
        }

        stage('Deploy') {
            steps {
                sh 'sudo rm -rf /var/www/html/*'
                sh 'sudo cp -r * /var/www/html/'
            }
        }
    }
}
