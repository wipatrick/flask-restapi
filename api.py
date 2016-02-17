from flask import Flask, jsonify, abort, request, json
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.inspection import inspect
from datetime import datetime

app = Flask(__name__)

app.config.from_pyfile('conf/psql-config.py')
db = SQLAlchemy(app)

# this Serializer class is needed to serialize a SQLAlchemy object to jsonify
class Serializer(object):
    def serialize(self):
        return {c: getattr(self, c) for c in inspect(self).attrs.keys()}

    @staticmethod
    def serialize_list(l):
        return [m.serialize() for m in l]

class Sensor(db.Model, Serializer):
    __tablename__ = 'tbl_sensor'
    sid = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(20))
    type = db.Column(db.String(20))
    measurement = db.Column(db.String(20))
    measurement_unit = db.Column(db.String(20))
    accuracy = db.Column(db.Float)
    accuracy_unit = db.Column(db.String(20))
    update_rate = db.Column(db.Float)
    update_rate_unit = db.Column(db.String(20))
    position = db.Column(db.String(20))
    description = db.Column(db.String(50))

    def __init__(self, name, type, measurement, measurement_unit, accuracy, accuracy_unit, update_rate, update_rate_unit, position, description):
        self.name = name
        self.type = type
        self.measurement = measurement
        self.measurement_unit = measurement_unit
        self.accuracy = accuracy
        self.accuracy_unit = accuracy_unit
        self.update_rate = update_rate
        self.update_rate_unit = update_rate_unit
        self.position = position
        self.description = description


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
