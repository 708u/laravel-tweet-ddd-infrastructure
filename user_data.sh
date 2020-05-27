#!/bin/bash
echo ECS_CLUSTER=laravel-tweet-ddd-cluster >> /etc/ecs/ecs.config
sudo yum update -y
sudo yum install unzip -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
