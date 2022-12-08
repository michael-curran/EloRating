from flask import Blueprint, request, jsonify, make_response
import json
from src import db

team_blueprint = Blueprint('team_blueprint', __name__)

# Get all team info from the DB
@team_blueprint.route('/info', methods=['GET'])
def get_teamsinfo():
    cursor = db.get_db().cursor()
    cursor.execute('select * from Team')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))

    return jsonify(json_data)

@team_blueprint.route('/teamname', methods=['GET'])
def get_teamsname():
    cursor = db.get_db().cursor()
    cursor.execute('select TeamID as value, TeamName as label from Team')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))

    return jsonify(json_data)

#post request to add a team to a db
@team_blueprint.route('/addteam', methods=["POST"])
def addteam():
    team_wins = request.form['tw']
    team_loss = request.form['tl']
    team_name = request.form['tn']
    captain_name = request.form['cn']
    owner_id = request.form['oi']
    elo_rating = request.form['er']
    cursor = db.get_db().cursor()
    query = f'''
            Insert Into Team(TeamWins, TeamLoss, TeamName, CaptainID, OwnerID, EloRating)
            Values ({team_wins}, {team_loss},
            "{team_name}", "{captain_name}", {owner_id}, {elo_rating});
            '''
    cursor.execute(query)
    db.get_db().commit()
    return "Team Added"
