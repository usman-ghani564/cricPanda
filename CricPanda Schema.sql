﻿use CricPanda
go

CREATE TABLE Tournaments (
    Tournament_ID int identity(1,1) PRIMARY KEY,
    Tournament_Name varchar(100) NOT NULL,
    Tournament_Location varchar(50) NOT NULL,
    Tournament_Start_Date DATE,
    Tournament_End_Date DATE
);


INSERT Tournaments VALUES('WORLDCUP 2019','ENGLAND & WALES','2019-06-1','2019-08-28')
INSERT Tournaments VALUES('WORLDCUP 2023','INDIA','2019-06-5','2019-08-5')
INSERT Tournaments VALUES('T20 WORLDCUP 2020','AUSTRALIA','2020-02-1','2019-05-28')


CREATE TABLE Stadiums(
Stadium_ID int identity(1,1) PRIMARY KEY,
Stadium_Capacity int,
Stadium_City varchar(50) NOT NULL,
Stadium_Country varchar(50) NOT NULL
);


INSERT Stadiums VALUES (20000,'MELBOURNE','AUSTRALIA')
INSERT Stadiums VALUES (20000,'GABBA','AUSTRALIA')
INSERT Stadiums VALUES (10000,'LORDS','ENGLAND')
INSERT Stadiums VALUES (5000,'RANCHI','INDIA')

CREATE TABLE Teams (
Team_ID int identity(1,1) PRIMARY KEY,
Team_Name varchar(50) NOT NULL
);


INSERT Teams VALUES('PAKISTAN')
INSERT Teams VALUES('INDIA')
INSERT Teams VALUES('AUSTRALIA')
INSERT Teams VALUES('ENGLAND')
INSERT Teams VALUES('WEST INDIES')
INSERT Teams VALUES('SRI LANKA')
INSERT Teams VALUES('NEW ZEALAND')
INSERT Teams VALUES('SOUTH AFRICA')
INSERT Teams VALUES('THAILAND')

CREATE TABLE TOURNA_TEAM(
Team_ID int Foreign key References Teams(Team_ID),
Tournament_ID int Foreign Key References Tournaments(Tournament_ID),
Primary key(Team_ID,Tournament_ID)

);


INSERT TOURNA_TEAM VALUES(1,1)
INSERT TOURNA_TEAM VALUES(1,2)
INSERT TOURNA_TEAM VALUES(1,3)
INSERT TOURNA_TEAM VALUES(2,1)
INSERT TOURNA_TEAM VALUES(2,2)
INSERT TOURNA_TEAM VALUES(3,1)
INSERT TOURNA_TEAM VALUES(4,2)
INSERT TOURNA_TEAM VALUES(5,3)
INSERT TOURNA_TEAM VALUES(6,1)
INSERT TOURNA_TEAM VALUES(6,2)
INSERT TOURNA_TEAM VALUES(7,3)
INSERT TOURNA_TEAM VALUES(8,2)


CREATE TABLE Players(
Player_ID int identity(1,1) PRIMARY KEY,
Player_Name varchar(50) NOT NULL,
DOB DATE,
Player_Role varchar(25),
Team_ID int Foreign Key References Teams(Team_ID)
);

INSERT Players VALUES('Babar Azam','1990-03-23','Batsman',1)
INSERT Players VALUES('Shaheen Afridi','1990-03-23','Bowler',1)
INSERT Players VALUES('Shadab Khan','1990-03-23','All Rounder',1)
INSERT Players VALUES('Virat Kohli','1990-03-23','Batsman',2)
INSERT Players VALUES('Bumrah','1990-03-23','Bowler',2)
INSERT Players VALUES('Steve Smith','1990-03-23','Batsman',3)
INSERT Players VALUES('Anderson','1990-03-23','Bowler',4)
INSERT Players VALUES('Jason Holder','1990-03-23','All Rounder',5)

CREATE TABLE MATCHES (
Match_ID int identity(1,1) PRIMARY KEY,
Team1_ID int Foreign Key References Teams(Team_ID),
Team2_ID int Foreign Key References Teams(Team_ID),
Match_Date DATE,
MoM int Foreign key references Players(Player_ID),
Stadium_ID int Foreign Key References Stadiums(Stadium_ID),
Winner_Team_ID int Foreign Key References Teams(Team_ID),
Tournament_ID int Foreign Key References Tournaments(Tournament_ID)
);

INSERT MATCHES VALUES(1,2,'2019-06-10',1,4,1,2)
INSERT MATCHES VALUES(3,4,'2019-06-12',7,4,4,2)

INSERT MATCHES VALUES(1,5,'2019-06-4',2,3,1,1)
INSERT MATCHES VALUES(7,8,'2019-06-5',1,3,7,1)

INSERT MATCHES VALUES(1,2,'2023-06-15',NULL,1,NULL,3)


CREATE TABLE PlayerStats(
Player_ID int Foreign Key References Players(Player_ID),
Match_ID int Foreign Key References MATCHES(Match_ID),
Tournament_ID int Foreign Key References Tournaments(Tournament_ID),
Runs_Scored int Default 0,
Balls_Faced int Default 0,
Wickets_Taken int Default 0,
Runs_Conceded int Default 0,
Total_Overs_Bowled int Default 0,
Catches_Taken int Default 0,
Total_Catches int Default 0,
Sixes int Default 0,
Strike_Rate float Default 0,
Economy float Default 0

);

INSERT PlayerStats VALUES(1,1,2,56,80,0,0,0,1,2,1,0,0)
INSERT PlayerStats VALUES(2,1,2,2,5,3,20,10,0,1,0,0,0)
INSERT PlayerStats VALUES(4,1,2,101,115,0,3,1,3,3,5,0,0)
INSERT PlayerStats VALUES(5,1,2,0,0,1,40,10,1,4,0,0,0)
INSERT PlayerStats VALUES(1,3,1,149,80,0,0,0,2,2,7,0,0)

INSERT PlayerStats VALUES(1,2,2,99,90,0,0,0,2,2,5,0,0)


CREATE TABLE Users (
    [User_ID] int identity(1,1) PRIMARY KEY,
    First_Name varchar(50) NOT NULL,
    Last_Name varchar(50),
    [User_Name] varchar(50) NOT NULL UNIQUE,
    Password varchar(25) NOT NULL,
    DOB DATE,
    Team_Preference int Foreign Key References Teams(Team_ID) default NULL
);

INSERT Users VALUES('CricPanda','App','admin','cpadmin',NULL,NULL)
INSERT Users VALUES('ASJAD','IFTIKHAR','KAI','PASSWORD1','1996-01-25',NULL)
INSERT Users VALUES('M','ZAIN','ZAIXIIROXK','PASSWORD2',NULL,NULL)
INSERT Users VALUES('TAYYAB','WASEEM','TAYYABA','PASSWORD3','1998-03-23',NULL)
INSERT Users VALUES('HASEEB','BHAI','ROBOT','PASSWORD4','1993-01-26',NULL)
INSERT Users VALUES('USMAN','GHANI','SHAREEF','PASSWORD5',NULL,NULL)

CREATE TABLE POINTS_TABLE(
	Tournament_id int Foreign key references Tournaments(Tournament_ID),
	Team_ID int Foreign Key References Teams(Team_ID),
	Matches int,
	Matches_Won int,
	Matches_Lost int,
	No_Result int,
	points int,
	NRR float

);





CREATE TABLE PCL_Teams ( 
    PCL_User_ID int identity(1,1) PRIMARY KEY,      
    [User_ID] int Foreign Key References Users([User_ID]), 
    PCL_Team_Name varchar(50) NOT NULL, 
    Tournament_ID int Foreign Key References Tournaments(Tournament_ID), 
    PCL_Team_PTS int Default 0 
); 

INSERT PCL_Teams VALUES(1,'BLACK',1,0)
INSERT PCL_Teams VALUES(2,'WHITE',1,0)
INSERT PCL_Teams VALUES(3,'GREEN',1,0)
INSERT PCL_Teams VALUES(4,'GREY',2,0)
INSERT PCL_Teams VALUES(5,'BLUE',3,0)


CREATE TABLE PCL_Teams_Users ( 
    [User_ID] int Foreign Key References Users([User_ID]), 
    Player_ID int Foreign Key References Players(Player_ID) 
); 

INSERT PCL_Teams_Users VALUES(1,1)
INSERT PCL_Teams_Users VALUES(1,2)
INSERT PCL_Teams_Users VALUES(1,3)
INSERT PCL_Teams_Users VALUES(1,4)

INSERT PCL_Teams_Users VALUES(2,6)
INSERT PCL_Teams_Users VALUES(2,7)
INSERT PCL_Teams_Users VALUES(2,8)

INSERT PCL_Teams_Users VALUES(3,1)
INSERT PCL_Teams_Users VALUES(3,5)
INSERT PCL_Teams_Users VALUES(3,8)

INSERT PCL_Teams_Users VALUES(4,2)
INSERT PCL_Teams_Users VALUES(4,5)

INSERT PCL_Teams_Users VALUES(5,5)
 

CREATE TABLE PCL_Players ( 
   Player_ID int Foreign Key References Players(Player_ID), 
   Player_Pts int Default 0 
 
); 
INSERT PCL_Players VALUES(1,0)
INSERT PCL_Players VALUES(2,0)
INSERT PCL_Players VALUES(3,0)
INSERT PCL_Players VALUES(4,0)
INSERT PCL_Players VALUES(5,0)
INSERT PCL_Players VALUES(6,0)
INSERT PCL_Players VALUES(7,0)




--JUST PRESS F5, ENJOY AND THANK ME LATER :)
--THIS TOOK SOME PRECIOUS TIME :(
--YOU CAN ALWAYS ADD MORE DATA,REMOVE OR UPDATE TO TEST YOUR QUERIES

--1) Login
---------------------------------------------------------------------------

GO
CREATE PROCEDURE [login]
@nickname Varchar(20),
@pass varchar(10),
@statusString varchar(50) OUTPUT

AS
BEGIN
IF EXISTS (SELECT * 
		   FROM [Users]
		   WHERE [Users].[User_Name] = @nickname)
	BEGIN
		IF EXISTS(SELECT * 
				  FROM [Users]
				  WHERE [Users].[Password] = @pass AND [Users].[User_Name] = @nickname)

				BEGIN
					SELECT 'You Logged in successfully.'
					SET @statusString = 'You Logged in successfully.'
					
				END
		ELSE
			BEGIN
				SELECT 'Incorrect Password'
				
				SET @statusString = 'INCORRECT PASSWORD'
			END		
	END

ELSE
	BEGIN
		SELECT 'Incorrect User Name'
		
		SET @statusString = 'INCORRECT USER NAME'
	END

END

--TO TEST

DECLARE @RESULT VARCHAR(20)
EXECUTE [login]
@nickname = 'KAI',
@pass = 'PASSWORD1',
@statusString = @RESULT OUTPUT


--2) SIGNUP
---------------------------------------------------------------------------
GO
CREATE PROCEDURE SIGNUP
@username varchar(20),
@password varchar(10),
@firstname varchar(10),
@lastname varchar(10),
@DOB date

AS
BEGIN
IF EXISTS (SELECT [Users].[User_Name]
				   FROM Users
				   WHERE [Users].[User_Name] = @username)
	BEGIN
		SELECT 'USER NAME ALREADY TAKEN'
	END
ELSE
	BEGIN
		IF EXISTS (SELECT [Users].[Password]
				   FROM Users
				   WHERE [Users].[Password] = @password)
				BEGIN
					SELECT 'CHOOSE A STRONGER PASSWORD'
				END
		ELSE
				BEGIN
					INSERT Users VALUES (@firstname,@lastname,@username,@password,@DOB,NULL)
					SELECT 'DEAR '+@firstname+' WELCOME TO CRICPANDA'
				END
	END


END

--TO TEST
EXECUTE SIGNUP
@username = 'panda',
@password = 'whatever',
@firstname = 'LULL',
@lastname = 'Bashir',
@DOB = '1995-03-06'

--3.0) CHECK TEAM PREFERENCE
---------------------------------------------------------------------------
GO
CREATE PROCEDURE CHECK_PREF
@username varchar(20),
@password varchar(10),
@status bit output		-- 1 FOR IS NULL AND 0 FOR NOT NULL, CALL SET ONLY IF 1
AS
BEGIN
	IF EXISTS (SELECT *
			   FROM [Users]
			   WHERE [Users].[User_Name] = @username AND [Users].[Password] = @password AND [Users].Team_Preference IS NULL)
		BEGIN
			SET @status = 1
		END
	ELSE
		BEGIN
			SET @status = 0
		END
END


--3.1) SET TEAM PREFERENCE

GO
CREATE PROCEDURE TEAM_PREF
@username varchar(20),
@password varchar(10),
@T_PREF int

AS
BEGIN
	UPDATE [Users]
	SET Team_Preference = @T_PREF
	WHERE [Users].[User_Name] = @username AND [Users].[Password] = @password
END

--TO TEST:
DECLARE @RESULT BIT
EXECUTE CHECK_PREF
@username = 'KAI',
@password = 'PASSWORD1',
@status = @RESULT output

SELECT @RESULT

EXECUTE TEAM_PREF
@username = 'KAI',
@password = 'PASSWORD1',
@T_PREF = 1

--4.0) lIVE SCORES DEFAULT
---------------------------------------------------------------------------
GO
CREATE PROCEDURE liveScore
AS
BEGIN
	SELECT A.Tournament_Name AS [Tournnament Name], A.Tournament_Location AS [Location], C.Team_Name AS Team1, D.Team_Name AS Team2, B.Match_Date AS [Match date]
	FROM Tournaments A join MATCHES B on A.Tournament_ID = B.Tournament_ID join Teams C on B.Team1_ID = C.Team_ID join Teams D on D.Team_ID = B.Team2_ID
	WHERE YEAR(B.Match_Date) = YEAR(GETDATE()) AND  MONTH(B.Match_Date) = MONTH(GETDATE()) AND DAY(B.Match_Date) = DAY(GETDATE())
END;

--TO TEST
EXEC liveScore;



--4.1) TOURNAMENTS ONCLICK
---------------------------------------------------------------------------
GO
CREATE PROCEDURE displayTournaments
AS
BEGIN
	SELECT Tournament_Name, Tournament_Location, Tournament_Start_Date, Tournament_End_Date
	FROM Tournaments
END;

EXEC displayTournaments;

--4.2) TEAMS ONCLICK
---------------------------------------------------------------------------
GO
CREATE PROCEDURE displayAllTeams
AS
BEGIN
	SELECT Team_Name AS Team
	FROM Teams
END;

EXEC displayAllTeams;

--5.0) CURRENT,CONLCUDED AND FUTURE TOURNA
---------------------------------------------------------------------------
GO
CREATE PROCEDURE displayTournamentsWithCondition
@status varchar(20)
AS
BEGIN

	if(@status = 'current')
		BEGIN
			SELECT Tournament_Name AS [Tournament Name], Tournament_Location [Location], Tournament_Start_Date [Start date], Tournament_End_Date [End date] 
			FROM Tournaments
			WHERE getdate() > Tournament_Start_Date AND getdate() < Tournament_End_Date
		END
	else if(@status = 'conducted')
		BEGIN
			SELECT Tournament_Name AS [Tournament Name], Tournament_Location [Location], Tournament_Start_Date [Start date], Tournament_End_Date [End date] 
			FROM Tournaments
			WHERE (year(getdate()) > year(Tournament_End_Date)) OR (month(getdate()) > month(Tournament_End_Date))
		END	
	else if(@status = 'Future')
		BEGIN
			SELECT Tournament_Name AS [Tournament Name], Tournament_Location [Location], Tournament_Start_Date [Start date], Tournament_End_Date [End date] 
			FROM Tournaments
			WHERE (year(getdate()) < year(Tournament_Start_Date)) OR (year(getdate()) < year(Tournament_Start_Date) AND month(getdate()) < month(Tournament_Start_Date))
		END

END;
select * from Tournaments
EXECUTE displayTournamentsWithCondition
@status = 'conducted'

--5.1) ONCLICK TOURNAMENT --> SHOW MATCHES
---------------------------------------------------------------------------
GO
CREATE PROCEDURE displayMatchesByTournament
@TournamentId int
AS
BEGIN
	SELECT A.Tournament_Name AS [Tournnament Name], A.Tournament_Location AS [Location], C.Team_Name AS Team1, D.Team_Name AS Team2, B.Match_Date AS [Match date]
	FROM Tournaments A join MATCHES B on A.Tournament_ID = B.Tournament_ID join Teams C on B.Team1_ID = C.Team_ID join Teams D on D.Team_ID = B.Team2_ID
	WHERE A.Tournament_ID = @TournamentId
END;

EXEC displayMatchesByTournament
@TournamentId = 1;

--footnote: Fix this if view is not appropirate while working on html and js part


--6.0) LIST OF ALL TEAMS
---------------------------------------------------------------------------
GO
CREATE PROCEDURE displayTeams
AS
BEGIN
	SELECT Team_Name 
	FROM Teams
END;

EXECUTE displayTeams;


--6.1.0) FIXTURES OF A SELECTED TEAM
---------------------------------------------------------------------------
GO
CREATE PROCEDURE displayFixtures
@teamid int

AS
BEGIN
	SELECT T1.Team_Name,T2.Team_Name,MT1.Match_Date,Stadiums.Stadium_City,MT1.Winner_Team_ID,Tournaments.Tournament_Name
	FROM MATCHES MT1 INNER JOIN Teams T1
		 ON MT1.Team1_ID = T1.Team_ID

		 INNER JOIN Teams T2
		 ON MT1.Team2_ID = T2.Team_ID

		 INNER JOIN Stadiums
		 ON MT1.Stadium_ID = Stadiums.Stadium_ID

		 INNER JOIN Tournaments
		 ON MT1.Tournament_ID = Tournaments.Tournament_ID


	WHERE MT1.Team1_ID = @teamid OR MT1.Team2_ID = @teamid
END


EXECUTE displayFixtures
@teamid = 3

--6.1.1) PLAYERS OF A GIVEN TEAM
---------------------------------------------------------------------------
GO
CREATE PROCEDURE DisplayPlayers
@teamid int

AS
BEGIN
	SELECT *
	FROM Players
	WHERE Team_ID = @teamid
END

EXECUTE DisplayPlayers
@teamid = 1



--7.0.0) MOST RUNS
---------------------------------------------------------------------------
GO
CREATE PROCEDURE MOSTRUNS
@tid int

AS
BEGIN

	SELECT TOP 1 Player_Name, SUM(Runs_Scored)
	FROM PlayerStats INNER JOIN Players ON PlayerStats.Player_ID = Players.Player_ID
	WHERE Tournament_ID = @tid
	GROUP BY Player_Name
	ORDER BY SUM(Runs_Scored) DESC

END

--TO TEST
EXECUTE MOSTRUNS
@tid = 3


--7.0.1) MOST FIFTIES/HUNDREDS
---------------------------------------------------------------------------
GO
CREATE PROCEDURE MostFifties
@tid int

AS
BEGIN

	SELECT Player_Name, COUNT(Runs_Scored) AS TALLY 
	FROM PlayerStats INNER JOIN Players
		 ON PlayerStats.Player_ID = Players.Player_ID
		 WHERE Runs_Scored > 49 AND Runs_Scored < 100 AND Tournament_ID = @tid
	GROUP BY Player_Name

END

--HUNDREDS

GO
CREATE PROCEDURE MostHundreds
@tid int

AS
BEGIN

	SELECT Player_Name, COUNT(Runs_Scored) AS TALLY 
	FROM PlayerStats INNER JOIN Players
		 ON PlayerStats.Player_ID = Players.Player_ID
		 WHERE Runs_Scored > 99 AND Tournament_ID = @tid
	GROUP BY Player_Name

END
--TO TEST
EXECUTE MostHundreds
@tid = 2

--7.0.2) HIGHEST AVERAGE
---------------------------------------------------------------------------
GO
CREATE PROCEDURE HIGHESTAVG
@tid int

AS
BEGIN

	SELECT TOP 1 Player_Name, AVG(Runs_Scored)
	FROM PlayerStats INNER JOIN Players ON PlayerStats.Player_ID = Players.Player_ID
	WHERE Tournament_ID = @tid
	GROUP BY Player_Name
	ORDER BY AVG(Runs_Scored) DESC

END

--TO TEST
EXECUTE HIGHESTAVG
@tid = 1


--7.0.3) TOP SCORE
---------------------------------------------------------------------------
GO
CREATE PROCEDURE TOPSCORE
@tid int

AS
BEGIN
	SELECT Player_Name,PlayerStats.Runs_Scored,PlayerStats.Balls_Faced
	FROM Players INNER JOIN PlayerStats
		 ON players.Player_ID = PlayerStats.Player_ID
	WHERE playerstats.Runs_Scored = (SELECT TOP 1 Runs_Scored
									 FROM PlayerStats 
									 WHERE Tournament_ID = @tid
									 ORDER BY Runs_Scored DESC)
	
	
	
END

--TO TEST
EXECUTE TOPSCORE
@tid = 2

--7.1.0) MOST WICKETS
---------------------------------------------------------------------------
GO
CREATE PROCEDURE MOSTWICKETS
@tid int

AS
BEGIN

	SELECT TOP 1 Player_Name, SUM(Wickets_Taken)
	FROM PlayerStats INNER JOIN Players ON PlayerStats.Player_ID = Players.Player_ID
	WHERE Tournament_ID = @tid
	GROUP BY Player_Name
	ORDER BY SUM(Wickets_Taken) DESC

END

--TO TEST
EXECUTE MOSTWICKETS
@tid = 2

--7.1.1) BEST ECONOMY
---------------------------------------------------------------------------
GO
CREATE PROCEDURE BESTECO
@tid int

AS
BEGIN
	UPDATE PlayerStats
	SET Economy = CAST(Runs_Conceded AS float) / CAST(Total_Overs_Bowled AS float)
	WHERE Total_Overs_Bowled <> 0

	SELECT TOP 1 Player_Name, AVG(Economy)
	FROM PlayerStats INNER JOIN Players ON PlayerStats.Player_ID = Players.Player_ID
	WHERE Tournament_ID = @tid AND Total_Overs_Bowled <> 0
	GROUP BY Player_Name
	ORDER BY AVG(Economy) ASC

END

--TO TEST
EXECUTE BESTECO
@tid = 2


--7.1.2) BEST BOWLING AVERAGE
---------------------------------------------------------------------------
GO
CREATE PROCEDURE BESTB_AVG
@tid int
AS
BEGIN

CREATE TABLE TEMP(
	pid int,
	tid int,
	wickets int,
	runs int,
	overs int,
	b_avg float
	
);
	INSERT INTO TEMP
	SELECT Player_ID,Tournament_ID , Wickets_Taken,Runs_Conceded, Total_Overs_Bowled, Economy
	FROM PlayerStats


	UPDATE TEMP
	SET b_avg = CAST(runs AS float) / CAST(wickets AS float)
	WHERE overs <> 0 AND wickets <> 0

	SELECT TOP 1 Player_Name, AVG(b_avg)
	FROM TEMP INNER JOIN Players ON TEMP.pid = Players.Player_ID
	WHERE tid = @tid AND overs <> 0
	GROUP BY Player_Name
	ORDER BY AVG(b_avg) ASC

	DROP TABLE TEMP
END

-- TO TEST
EXECUTE BESTB_AVG
@tid = 2

--7.2.0) MOST CATCHES
---------------------------------------------------------------------------
GO
CREATE PROCEDURE MOSTCATCHES
@tid int

AS
BEGIN

	SELECT TOP 1 Player_Name, SUM(Catches_Taken)
	FROM PlayerStats INNER JOIN Players ON PlayerStats.Player_ID = Players.Player_ID
	WHERE Tournament_ID = @tid
	GROUP BY Player_Name
	ORDER BY SUM(Catches_Taken) DESC

END

--TO TEST
EXECUTE MOSTCATCHES
@tid = 2


--8.0) POINTS TABLE
---------------------------------------------------------------------------
GO
CREATE PROCEDURE POINTSTABLE
@tid int

AS
BEGIN
	SELECT 'WRITE THIS LATER'
END

--8.5) SCORE CARD TABLE
---------------------------------------------------------------------------
GO
CREATE PROCEDURE SCORECARD
@tid int

AS
BEGIN
	SELECT 'WRITE THIS LATER'
END

---------------------------------------------------------------------------
--9.0) Admin Features:
---------------------------------------------------------------------------

--9.0.0 ADMIN VERIFICATION 
---------------------------------------------------------------------------
GO
CREATE PROCEDURE VERIFYADMIN
@nick varchar(20),
@pass varchar(10),
@STATUS BIT OUTPUT
AS
BEGIN
	IF EXISTS (SELECT * 
		   FROM [Users]
		   WHERE [Users].[User_Name] = @nick)
	BEGIN
		IF EXISTS(SELECT * 
				  FROM [Users]
				  WHERE [Users].[Password] = @pass AND [Users].[User_Name] = @nick)

				BEGIN
					SELECT 'You Logged in through admin access.'
					SET @STATUS = 1
					
				END
		ELSE
			BEGIN
				SELECT 'Incorrect Password'
				
				SET @STATUS = 0
			END		
	END

ELSE
	BEGIN
		SELECT 'Incorrect User Name'
		
		SET @STATUS = 0
	END
END

--9.0.1 CREATE TOURNAMENT 
---------------------------------------------------------------------------
GO
CREATE PROCEDURE C_TOURNA
@Tname varchar(50),
@Tloc varchar(20),
@sdate date,
@edate date

AS
BEGIN
	--USE JS TO CHECK IF DATES ARE VALID
	IF EXISTS(SELECT *
			  FROM Stadiums
			  WHERE Stadium_Country = @Tloc)
		BEGIN
			INSERT Tournaments VALUES (@Tname,@Tloc,@sdate,@edate)
		END
	ELSE
		BEGIN
			SELECT 'CRICKET LOCATION NOT FOUND'
		END
	
END

--9.0.2 DELETE TOURNAMENT 
---------------------------------------------------------------------------
GO
CREATE PROCEDURE D_TOURNA
@tid int

AS
BEGIN
	DELETE FROM Tournaments WHERE Tournament_ID = @tid 
END


--9.0.3 UPDATE DATE OF TOURNAMENT 
---------------------------------------------------------------------------
GO
CREATE PROCEDURE UP_DATE
@tid int,
@sdate date,
@edate date

AS
BEGIN
	UPDATE Tournaments
	SET Tournament_Start_Date = @sdate
	WHERE Tournament_ID = @tid

	UPDATE Tournaments
	SET Tournament_End_Date = @edate
	WHERE Tournament_ID = @tid
	
END

--9.1.0 ADD A STADIUM
---------------------------------------------------------------------------
GO
CREATE PROCEDURE ADDSTADIUM
@cap int,
@city varchar(20),
@country varchar(20)

AS
BEGIN
	INSERT Stadiums VALUES(@cap,@city,@country)
END

--9.1.1 REMOVE A STADIUM
---------------------------------------------------------------------------
GO
CREATE PROCEDURE R_STADIUM
@sid int

AS
BEGIN
	DELETE FROM Stadiums
	WHERE Stadium_ID = @sid
END

--9.1.2 UPDATE CAPACITY IN A STADIUM
---------------------------------------------------------------------------
GO
CREATE PROCEDURE UP_CAP
@sid int,
@cap int

AS
BEGIN
	UPDATE Stadiums
	SET Stadium_Capacity = @cap
	WHERE Stadium_ID = @sid
END

--9.2.0 ADD TEAM
---------------------------------------------------------------------------
GO
CREATE PROCEDURE ADDTEAM
@tname varchar(20)

AS
BEGIN
	INSERT Teams VALUES (@tname)
END

--9.2.1 REMOVE TEAM
---------------------------------------------------------------------------
GO
CREATE PROCEDURE R_TEAM
@tid int

AS
BEGIN
	DELETE FROM Teams
	WHERE Team_ID = @tid
END

--9.3.0 ADD TEAM TO A TOURNAMENT
---------------------------------------------------------------------------
GO
CREATE PROCEDURE ADDTT
@tid int,
@teamid int

AS
BEGIN
	INSERT TOURNA_TEAM VALUES(@teamid,@tid)
END

--9.3.1 REMOVE TEAM TO A TOURNAMENT
---------------------------------------------------------------------------
GO
CREATE PROCEDURE R_TT
@tid int,
@teamid int

AS
BEGIN
	DELETE FROM TOURNA_TEAM
	WHERE Team_ID = @teamid AND Tournament_ID = @tid
END

--9.4.0 ADD PLAYER
---------------------------------------------------------------------------
GO
CREATE PROCEDURE ADDPLAYER
@pname varchar(20),
@dob date,
@prole varchar(20),
@teamid int

AS
BEGIN
	INSERT Players VALUES(@pname,@dob,@prole,@teamid)
END

--9.4.1 REMOVE PLAYER
---------------------------------------------------------------------------
GO
CREATE PROCEDURE R_PLAYER
@pid int
AS
BEGIN
	DELETE FROM Players 
	WHERE Player_ID = @pid
END

--9.5.0 ADD MATCH 
---------------------------------------------------------------------------
GO
CREATE PROCEDURE ADDMATCH
@teamid1 int,
@teamid2 int,
@date date,
@mom int,
@sid int,
@wid int,
@tid int

AS
BEGIN
	INSERT MATCHES VALUES (@teamid1,@teamid2,@date,@mom,@sid,@wid,@tid)
END

--9.5.1 REMOVE MATCH 
---------------------------------------------------------------------------
GO
CREATE PROCEDURE R_MATCH
@mid int

AS
BEGIN
	DELETE FROM MATCHES
	WHERE Match_ID = @mid
END

--9.5.2 UPDATE WINNER AND MOM 
---------------------------------------------------------------------------
GO
CREATE PROCEDURE UP_MATCH
@mid int,
@mom int,
@wid int

AS
BEGIN
	UPDATE MATCHES
	SET MoM = @mom
	WHERE Match_ID = @mid

	UPDATE MATCHES
	SET Winner_Team_ID = @wid
	WHERE Match_ID = @mid
END

--9.6.0 ADD STAT 
---------------------------------------------------------------------------
GO
CREATE PROCEDURE ADDSTAT
@pid int,
@mid int,
@tid int,
@rs int,
@bf int,
@wt int,
@rc int,
@ob int,
@ct int,
@tc int,
@six int

AS
BEGIN
	INSERT PlayerStats VALUES (@pid,@mid,@tid,@rs,@bf,@wt,@rc,@ob,@ct,@tc,@six,0,0)
END

---------------------------------------------------------------------------------------

SELECT * FROM Tournaments
SELECT * FROM Stadiums
SELECT * FROM Teams
SELECT * FROM TOURNA_TEAM
SELECT * FROM players
SELECT * FROM MATCHES
SELECT * FROM PlayerStats
SELECT * FROM Users
SELECT * FROM PCL_Teams
SELECT * FROM PCL_Teams_Users
SELECT * FROM PCL_Players