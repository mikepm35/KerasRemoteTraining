FROM tensorflow/tensorflow:1.13.1-py3

RUN useradd -ms /bin/bash kerasdeploy

WORKDIR /home/kerasdeploy

RUN apt-get update && apt-get install -y git

COPY keras_remote_training.ipynb winequality-red.csv requirements.txt ./

RUN pip install -r requirements.txt

RUN chown -R kerasdeploy:kerasdeploy ./
USER kerasdeploy

RUN jupyter nbconvert --to script keras_remote_training.ipynb 

CMD ["python","-u","keras_remote_training.py"]