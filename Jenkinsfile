pipeline {
    agent none

    stages {
        stage('Build Windows') {
            agent {
                label 'windows'
            }
            steps {
                powershell ". ./test.ps1"
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
