pipeline {
    agent none

    stages {
        stage('Build Windows') {
            agent {
                label 'windows'
            }
            steps {
                iwr -useb https://chocolatey.org/install.ps1 | iex
                choco install -y packer -version 1.1.3
                .\test.ps1
            }
        }
        stage('Build Linux') {
            agent {
                label 'linux'
            }
            steps {
              mkdir /opt/packer
              pushd /opt/packer
              PACKER_VERSION=1.1.3
              echo "Downloading packer ${PACKER_VERSION} ...."
              curl -L -o ${PACKER_VERSION}_linux_amd64.zip https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
              echo "Installing packer ${PACKER_VERSION} ..."
              unzip ${PACKER_VERSION}_linux_amd64.zip
              rm ${PACKER_VERSION}_linux_amd64.zip
              pushd /usr/bin
              ln -s /opt/packer/* .
              popd
            }
        }
    }
}
