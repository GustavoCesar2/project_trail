USE f1;
# NOTE: download data from url https://www.kaggle.com/rohanrao/formula-1-world-championship-1950-2020 before loading in data for correct .csv formatting


# Loading circuits table first...
LOAD DATA LOCAL INFILE '/Users/justingill/Desktop/StructuredDataModeling/TeamDB/data/circuits.csv' 
INTO TABLE circuits
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(circuitid, circuitRef, name, location, country, lat, lng, alt, url);

# Loading constructors table next...
LOAD DATA LOCAL INFILE '/Users/justingill/Desktop/StructuredDataModeling/TeamDB/data/constructors.csv' 
INTO TABLE constructors
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(constructorsid, constructorref, name, nationality, url);

#Loading drivers table next...
LOAD DATA LOCAL INFILE '/Users/justingill/Desktop/StructuredDataModeling/TeamDB/data/drivers.csv' 
INTO TABLE drivers
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(driverid, driverref, number, code, forname, surname, dob, nationality, url);

#Loading races table next...
LOAD DATA LOCAL INFILE '/Users/justingill/Desktop/StructuredDataModeling/TeamDB/data/races.csv' 
INTO TABLE races
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(raceid, year, round, circuitid, name, date, time, url);

#Loading status table next...
LOAD DATA LOCAL INFILE '/Users/justingill/Desktop/StructuredDataModeling/TeamDB/data/status.csv' 
INTO TABLE status
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(statusid, status);

#Loading lap_times table next...
LOAD DATA LOCAL INFILE '/Users/justingill/Desktop/StructuredDataModeling/TeamDB/data/lap_times.csv' 
INTO TABLE lap_times
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(raceid, driverid, lap, position, time, milliseconds);

#Loading constructor_results table next...
LOAD DATA LOCAL INFILE '/Users/justingill/Desktop/StructuredDataModeling/TeamDB/data/constructor_results.csv' 
INTO TABLE constructor_results
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(constructorresultsid, raceid, constructorid, points, status);

#Loading qualifying table next...
LOAD DATA LOCAL INFILE '/Users/justingill/Desktop/StructuredDataModeling/TeamDB/data/qualifying.csv' 
INTO TABLE qualifying
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(qualifyingid, raceid, driverid, constructorid, number, position, q1, q2, q3);

#Loading constructor_standings table next
LOAD DATA LOCAL INFILE '/Users/justingill/Desktop/StructuredDataModeling/TeamDB/data/constructor_standings.csv' 
INTO TABLE constructor_standings
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(constructorstandingsid, raceid, constructorid, points, position, positiontext, wins);

#Loading driver_standings table next...
LOAD DATA LOCAL INFILE '/Users/justingill/Desktop/StructuredDataModeling/TeamDB/data/driver_standings.csv' 
INTO TABLE driver_standings
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(driverstandingsid, raceid, driverid, points, position, positiontext, wins);

#Loading pit_stops next...
LOAD DATA LOCAL INFILE '/Users/justingill/Desktop/StructuredDataModeling/TeamDB/data/pit_stops.csv' 
INTO TABLE pit_stops
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(raceid, driverid, stop, lap, time, duration, milliseconds);

#Next, adding seasons table...
LOAD DATA LOCAL INFILE '/Users/justingill/Desktop/StructuredDataModeling/TeamDB/data/seasons.csv' 
INTO TABLE seasons
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(year, url);

# Last, adding results table...
# Note odd formatting here for the 'time' column - may need to remove column
LOAD DATA LOCAL INFILE '/Users/justingill/Desktop/StructuredDataModeling/TeamDB/data/results.csv' 
INTO TABLE results
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(rsultsid, raceid, driverid, constructorid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, ranking, fastestlaptime, fastestlapspeed, statusid);

SELECT * FROM circuits;
SELECT * FROM constructors;
SELECT * FROM drivers;
SELECT * FROM races;
SELECT * FROM status;
SELECT * FROM lap_times;
SELECT * FROM constructor_results;
SELECT * FROM qualifying;
SELECT * FROM constructor_standings;
SELECT * FROM driver_standings;
SELECT * FROM pit_stops;
SELECT * FROM seasons;
SELECT * FROM results;