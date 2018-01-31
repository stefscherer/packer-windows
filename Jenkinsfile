pipeline {
  agent none

  stages {
    stage('Build') {
      parallel {
        stage('windows_10') {
          agent {
            label 'packerwin'
          }
          steps {
            bat "if not exist .git git clone https://github.com/stefscherer/packer-windows ."
            bat "packer build --only hyperv-iso windows_10.json"
            bat "dir windows_10_hyperv.box"
            bat "bin\\test-box-hyperv.bat windows_10_hyperv.box windows_10"
          }
        }
      }
    }
  }
}
