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
            bat "if not exist .git git clone https://github.com/stefscherer/packer-windows ."
            bat "git pull"
            bat "packer build --only hyperv-iso windows_10.json"
            bat "dir"
          }
        }
      }
    }
  }
}
