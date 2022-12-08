from flask import Blueprint, request, jsonify, make_response, render_template, redirect, url_for, current_app
import json
from src import db


players_blueprint = Blueprint('players_blueprint', __name__)

#get all players info
@players_blueprint.route('/info', methods=['GET'])
def get_playerinfo():
    cursor = db.get_db().cursor()
    cursor.execute('select * from Player')
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

#get players with top 5 elo rating
@players_blueprint.route('/top5Elo', methods=['GET'])
def get_topelo():
    cursor = db.get_db().cursor()
    query = '''
        SELECT *
        FROM Player
        ORDER BY EloRating DESC
        LIMIT 5;
    '''
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

@players_blueprint.route('/skills', methods=['GET'])
def get_skill():
    cursor = db.get_db().cursor()
    query = 'Select SkillID as value, SkillName as label from Skill'
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

#post request to add a player into the db
@players_blueprint.route('/addplayer', methods=["POST"])#, "GET"])
def addplayer():
    #if request.method=="POST":
    current_app.logger.info(request.form)
    first_name = request.form['fn']
    last_name = request.form['ln']
    yob = request.form['yob']
    gen = request.form['gen']
    state = request.form['state']
    city = request.form['city']
    street = request.form['st']
    er = request.form['er']
    team = request.form['tid']
    age = request.form['age']
    skillid = request.form['sid']
    cursor = db.get_db().cursor()
    query = f'''
            Insert Into Player(firstName, lastName, birthdayYear, gender, stateAddress, cityAddress, streetAddress, EloRating, Play_TeamID, Age, SkillID)
            Values (\"{first_name}\", \"{last_name}\",
            \"{yob}\", \"{gen}\", \"{state}\", \"{city}\", \"{street}\", \"{er}\",
            \"{team}\", \"{age}\", \"{skillid}\");
            '''
    cursor.execute(query)
    db.get_db().commit()
    current_app.logger.info(query)
    return "Player Added"
    #else:
      #  return render_template('add_player.html')
