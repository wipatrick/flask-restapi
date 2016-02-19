from flask import Flask, jsonify, abort, request, json
from sqlalchemy import desc, func
from sqlalchemy.orm.exc import NoResultFound
from db.models import db, Meta, Sensordata, meta_schema, metas_schema, sensordata_schema, sensordatas_schema

app = Flask(__name__)

app.config.from_pyfile('conf/psql-config.py')
db.init_app(app)

@app.route('/api/v1/sensors/', methods = ['GET'])
def get_all_sensors():
    s = Meta.query.all()
    # serialize the queryset
    result = metas_schema.dump(s)
    return jsonify({'sensors': result.data})


@app.route('/api/v1/sensors/<int:id>', methods = ['GET'])
def get_sensor(id):
    try:
        # m = Meta.query.get(id)
        # in order to fetch NoResultFound exception it is neccessary to query the primary key as follows:
        m = Meta.query.filter_by(sid=id).one()
        meta_result = meta_schema.dump(m)
        return jsonify({'sensors': meta_result.data})
    except NoResultFound:
        return jsonify({"message": "Sensor could not be found."}), 400

@app.route('/api/v1/sensors/<int:id>/data/', methods = ['GET'])
def get_all_data_sensor(id):
    try:
        m = Meta.query.filter_by(sid=id).one()
        meta_result = meta_schema.dump(m)
        sensor_result = sensordatas_schema.dump(m.sensordata.all())
        return jsonify({'sensors': meta_result.data, 'data': sensor_result.data})
    except NoResultFound:
        return jsonify({"message": "Sensor could not be found."}), 400

# to be implemented
# @app.route("/api/v1/sensors/data/latest")
# def get_latest_data_all_sensors():

@app.route("/api/v1/sensors/<int:id>/data/latest")
def get_latest_data_sensor(id):
    try:
        m = Meta.query.filter_by(sid=id).one()
        meta_result = meta_schema.dump(m)
        # query the latest unix_epoch for this <id>
        # order_by: unix_epoch descending
        # with_entities: only return column unix_epoch
        # first(): only get first entry
        qry = Sensordata.query.filter_by(sid=id).order_by(desc('unix_epoch')).with_entities('unix_epoch').first()
        # convert this entry into a scalar representation that can be used for filtering
        max = db.session.query(db.func.max(qry)).scalar()
        sensor_result = sensordatas_schema.dump(m.sensordata.filter_by(unix_epoch=max))
        return jsonify({'sensors': meta_result.data, 'data': sensor_result.data})
    except NoResultFound:
        return jsonify({"message": "Sensor could not be found."}), 400



if __name__ == '__main__':
    app.run(debug=True)
