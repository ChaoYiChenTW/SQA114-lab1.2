#!/bin/bash

# Prerequisite
sudo yum -y update
sudo yum -y install git

# Install python3, pip, and virtualenv
sudo yum -y install python3
sudo yum -y install python3-pip
sudo pip3 install virtualenv

# INstall selenium environment
mkdir tmp
cd tmp

# Prepare Google Chrome and ChromeDriver
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo yum install -y google-chrome-stable_current_x86_64.rpm
CHROME_VERSION=$(google-chrome --version | grep -oP "\d+\.\d+\.\d+\.\d+")
echo "Installed Google Chrome version: $CHROME_VERSION"
wget https://storage.googleapis.com/chrome-for-testing-public/$CHROME_VERSION/linux64/chromedriver-linux64.zip
unzip chromedriver-linux64.zip
sudo mv chromedriver-linux64/chromedriver /usr/local/bin/
chromedriver --version

cd ..

# Create a virtual environment
virtualenv -p python3.9 lab1_2
source ./lab1_2/bin/activate
pip3 install selenium

git init
git clone https://github.com/eduval/Kelownatrails
cp -r Kelownatrails/public .
cp Kelownatrails/Jenkinsfile.txt .
rm -rf Kelownatrails/

# Install Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum -y install jenkins
sudo yum remove java-22-amazon-corretto.x86_64
sudo yum -y install java-21-amazon-corretto

# Run Jenkins
sudo service jenkins start
sudo fallocate -l 1G /swapfile_extend_1GB
sudo mount -o remount,size=5G /tmp/

