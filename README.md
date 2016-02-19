## flask-restapi
A Flask based RESTful API using SQLAlchemy to communicate with PostgreSQL

## Getting started
Build docker image:
```
git clone https://github.com/wipatrick/flask-restapi.git
cd flask-restapi
docker build -t flask-restapi:2.7
...
docker images
REPOSITORY                                TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
flask-app                                 2.7                 sha256:eaf3e        10 minutes ago      699.2 MB
```
Now you can ```docker run``` the flask-app by setting the neccessary environment variables:
```
docker run -d \
      -p 8080:8080 \
      -e DB_NAME='<db_name>' \
      -e DB_HOST='<db_host>' \
      -e DB_PORT='<db_port>' \
      -e DB_USER='<db_user>' \
      -e USER_PASSWORD='<user_password>' \
      --name flask \
      flask-app:2.7
...
docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
e45b7aeb04ce        flask-app:2.7       "python ./api.py"        2 seconds ago       Up 1 seconds        0.0.0.0:8080->8080/tcp   flask
```

## To Do:
* define endpoint to receive latest values for all sensors
* make docker image smaller (~700MB due to base image python:2.7)
