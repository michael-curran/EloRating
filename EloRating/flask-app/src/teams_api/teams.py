from flask import Blueprint, request, jsonify, make_response
import json
from src import db

team_blueprint = Blueprint('team_blueprint', __name__)

# Get all team from the DB
@team_blueprint.route('/info', methods=['GET'])
def get_teamsinfo():
    cursor = db.get_db().cursor()
    cursor.execute('select * from Team')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
 #   the_response = make_response(jsonify(json_data))
 #   the_response.status_code = 200
 #   the_response.mimetype = 'application/json'
    return jsonify(json_data)

# get the top 5 teams from the database
@team_blueprint.route('/3MostWins')
def get_mostwins():
    cursor = db.get_db().cursor()
    query = '''
        SELECT *
        FROM Team
        ORDER BY TeamWins DESC
        LIMIT 3ß;
    '''
    cursor.execute(query)
       # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


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
