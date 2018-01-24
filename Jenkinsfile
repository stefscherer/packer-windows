pipeline {
    agent any

    stages {
        stage('Build') {
            agent {
                label 'windows'
            }
            steps {
                iwr -useb https://chocolatey.org/install.ps1 | iex
                choco install -y packer -version 1.1.3
            }
        }
        stage('Test') {
            agent {
                label 'windows'
            }
            steps {
                .\test.ps1
            }
        }
    }
}
