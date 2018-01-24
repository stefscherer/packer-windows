pipeline {
    agent none

    stages {
        stage('Build Windows') {
            agent {
                label 'windows'
            }
            steps {
                bat "powershell -command 'iwr -useb https://chocolatey.org/install.ps1 | iex'"
                bat "choco install -y packer -version 1.1.3"
                bat "powershell -file .\test.ps1"
            }
        }
        stage('Build Linux') {
            agent {
                label 'linux'
            }
            steps {
              sh "echo hello linux"
            }
        }
    }
}
