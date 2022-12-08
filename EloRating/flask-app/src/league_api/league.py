from flask import Blueprint, request, jsonify, make_response, render_template
import json
from src import db


league_blueprint = Blueprint('league_blueprint', __name__)

#get info from league
@league_blueprint.route('/info', methods=['GET'])
def get_playerinfo():
    cursor = db.get_db().cursor()
    cursor.execute('select * from League')
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# get info for a specific league
@league_blueprint.route('/info/<lname>', methods=['GET'])
def get_indleagueinfo(lname):
    cursor = db.get_db().cursor()
    cursor.execute('select * from League where LeagueName = {0}'.format(lname))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response