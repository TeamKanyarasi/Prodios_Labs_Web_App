#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install docker.io -y
sudo usermod -aG docker ubuntu
sudo systemctl start docker
sudo docker pull charanyandrapu/prodioslabswebapp:latest
sudo docker run -it -d -p 80:3000 \
        -e AWS_ACCESS_KEY_ID: "[Your Access Key ID]" \
        -e AWS_SECRET_ACCESS_KEY: "[Your Secret Access Key]" \
        -e S3_BUCKET_NAME: "[Your S3 Bucket Name]" \
        -e AWS_REGION: "[Your AWS Region]" \
        --name charanyandrapu/prodioslabswebapp:latest