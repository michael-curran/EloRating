from flask import Blueprint, request, jsonify, make_response
import json
from src import db


owners_blueprint = Blueprint('owners_blueprint', __name__)

#get info for all owners
@owners_blueprint.route('/info', methods=['GET'])
def get_ownerinfo():
    cursor = db.get_db().cursor()
    cursor.execute('select * from Owners')
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

#info for owners from Montana
@owners_blueprint.route('/MontanaOwners', methods=['GET'])
def get_montowners():
    cursor = db.get_db().cursor()
    cursor.execute('select * from Owners where stateAddress="Montana"')
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)