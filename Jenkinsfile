pipeline {
  agent { label 'packerwin' }

  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build') {
      steps {
        bat "dir"
        bat "packer build --only hyperv-iso windows_10.json"
        bat "dir"
      }
    }

  }
}
