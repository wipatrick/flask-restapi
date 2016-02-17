from flask import Flask, jsonify, abort, request, json
from db.models import db, Sensor

app = Flask(__name__)

app.config.from_pyfile('conf/psql-config.py')
db.init_app(app)

@app.route('/api/v1/sensors/', methods = ['GET'])
def get_all_sensors():
    s = Sensor.query.all()
    return jsonify(sensors = Sensor.serialize_list(s))

@app.route('/api/v1/sensors/<int:id>', methods = ['GET'])
def get_sensor(id):
    s = Sensor.query.get(id)
    return jsonify(sensors = Sensor.serialize(s))

if __name__ == '__main__':
    app.run(debug=True)
