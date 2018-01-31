pipeline {
  agent none

  stages {
    stage('Packer build') {
      parallel {

        stage('windows_2016 hyperv') {
          agent {
            label 'packerwin'
          }
          steps {
            bat "packer build --only hyperv-iso windows_2016.json"
          }
        }

        stage('windows_2016_docker hyperv') {
          agent {
            label 'packerwin'
          }
          steps {
            bat "packer build --only hyperv-iso windows_2016_docker.json"
          }
        }

        stage('windows_10 hyperv') {
          agent {
            label 'packerwin'
          }
          steps {
            bat "packer build --only hyperv-iso windows_10.json"
          }
        }

      }
    }
  }
}
