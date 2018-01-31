stage('Build') {
  parallel windows_2016: {
    node('packerwin') {
      checkout scm
      bat "dir"
      bat "build.bat windows_2016.json"
      bat "dir"
    }
  },
  windows_2016_docker: {
    node('packerwin') {
      checkout scm
      bat "dir"
      bat "build.bat windows_2016_docker.json"
      bat "dir"
    }
  },
  windows_10: {
    node('packerwin') {
      checkout scm
      bat "dir"
      bat "build.bat windows_10.json"
      bat "dir"
    }
  }
}
