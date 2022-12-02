from flask import Blueprint, request, jsonify, make_response, render_template, redirect, url_for, current_app
import json
from src import db


players_blueprint = Blueprint('players_blueprint', __name__)

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

@players_blueprint.route('/addplayer', methods=["POST", "GET"])
def addplayer():
    if request.method=="POST":
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
        tlog = request.form['tlog']
        cursor = db.get_db().cursor()
        query = f'''
                Insert Into Player(firstName, lastName, birthdayYear, gender, stateAddress, cityAddress, streetAddress, EloRating, Play_TeamID, Age, T_LogID)
                Values ("{first_name}", "{last_name}",
                {yob}, "{gen}", "{state}", "{city}", "{street}", {er},
                {team}, {age}, {tlog});
                '''
        cursor.execute(query)
        db.get_db().commit()
        current_app.logger.info(query)
        return "Player Added"
    else:
        return render_template('add_player.html')
