pipeline {
  agent none

  stages {
    stage('Test templates') {
      parallel {
        stage('Test on Windows') {
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
            sh "./test.sh"
          }
        }
      }
    }
  }
}
