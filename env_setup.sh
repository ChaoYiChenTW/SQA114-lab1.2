#!/bin/bash

# Prerequisite
sudo yum -y update
sudo yum -y install git

# Install Node.js and npm
sudo yum -y install nodejs
sudo yum -y install npm

# Install Firebase
sudo npm install -g firebase-tools --no-optional

# Install python3, pip, and virtualenv
sudo yum -y install python3
sudo yum -y install python3-pip
sudo python3 -m pip install selenium
sudo python3 -m pip install --upgrade urllib3==1.26.7
sudo python3 -m pip install selenium
sudo python3 -m pip install pytest

# Prepare Google Chrome and ChromeDriver
mkdir tmp
cd tmp
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo yum install -y google-chrome-stable_current_x86_64.rpm
CHROME_VERSION=$(google-chrome --version | grep -oP "\d+\.\d+\.\d+\.\d+")
echo "Installed Google Chrome version: $CHROME_VERSION"
wget https://storage.googleapis.com/chrome-for-testing-public/$CHROME_VERSION/linux64/chromedriver-linux64.zip
unzip chromedriver-linux64.zip
sudo mv chromedriver-linux64/chromedriver /usr/local/bin/
chromedriver --version
cd ..
rm -rf tmp

# Install Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum -y install jenkins
sudo yum remove java-22-amazon-corretto.x86_64
sudo yum -y install java-21-amazon-corretto

# Run Jenkins
sudo fallocate -l 1G /swapfile_extend_1GB
sudo mount -o remount,size=5G /tmp/
sudo service jenkins start
