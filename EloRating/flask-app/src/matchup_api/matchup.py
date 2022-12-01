from flask import Blueprint, request, jsonify, make_response, render_template
import json
from src import db


matchup_blueprint = Blueprint('matchup_blueprint', __name__)

@matchup_blueprint.route('/info', methods=['GET'])
def get_playerinfo():
    cursor = db.get_db().cursor()
    cursor.execute('select * from Matchups')
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

@matchup_blueprint.route('/info/<mnum>', methods=['GET'])
def get_indleagueinfo(mnum):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Matchups where MatchupNum = {0}'.format(mnum))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response