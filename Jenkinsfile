pipeline {
  agent none

  stages {
    stage('Test templates') {
      parallel {
        stage('Test on Windows') {
          agent {
            label 'packerwin'
          }
          steps {
            bat "dir"
            checkout scm
            bat "packer build --only hyperv-iso windows_10.json"
          }
        }
      }
    }
  }
}
