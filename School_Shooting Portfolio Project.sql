#Test database#
SELECT *
FROM [School_Shooting Project]..['School Shooting$']
ORDER BY 4,6,7

#Updating table to null zero value to avoid errors 
encountered when dividing by zero#

UPDATE [School_Shooting Project]..['School Shooting$']
SET Killed=NULL WHERE Killed=0 

UPDATE [School_Shooting Project]..['School Shooting$']
SET Injured=NULL WHERE injured=0

UPDATE [School_Shooting Project]..['School Shooting$']
SET Casualties=NULL WHERE Casualties=0 

UPDATE [School_Shooting Project]..['School Shooting$']
SET Total_Shootings=NULL WHERE Total_Shootings=0 

#Perfoming simple data mining to extract useful information
for project#

#1. Shooting type vs Impact
This is to ascertain total shootings that occur in each
type of shooting and impact#

SELECT DISTINCT Shooting_Type, SUM(Total_Shootings) AS TotalShootings, SUM(Killed) AS TotalKilled, 
SUM(Injured) AS TotalInjured, SUM(Casualties) AS TotalCasualties
FROM [School_Shooting Project]..['School Shooting$']
GROUP BY Shooting_Type


#2. Ascertaining Number of shooting by type of school#
#This ascertain the likelihood of being shot in a particular type of school#

SELECT DISTINCT School_Type, SUM(Total_Shootings) AS TotalShooting
FROM [School_Shooting Project]..['School Shooting$']
GROUP BY School_Type

#3.Find the Total shooting recorded for each state#
#This gives an overview of shootings recorded in various state#

SELECT State, Year(Date) AS Year, School_Type,Total_Shootings,Killed, Injured, Casualties
FROM [School_Shooting Project]..['School Shooting$']

#4.To find out if race has influence on these shootings'

SELECT Year(Date) AS Year, State, White, Black, Asian, American_Indian_Alaska_Native_Hispanic
FROM [School_Shooting Project]..['School Shooting$']
ORDER BY Year,State

#5. Percentage of death per shooting in each state#

SELECT State, Total_Shootings, Killed, (Killed/Total_Shootings)*100 AS 
Percentage_Killed_Per_Shooting
FROM [School_Shooting Project]..['School Shooting$']

#6.Average shooting recorded in a year for each state#
#This is to ascertain if shooting occurences are declining or increasing#

SELECT State, Year(Date) AS Year, AVG(Total_Shootings) AS AverageShooting
FROM [School_Shooting Project]..['School Shooting$']
GROUP BY State, Date

#7. Looking at state with highest shooting recorded#

Select State, MAX(total_shootings) AS HighestShooting,
MAX(killed), MAX((killed/total_shootings))*100 AS PercentageKilledPerShooting
FROM [School_Shooting Project]..['School Shooting$']
GROUP BY State
 
 #8.Average shooting recorded in a year for each city#
#This is to ascertain if shooting occurences are declining or increasing in cities-granuilarity level#

SELECT City, Year(Date) AS Year, AVG(Total_Shootings) AS AverageShooting
FROM [School_Shooting Project]..['School Shooting$']
GROUP City, Date

#9. Looking at city with highest shooting recorded#

SELECT City, MAX(total_shootings) AS HighestShooting,
MAX(killed) AS PersonsKilled, MAX((killed/Total_shootings))*100 AS PercentageKilledPerShooting
FROM [School_Shooting Project]..['School Shooting$']
GROUP BY City
ORDER BY City, HighestShooting 

#Creating views from queries to store data for visualization in tableau#
1.
CREATE VIEW Shooting_Type_Impact AS
SELECT DISTINCT Shooting_Type, SUM(Total_Shootings) AS TotalShootings, SUM(Killed) AS TotalKilled, 
SUM(Injured) AS TotalInjured, SUM(Casualties) AS TotalCasualties
FROM [School_Shooting Project]..['School Shooting$']
GROUP BY Shooting_Type

2.
CREATE VIEW ShootingBySchoolType AS
SELECT DISTINCT School_Type, SUM(Total_Shootings) AS TotalShooting
FROM [School_Shooting Project]..['School Shooting$']
GROUP BY School_Type

3.
CREATE VIEW TotalShootingByState AS
SELECT State, Year(Date) AS Year, School_Type,Total_Shootings,Killed, Injured, Casualties
FROM [School_Shooting Project]..['School Shooting$']

4.
CREATE VIEW RaceInfluence AS
SELECT Year(Date) AS Year, State, White, Black, Asian, American_Indian_Alaska_Native_Hispanic
FROM [School_Shooting Project]..['School Shooting$']
--ORDER BY year,state

5.
CREATE VIEW PercentageDeathPerShooting_State AS
SELECT State, Total_Shootings, Killed, (Killed/Total_Shootings)*100 AS 
Percentage_Killed_Per_Shooting
FROM [School_Shooting Project]..['School Shooting$']

6.
CREATE VIEW AvgShootingPerYearByState AS
SELECT State, Year(Date) AS Year, AVG(Total_Shootings) AS AverageShooting
FROM [School_Shooting Project]..['School Shooting$']
GROUP BY State, Date

7.
CREATE VIEW HighestShootingByState AS
SELECT State, MAX(total_shootings) AS HighestShooting,
MAX(killed) AS MAXKilled, MAX((Killed/Total_Shootings))*100 AS PercentageKilledPerShooting
FROM [School_Shooting Project]..['School Shooting$']
GROUP BY State

8.
CREATE VIEW AvgShootingPerYearByCity AS
SELECT City, Year(Date) AS Year, AVG(Total_Shootings) AS AverageShooting
FROM [School_Shooting Project]..['School Shooting$']
GROUP BY City, Date

9.
CREATE VIEW HighestShootingByCity AS 
SELECT City, MAX(Total_Shootings) AS HighestShooting,
MAX(Killed) AS PersonsKilled, MAX((Killed/Total_Shootings))*100 AS PercentageKilledPerShooting
FROM [School_Shooting Project]..['School Shooting$']
GROUP BY City
--ORDER BY HighestShooting 
