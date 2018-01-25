pipeline {
    agent none

    stages {
        stage('Build Windows') {
            agent {
                label 'windows'
            }
            steps {
                powershell "iwr -useb https://chocolatey.org/install.ps1 | iex"
                powershell "choco install -y packer -version 1.1.3"
                powershell ".\test.ps1"
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
