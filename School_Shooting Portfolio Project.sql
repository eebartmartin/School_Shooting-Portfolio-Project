#Test database#
select *
from [School_Shooting Project]..['School Shooting$']
order by 4,6,7

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

select distinct Shooting_Type,sum(Total_Shootings) as TotalShootings, sum(Killed) as TotalKilled, 
sum(Injured) as TotalInjured, sum(Casualties)as TotalCasualties
from [School_Shooting Project]..['School Shooting$']
Group by Shooting_Type


#2. Ascertaining Number of shooting by type of school#
#This ascertain the likelihood of being shot in a particular type of school#

select distinct school_type, sum (Total_Shootings) as TotalShooting
from [School_Shooting Project]..['School Shooting$']
group by School_Type


#3.Find the Total shooting recorded for each state#
#This gives an overview of shootings recorded in various state#

select State, year(date) as year, School_Type,Total_Shootings,Killed, Injured, Casualties
from [School_Shooting Project]..['School Shooting$']


#4.To find out if race has influence on these shootings'

select year(date) as year, state, white, black, asian, american_indian_alaska_native
hispanic
from [School_Shooting Project]..['School Shooting$']
order by year,state

#5. Percentage of death per shooting in each state#

select state, total_shootings, killed, (killed/total_shootings)*100 as 
percentage_killed_per_shooting
from [School_Shooting Project]..['School Shooting$']


#6.Average shooting recorded in a year for each state#
#This is to ascertain if shooting occurences are declining or increasing#

select state, year(date) as year, avg(total_shootings) as AverageShooting
from [School_Shooting Project]..['School Shooting$']
group by state, date



#7. Looking at state with highest shooting recorded#

select State, MAX(total_shootings) as HighestShooting,
MAX(killed), MAX((killed/total_shootings))*100 as percentAgekilledpershooting
from [School_Shooting Project]..['School Shooting$']
Group by state
 

 #8.Average shooting recorded in a year for each city#
#This is to ascertain if shooting occurences are declining or increasing#

select city, year(date) as year, avg(total_shootings) as AverageShooting
from [School_Shooting Project]..['School Shooting$']
group by city, date

#9. Looking at city with highest shooting recorded#

select city, MAX(total_shootings) as HighestShooting,
MAX(killed) as personskilled, MAX((killed/total_shootings))*100 as percentAgekilledpershooting
from [School_Shooting Project]..['School Shooting$']
Group by city
order by city, highestshooting 

#Creating views from queries to store data for visualization in tableau#
1.
Create view Shooting_Type_Impact AS
select distinct Shooting_Type,sum(Total_Shootings) as TotalShootings, sum(Killed) as TotalKilled, 
sum(Injured) as TotalInjured, sum(Casualties)as TotalCasualties
from [School_Shooting Project]..['School Shooting$']
Group by Shooting_Type

2.
Create view ShootingBySchoolType AS
select distinct school_type, sum (Total_Shootings) as TotalShooting
from [School_Shooting Project]..['School Shooting$']
group by School_Type

3.
Create view TotalShootingByState AS
select State, year(date) as year, School_Type,Total_Shootings,Killed, Injured, Casualties
from [School_Shooting Project]..['School Shooting$']

4.
Create view RaceInfluence AS
select year(date) as year, state, white, black, asian, american_indian_alaska_native
hispanic
from [School_Shooting Project]..['School Shooting$']
--order by year,state

5.
Create view PercentageDeathPerShooting_State AS
select state, total_shootings, killed, (killed/total_shootings)*100 as 
percentage_killed_per_shooting
from [School_Shooting Project]..['School Shooting$']

6.
Create view AvgShootingPerYearByState AS
select state, year(date) as year, avg(total_shootings) as AverageShooting
from [School_Shooting Project]..['School Shooting$']
group by state, date

7.
Create view HighestShootingByState AS
select State, MAX(total_shootings) as HighestShooting,
MAX(killed) as maxkilled, MAX((killed/total_shootings))*100 as percentAgekilledpershooting
from [School_Shooting Project]..['School Shooting$']
Group by state

8.
Create view AvgShootingPerYearByCity AS
select city, year(date) as year, avg(total_shootings) as AverageShooting
from [School_Shooting Project]..['School Shooting$']
group by city, date

9.
Create view HighestShootingByCity AS 
select city, MAX(total_shootings) as HighestShooting,
MAX(killed) as personskilled, MAX((killed/total_shootings))*100 as percentAgekilledpershooting
from [School_Shooting Project]..['School Shooting$']
Group by city
--order by city, highestshooting 