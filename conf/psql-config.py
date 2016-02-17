import os

# Local Testing
db_name = "postgres"
db_host = "192.168.99.100"
db_port = "5432"
db_user = "postgres"
user_password = "password"

# db_name = os.environ["DB_NAME"]
# db_host = os.environ["DB_HOST"]
# db_port = os.environ["DB_PORT"]
# db_user = os.environ["DB_USER"]
# user_password = os.environ["USER_PASSWORD"]

SQLALCHEMY_TRACK_MODIFICATIONS=True
SQLALCHEMY_DATABASE_URI='postgresql://' + db_user + ':' + user_password + '@' + db_host + '/' + db_name
