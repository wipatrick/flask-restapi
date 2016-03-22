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
For testing purposes, you can use official [PostgreSQL](https://hub.docker.com/r/_/postgres/) Docker image as follow:
```
docker pull postgres:9.3
docker run -d -p 5432:5432 -v $(pwd)/sql:/data -e POSTGRES_PASSWORD=password --name postgres-db postgres:9.3
docker exec -it postgres-db bash
root@8254335c8597:/# psql -U postgres -d postgres -a -f /data/setup.sql
...
(3, 1452510897.95, 21.9),
(4, 1452510897.95, 21.8),
(5, 1452510897.95, 23),
(6, 1452510897.95, 22.4),
(7, 1452510897.95, 0);
INSERT 0 42
root@80f7ee057570:/# exit
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

## API

| HTTP | Endpoint                         | Description                      |
|------|----------------------------------|----------------------------------|
| GET  | /api/v1/sensors                  | get metadata from all sensors    |
| GET  | /api/v1/sensors/<id>             | get metadata from sensor <id>    |
| GET  | /api/v1/sensors/<id>/data        | get all data from sensor <id>    |
| GET  | /api/v1/sensors/<id>/data/latest | get latest data from sensor <id> |
