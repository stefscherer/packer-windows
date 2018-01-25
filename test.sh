#!/bin/bash

PACKER_VERSION=1.1.3
VIRTUALBOX_VERSION=5.2.6

sudo apt-get update -qq

# install git
sudo apt-get install -qq git unzip

# install packer
sudo mkdir /opt/packer
pushd /opt/packer
echo "Downloading packer ${PACKER_VERSION} ...."
sudo curl -L -o ${PACKER_VERSION}_linux_amd64.zip https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
echo "Installing packer ${PACKER_VERSION} ..."
sudo unzip ${PACKER_VERSION}_linux_amd64.zip
sudo rm ${PACKER_VERSION}_linux_amd64.zip
pushd /usr/bin
sudo ln -s /opt/packer/* .
popd

echo "deb http://download.virtualbox.org/virtualbox/debian xenial contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list

wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

sudo apt-get update

sudo apt-get install -y virtualbox-5.2 dkms

echo "Run Packer build"
packer build --only virtualbox-iso windows_2016.json
