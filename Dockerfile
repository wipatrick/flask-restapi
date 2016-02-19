# Dockerfile for packaging flask-webapp
FROM python:2.7

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app/
RUN pip install -v -r requirements.txt

COPY . /usr/src/app

EXPOSE 8080

CMD [ "python", "./api.py" ]
