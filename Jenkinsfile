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
            bat "bin\build.bat windows_10_hyperv"
            bat "dir windows_10_hyperv.box"
          }
        }
      }
    }
  }
}
