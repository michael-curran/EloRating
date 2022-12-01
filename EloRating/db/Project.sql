CREATE DATABASE EloRating;

-- CREATE USER 'developer'@'%' IDENTIFIED BY 'cs3200pswd';


GRANT ALL PRIVILEGES ON EloRating.* TO 'webapp'@'%';
FLUSH PRIVILEGES;

USE EloRating;

CREATE TABLE Skill
(
    SkillID  INTEGER UNIQUE NOT NULL Auto_Increment,
    SkillName  varchar(100) UNIQUE NOT NULL,
        PRIMARY KEY (SkillID)
);

Insert into Skill(SkillName)
Values ('Chess'),
('Football'),
('Soccer'),
('Basketball'),
('Hockey');


CREATE TABLE T_log
(
    LogID   INTEGER UNIQUE NOT NULL Auto_Increment,
    SkillID  INTEGER UNIQUE NOT NULL,
        PRIMARY KEY (LogID),
        FOREIGN KEY (SkillID) REFERENCES Skill(SkillID)
);

Insert into T_log(SkillID)
Values (3),
(4),
(2);


CREATE TABLE Owners
(
    OwnerID         integer   unique  not null Auto_Increment,
    firstName       text              not null,
    lastName        text              not null,
    stateAddress    text,
    cityAddress     text,
    streetAddress   text,
        PRIMARY KEY (OwnerID)
);

Insert into Owners(firstName, lastName, stateAddress, cityAddress, streetAddress)
Values ('Waite', 'Spyer', 'Montana', 'Billings', 'Summerview'),
('Krishnah', 'Cordingley', 'District of Columbia', 'Washington', 'Sundown'),
('Ella', 'Avraam', 'Ohio', 'Cincinnati', 'Schlimgen');

CREATE TABLE Team
(
    TeamID   INTEGER UNIQUE NOT NULL Auto_Increment,
    TeamWins  integer NOT NULL,
    TeamLoss  integer not null,
    TeamName  TEXT NOT NULL,
    CaptainFirstName TEXT,
    OwnerID INTEGER,
    EloRating  INTEGER NOT NULL,
        PRIMARY KEY (TeamID),
        FOREIGN KEY (OwnerID) REFERENCES Owners(OwnerID)
);

Insert into Team(TeamWins, TeamLoss, TeamName, CaptainID, OwnerID, EloRating)
Values (15, 45, 'dandreev0', 'Michael', 1, 30421),
(22, 4, 'hdax1', 'Sahil', 2, 6),
(98, 122, 'larnold2', 'Kevin', 3, 45);

CREATE TABLE Player
(
    PlayerID        INTEGER UNIQUE  NOT NULL   Auto_Increment,
    firstName       TEXT            NOT NULL,
    lastName        TEXT            NOT NULL,
    birthdayYear    INTEGER         NOT NULL,
    gender          text            NOT NULL,
    stateAddress    TEXT,
    cityAddress     TEXT,
    streetAddress   TEXT,
    EloRating       INTEGER         not null,
    Play_TeamID     INTEGER,
    Age             Integer         NOT NULL,
    T_LogID         Integer         not null,
        PRIMARY KEY (PlayerID),
        FOREIGN KEY (Play_TeamID) REFERENCES Team(TeamID),
        FOREIGN KEY (T_LogID) REFERENCES T_log(LogID)
);

Insert into Player(firstName, lastName, birthdayYear, gender, stateAddress, cityAddress, streetAddress, EloRating, Play_TeamID, Age, T_LogID)
Values ('Moe', 'Blumire', 2001, 'Male', 'Virginia', 'Norfolk', 'Village Green', '5847', 1, 20, 1),
('Hillel', 'Tomblett', 2012, 'Male', 'Georgia', 'Duluth', 'Loeprich', '04', 2, 21, 2),
('Ernest', 'Gurwood', 2005, 'Non-binary', 'Louisiana', 'Lake Charles', 'Commercial', '154', 3, 22, 3),
('Jordain', 'Crickett', 1995, 'Female', 'Connecticut', 'Hartford', 'Sauthoff', '641', 1, 23, 2),
('Alberik', 'McGeorge', 1997, 'Male', 'District of Columbia', 'Washington', 'Morrow', '579', 2, 24, 3);

CREATE TABLE PlayerToSkill
(
    PlayerID   INTEGER  NOT NULL,
    SkillID  INTEGER NOT NULL,
    Years  INTEGER,
        FOREIGN KEY (PlayerID) REFERENCES Player(PlayerID),
        FOREIGN KEY (SkillID) REFERENCES Skill(SkillID)
);

Insert into PlayerToSkill
Values (1, 1, 5),
(2, 3, 9),
(4, 2, 22);

CREATE TABLE League
(
    LeagueID         integer   unique  not null Auto_Increment,
    LeagueName       text              not null,
    OwnerID          integer           not null,
    SkillID          integer           not null,
        PRIMARY KEY (LeagueID),
        FOREIGN KEY (OwnerID) REFERENCES Owners(OwnerID),
        FOREIGN KEY (SkillID) REFERENCES Skill(SkillID)
);

Insert into League(LeagueName, OwnerID, SkillID)
Values ('Kilback', 1, 2),
('Moore', 2, 1),
('Mraz', 3, 3);

CREATE TABLE Competitions
(
    T_logID   INTEGER NOT NULL,
    CompetitorID  INTEGER NOT NULL,
    Results text not null,
        FOREIGN KEY (T_logID) REFERENCES T_log(LogID) ,
        FOREIGN KEY (CompetitorID) REFERENCES Player(PlayerID)
);

Insert into Competitions
Values (1, 2, 'Win'),
(2, 4, 'Loss'),
(3, 5, 'Win');

CREATE TABLE LeagueToPlayer
(
    PlayerID   INTEGER NOT NULL,
    LeagueID   INTEGER NOT NULL,
    TotalPlayers INTEGER NOT NULL ,
        FOREIGN KEY (PlayerID) REFERENCES Player(PlayerID),
        FOREIGN KEY (LeagueID) REFERENCES League(LeagueID)
);

Insert into LeagueToPlayer
Values (1, 1, 3),
(2, 3, 44),
(3, 1, 3);

CREATE TABLE Matchups
(
    MatchupNum     integer  unique  not null Auto_Increment,
    WinnerID       integer          not null,
    WinnerScore    integer          not null,
    LoserScore     integer          not null,
    curMonth       integer,
    curDay         integer,
    curYear        integer,
    LeagueID       integer           not null,
        PRIMARY KEY (MatchupNum),
        FOREIGN KEY (LeagueID) REFERENCES League(LeagueID)
);

Insert into Matchups(WinnerID, WinnerScore, LoserScore, curMonth, curDay, curYear, LeagueID)
Values (1, 22, 21, 8, 5, 2022, 1),
(3, 23, 21, 9, 12, 2024, 2),
(2, 25, 22, 11, 15, 2021, 3);

CREATE TABLE Competitors
(
    EloRating        integer           not null,
    TypeOfComp       text              not null,
    CompetitorsID    integer           not null,
        FOREIGN KEY (CompetitorsID) REFERENCES Player(PlayerID)
);

Insert into Competitors
Values (5362, 'Player', 2), (2637, 'Player', 1), (26732, 'Team', 2);

CREATE TABLE CompMatchup
(
    MatchupNum        integer           not null,
    CompetitorsNum    integer           not null,
    PreviousWinner    integer           not null,
        FOREIGN KEY (MatchupNum) REFERENCES Matchups(MatchupNum),
        FOREIGN KEY (CompetitorsNum) REFERENCES Competitors(CompetitorsID)
);

Insert into CompMatchup
Values (1, 2, 3), (2, 1, 1), (3, 1, 2);