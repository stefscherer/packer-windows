pipeline {
  agent none

  stages {
    stage('Test templates') {
      parallel {
        stage('Packer build Windows Server 2016 Hyper-V') {
          agent {
            label 'packerwin'
          }
          steps {
            bat "packer build --only hyperv-iso windows_2016.json"
          }
        }
        stage('Packer build Windows Server 2016 and Docker Hyper-V') {
          agent {
            label 'packerwin'
          }
          steps {
            bat "packer build --only hyperv-iso windows_2016_docker.json"
          }
        }
        stage('Packer build Windows 10 Hyper-V') {
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
