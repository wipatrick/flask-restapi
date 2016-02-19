from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.inspection import inspect
from marshmallow import Schema, fields, ValidationError, pre_load

db = SQLAlchemy()

# this Serializer class is needed to serialize a SQLAlchemy object to jsonify
# class Serializer(object):
#     def serialize(self):
#         return {c: getattr(self, c) for c in inspect(self).attrs.keys()}
#
#     @staticmethod
#     def serialize_list(l):
#         return [m.serialize() for m in l]

# Models
class Meta(db.Model):
    __tablename__ = 'tbl_sensor_meta'
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

class Sensordata(db.Model):
    __tablename__ = 'tbl_sensor_data'
    id = db.Column(db.Integer, primary_key=True)
    unix_epoch = db.Column(db.String)
    data = db.Column(db.Float)
    sid = db.Column(db.Integer, db.ForeignKey('tbl_sensor_meta.sid'), nullable=False)
    meta = db.relationship('Meta', backref=db.backref('sensordata', lazy='dynamic'))

    def __init__(self, id, meta_id, unix_epoch, data):
        self.id = id
        self.meta_id = meta_id
        self.unix_epoch = unix_epoch
        self.data = data

# Schema
class MetaSchema(Schema):
    class Meta:
        ordered=True

    sid = fields.Int(dump_only=True)
    name = fields.Str()
    type = fields.Str()
    measurement = fields.Str()
    measurement_unit = fields.Str()
    accuracy = fields.Float()
    accuracy_unit = fields.Str()
    update_rate = fields.Float()
    update_rate_unit = fields.Str()
    position = fields.Str()
    description = fields.Str()


# Custom validator
def must_not_be_blank(data):
    if not data:
        raise ValidationError('Data not provided.')

class SensordataSchema(Schema):
    class Meta:
        ordered=True

    id = fields.Int(dump_only=True)
    meta = fields.Nested(MetaSchema)
    unix_epoch = fields.Str(required=True)
    data = fields.Float()


meta_schema = MetaSchema()
# meta2_schema = MetaSchema(only=('sid', 'name', 'type', 'measurement','measurement_unit'))
metas_schema = MetaSchema(many=True)
sensordata_schema = SensordataSchema()
sensordatas_schema = SensordataSchema(many=True, only=('id', 'data', 'unix_epoch'))
