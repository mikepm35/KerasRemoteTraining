#!/bin/bash
# Assumes container build with aws linux image ami-0f812849f5bc97db5
sudo yum install -y unzip
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
$(aws ecr get-login --no-include-email --region <region>)
docker pull \
  <ecr_id>.dkr.ecr.<region>.amazonaws.com/keras-remote-training:latest
docker run \
  --name keras-remote-training -d --rm \
  <ecr_id>.dkr.ecr.<region>.amazonaws.com/keras-remote-training:latest
