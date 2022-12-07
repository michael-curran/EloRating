## EloRating:
    The objective of the EloRating application is to allow people who work in competitive organizations 
    to be able to organise people into league and/or teams. As well it tracks the elo rating a player 
    through out there competitive tenur. In the app you can add players to teams and navigate through
    the players teams and owners of said teams.

# Production:
     In order to develop this application we made a relational database using SQL. Then we connected the said database to a flask application here giving        certain web urls access to different parts of the database and posting them. As well as a form post that takes in data that a user submits to add to a      given data base. Then the front end part was developed on appsmith. There we added tables and containers making the information easier to understand        and input data easier to input.

# Runnning the Program:
    In order to run the given program it's integral to run a docker file. Below there is a step by step guide on how to use the github to build a docker       file. After that we then set up an ngrok system to send the website on whatever port to an ngrok url. Through that we then give the ngrok url to the       appsmith in order to get the appsmith frontend benefits.

## How to setup and start the containers
**Important** - you need Docker Desktop installed

1. Clone this repository.  
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the `webapp` user. 
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 









