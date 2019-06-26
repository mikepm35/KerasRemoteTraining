# KerasRemoteTraining

Example notebook and scripts to develop a Talos optimization experiment
locally, and then deploy to the cloud for execution.

View the companion article on Medium:
https://medium.com/@mike.p.moritz/keras-hyperparameter-optimization-on-aws-cbd494a7ea15?source=friends_link&sk=fb831dda0c462c355f699ba4c68a0c17

## Stand up local environment
From local machine terminal:
```
docker run -it -p 8888:8888 --rm -v $PWD:/root -w /root tensorflow/tensorflow:1.13.1-py3
```

In container:
```
apt-get update && apt-get install -y git && pip install -r requirements.txt
jupyter notebook --ip=0.0.0.0 --no-browser --allow-root
```

## Build custom Docker container and deploy
```
docker build -t keras-remote-training .

docker run --name keras-remote-training --rm keras-remote-training:latest

docker tag \
  keras-remote-training:latest \
  <ecr_id>.dkr.ecr.<region>.amazonaws.com/keras-remote-training:latest

docker push \
<ecr_id>.dkr.ecr.<region>.amazonaws.com/keras-remote-training:latest
```

## Examine/copy files mid-experiment on remote server

Create a copy of the in-progress file:
```
docker cp <container_id>:/home/kerasdeploy/<experiment_name>.csv .
```

Backup the in-progress file to S3:
```
aws s3 cp <experiment_name>.csv s3://<s3_bucket>/
```

View line length of in-progress file:
```
python -c "print(sum(1 for line in open('<experiment_name>.csv')))"
```
