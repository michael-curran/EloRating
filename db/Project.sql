CREATE DATABASE EloRating;

CREATE USER 'webapp'@'%' IDENTIFIED BY 'cs3200pswd';

GRANT ALL PRIVILEGES ON EloRating.* TO 'webapp'@'%';
FLUSH PRIVILEGES;

USE EloRating;

CREATE TABLE Skill
(
    SkillName  varchar(100) UNIQUE NOT NULL,
    SkillID  INTEGER UNIQUE NOT NULL Auto_Increment,
        PRIMARY KEY (SkillID)
);

Insert into Skill
Values ('Chess', 1),
('Football', 2),
('Soccer', 3),
('Basketball', 4),
('Hockey', 5);


CREATE TABLE T_log
(
    LogID   INTEGER UNIQUE NOT NULL Auto_Increment,
    SkillID  INTEGER UNIQUE NOT NULL,
        PRIMARY KEY (LogID),
        FOREIGN KEY (SkillID) REFERENCES Skill(SkillID)
);

Insert into T_log
Values (1, 3),
(2, 4),
(3, 2);


CREATE TABLE Owners
(
    firstName       text              not null,
    lastName        text              not null,
    OwnerID         integer   unique  not null Auto_Increment,
    stateAddress    text,
    cityAddress     text,
    streetAddress   text,
        PRIMARY KEY (OwnerID)
);

Insert into Owners
Values ('Waite', 'Spyer', 1, 'Montana', 'Billings', 'Summerview'),
('Krishnah', 'Cordingley', 2, 'District of Columbia', 'Washington', 'Sundown'),
('Ella', 'Avraam', 3, 'Ohio', 'Cincinnati', 'Schlimgen');

CREATE TABLE Team
(
    TeamID   INTEGER UNIQUE NOT NULL Auto_Increment,
    TeamWins  integer NOT NULL,
    TeamLoss  integer not null,
    TeamName  TEXT NOT NULL,
    CaptainID INTEGER,
    OwnerID INTEGER,
    EloRating  INTEGER NOT NULL,
        PRIMARY KEY (TeamID),
  --      FOREIGN KEY (CaptainID) REFERENCES Player(PlayerID),
        FOREIGN KEY (OwnerID) REFERENCES Owners(OwnerID)
);

Insert into Team
Values (1, 15, 45, 'dandreev0', 1, 1, 30421),
(2, 22, 4, 'hdax1', 2, 2, 6),
(3, 98, 122, 'larnold2', 3, 3, 45);

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

Insert into Player
Values (1, 'Moe', 'Blumire', 2001, 'Male', 'Virginia', 'Norfolk', 'Village Green', '5847', 1, 20, 1),
(2, 'Hillel', 'Tomblett', 2012, 'Male', 'Georgia', 'Duluth', 'Loeprich', '04', 2, 21, 2),
(3, 'Ernest', 'Gurwood', 2005, 'Non-binary', 'Louisiana', 'Lake Charles', 'Commercial', '154', 3, 22, 3),
(4, 'Jordain', 'Crickett', 1995, 'Female', 'Connecticut', 'Hartford', 'Sauthoff', '641', 1, 23, 2),
(5, 'Alberik', 'McGeorge', 1997, 'Male', 'District of Columbia', 'Washington', 'Morrow', '579', 2, 24, 3);

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
    LeagueName       text              not null,
    OwnerID          integer           not null,
    LeagueID         integer   unique  not null Auto_Increment,
    SkillID          integer           not null,
        PRIMARY KEY (LeagueID),
        FOREIGN KEY (OwnerID) REFERENCES Owners(OwnerID),
        FOREIGN KEY (SkillID) REFERENCES Skill(SkillID)
);

Insert into League
Values ('Kilback Group', 1, 1, 2),
('Moore-Beier', 2, 2, 1),
('Mraz-Hoppe', 3, 3, 3);

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
    WinnerID       integer          not null,
    WinnerScore    integer          not null,
    LoserScore     integer          not null,
    MatchupNum     integer  unique  not null Auto_Increment,
    curMonth       integer,
    curDay         integer,
    curYear        integer,
    LeagueID       integer           not null,
        PRIMARY KEY (MatchupNum),
        FOREIGN KEY (LeagueID) REFERENCES League(LeagueID)
);

Insert into Matchups
Values (1, 22, 21, 1, 8, 5, 2022, 1),
(3, 23, 21, 2, 9, 12, 2024, 2),
(2, 25, 22, 3, 11, 15, 2021, 3);

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