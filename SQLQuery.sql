select * from Covid_Deaths
select * from Covid_vaccinations

--select * 
--from Covid_vaccinations
--order by 3, 4

--COVID DEATHS QUERIES

-- identifying prilimnary and important datas 
select continent, location, date, new_cases, total_cases, new_deaths, total_deaths, population
from Covid_deaths
order by 2, 3

--lets identify in which country/s did the first case of covid occured
select location, date, total_cases
from Covid_deaths
where total_cases <> 0 and continent is not null
order by date
--based on the data gathered, on jan-01-2020, Countries taiwan, thailand, japan,
-- south korea, USA and china has a record of atleast 1 case of covid .

--identify what are the first 10 countries that confirmed a covid cases
select distinct top 10 location, date, total_cases
from covid_deaths
where total_cases > 0  and continent is not null
order by date
--data shows the top 10 locations order by date with total cases

--location with least number of death
select location, max(total_deaths) as TOTAL_DEATHS_per_LOC
from Covid_deaths
where total_deaths is not null
group by location
order by max(total_deaths) asc

--location with least number of cases
select location, max(total_cases) as TOTAL_cases_per_LOC
from Covid_deaths
where total_deaths is not null
group by location
order by max(total_cases) asc

--location with highest number of deaths
select location, max(total_deaths) as TOTAL_DEATHS_per_LOC
from Covid_deaths
where total_deaths is not null
group by location
order by TOTAL_DEATHS_per_LOC desc

--location with highest number of cases
select location, max(total_cases) as TOTAL_Cases_per_LOC
from Covid_deaths
where total_deaths is not null
group by location
order by TOTAL_cases_per_LOC desc

--identify total deaths per total cases in the world
select location, date, total_cases, total_deaths, population, (total_deaths/total_cases)*100 as death_percentage 
from covid_deaths
where total_deaths <> 0
order by 1, 2

--identify total deaths per total cases in the philippines
select location, date, total_cases, total_deaths, population, (total_deaths/total_cases)*100 as death_percentage 
from covid_deaths
where location = 'philippines'
order by 1, 2
--data shows that until april 2021, you have a 1.67 % chance of dying from covid

--identify total deaths per total cases in the philippines for the yr of 2020 only
select location, date, total_cases, total_deaths, population, (total_deaths/total_cases)*100 as death_percentage 
from covid_deaths
where location = 'philippines' and date between '2020-01-01 00:00:00' and '2020-12-31 00:00:00'
order by 1, 2
--given the timeline in 2020, these are the records for covid cases in philippines within 2020

--identify total cases vs the population in the world
select location, date, total_cases, population, (total_cases/population)*100 as Covid_per_pop_percentage 
from covid_deaths
order by 1, 2
--data shows that covid case per population percentage is increasing which is obviously directly 
--proportional to the increase of cases , the more the cases over time, the bigger the percentage it gets
--this data is regardless the rate of population growth.
--this data show what percentage of population has acquired covid

--identify total cases vs the population in the philippines
select location, date, total_cases, population, (total_cases/population)*100 as Covid_per_pop_percentage 
from covid_deaths
where location like '%phili%'
order by 1, 2
--data shows that covid case per population percentage is increasing which is obviously directly 
--proportional to the increase of cases , the more the cases over time, the bigger the percentage it gets
--this data is regardless the rate of population growth.

--this time. lets identify the location with the highest infection rate
select location ,max(total_cases), max((total_cases/population)*100) as Covid_per_pop_percentage
from covid_deaths
where continent is not null
group by location
order by Covid_per_pop_percentage desc
--data show Andorra has the highest infection rate vs population 
--you got a higest chance of contracting the virus when you are in andorra
-- while the least chance if your in tanzania, regardless those null values in the table

--lets say what are the top 5 countries with the highest infection rate 
select top 10 location ,max(total_cases), max((total_cases/population)*100) as Covid_per_pop_percentage
from covid_deaths
group by location
order by Covid_per_pop_percentage desc
--if your living in andorra/montenegro/ czechia etc , you are included in top 10 countries
--with the highest infection rate.

--identify death rate per population for the whole world due COVID
select location, date, total_deaths, population, (total_deaths/population)*100 as death_rate_per_pop_percentage
from covid_deaths
order by 1, 2

--identify death rate per population in philippines due COVID
select location, date, total_deaths, population, (total_deaths/population)*100 as death_rate_per_pop_percentage
from covid_deaths
where location = 'philippines'
order by 1, 2
--data shows that as of 2021-04-30 you got a 0.015 chance of dying due to covid if ur in the philippines
--0.015 is just little but if you get that portion to the population of the philippines thats an overwhelming count

--identifying countries with highest number of deaths per population
select location, max(cast(total_deaths as int)) as totalCountryDeath
from covid_deaths
where continent is not null
group by location
order by totalcountrydeath desc
--data shows that USA got the highest number of covid deaths as of 2021
--grenada has the least exluding null values in the table

--identifying continents with highest number of deaths 
select continent, max(cast(total_deaths as int)) as totalCountryDeath
from covid_deaths
where continent is not null
group by continent
order by totalcountrydeath desc

--identifying continents with highest number of cases 
select continent, max(cast(total_cases as int)) as totalCountrycases
from covid_deaths
where continent is not null
group by continent
order by totalcountrycases desc

--GLOBAL COVID NUMBERS
select date,location,total_cases, total_deaths, max(total_deaths/total_cases)*100 as death_percentage 
from covid_deaths
where continent is not null 
group by date, location , total_deaths, total_cases
order by 1
-- datas shows covid death percentage of the whole world grouped by date,
--location, total_deaths and total cases

--or

select date, location, sum(new_cases) as Total_cases, sum(cast(New_deaths as int)) as Total_deaths, sum(cast(New_deaths as int)) / sum(new_cases) as death_percentage
from covid_deaths
where continent is not null and new_cases <> 0 and new_deaths <> 0 
group by date, location
order by 1,2 

--calculating overall total deaths amd total cases across the globe, and the death percentage
select sum(new_cases) as Total_cases, sum(cast(New_deaths as int)) as Total_deaths, sum(cast(New_deaths as int)) / sum(new_cases) as death_percentage
from covid_deaths
where continent is not null 


-- COVID VACCINATIONS

--find highest number of people vaccinated ever recorded in a single day
--display date and location
select date, location, people_vaccinated
from covid_vaccinations
where people_vaccinated = 
(
select max(people_vaccinated)
from covid_vaccinations
)
--DATA shows that luxembourg recorded a high 99988 vaccinations in a day

--find lowest number of people vaccinated ever recorded in a single day, excluding zero and nulls
--display date and location
select date, location, people_vaccinated
from covid_vaccinations
where people_vaccinated = 
(
select min(people_vaccinated)
from covid_vaccinations
where people_vaccinated is not null and people_vaccinated <> 0
)
--data shows new zealand and oceania records a single vaccination in a single day

--identify number of vaccines that was first acquired by each location
select location, min(cast(people_vaccinated as int)) as minPV
from covid_vaccinations
where people_vaccinated is not null and people_vaccinated <>0
group by location
order by location

--NOW LETS PROCEED TO COVID VACCINATIONS joined in COVID DEATHS

select *
from covid_deaths cd
	full outer join COVID_VACCINATIONS cv
	on cd.date = cv.date and cd.location = cv.location
--data show all datas inlcuding deaths and vaccination matched in date and location across the globe

--Getting important datas
	select cd.location, cd.date, cd.total_cases, cd.new_cases, cd.total_deaths, cd.new_deaths, cd.population, cv.people_vaccinated, cv.people_fully_vaccinated,
		cv.total_vaccinations
from covid_deaths cd
	full outer join COVID_VACCINATIONS cv
	on cd.date = cv.date and cd.location = cv.location
	order by cd.location, cd.date

	--show the rate of people vaccinated vs population in the philippines
select cd.date, cd.location, cv.people_vaccinated, cd.population, (cv.people_vaccinated / cd.population) as vaccination_rate_PH
from covid_vaccinations cv
	join covid_deaths cd
	on cv.location = cd.location and cv.date = cd.date
	where cv.people_vaccinated is not null 
	and cd.location = 'philippines'

		--show the rate of people vaccinated vs population in the USA
select cd.date, cd.location, cv.people_vaccinated, cd.population, (cv.people_vaccinated / cd.population) as vaccination_rate_PH
from covid_vaccinations cv
	join covid_deaths cd
	on cv.location = cd.location and cv.date = cd.date
	where cv.people_vaccinated is not null 
	and cd.location like '%states%'

--percentage of people partially vaccinated vs the population across the globe
select cd.continent, cd.location, cd.date, cv.people_vaccinated, cv.people_fully_vaccinated, cv.total_vaccinations, cd.population,
		(cv.people_vaccinated / cd.population) * 100 as Partially_VAX_Percentage
from covid_deaths cd
	full outer join COVID_VACCINATIONS cv
	on cd.date = cv.date and cd.location = cv.location
	order by location, date

--percentage of people partially vaccinated vs the population in each country
select cd.location, max(cv.people_vaccinated / cd.population) * 100 as Partially_VAX_Percentage	
from covid_deaths cd
	full outer join COVID_VACCINATIONS cv
	on cd.date = cv.date and cd.location = cv.location
	group by cd.location
	order by cd.location
--data shows percentage of people who got vaccinated per location

--percentage of which country has the most partially vaccinated number of people
	select cd.location, max(cv.people_vaccinated / cd.population) * 100 as Partially_VAX_Percentage	
from covid_deaths cd
	full outer join COVID_VACCINATIONS cv
	on cd.date = cv.date and cd.location = cv.location
	group by cd.location
	order by Partially_VAX_Percentage desc
--data shows that location gibraltar has the highest percentage, but take note that it seems like number of people vaccinated
--exceeded the number of their population, could be due to inaccurate population data.

	select cd.continent, cd.location, cd.date, cv.new_vaccinations, cv.people_vaccinated, cv.people_fully_vaccinated, cv.total_vaccinations, cd.population
	from covid_deaths cd
	full outer join COVID_VACCINATIONS cv
	on cd.date = cv.date and cd.location = cv.location
	where cd.location like 'gib%'
--to justify that the number of people vaccinated exceed the population, this is the code. 
--and we are right, more number has benn vaccinated than the population

--percentage which country has the least partially vaccinated number of people
	select cd.location, max(cv.people_vaccinated / cd.population) * 100 as Partially_VAX_Percentage	
from covid_deaths cd
	full outer join COVID_VACCINATIONS cv
	on cd.date = cv.date and cd.location = cv.location
	group by cd.location
	order by Partially_VAX_Percentage asc
--it shows some null values, could be not vaccination happened or just no data available,
--but considering just taking the least percentage and we got the location cameroon.

--percentage of people fully vaccinated vs the population across the globe
select cd.continent, cd.location, cd.date, cv.new_vaccinations, cv.people_vaccinated, cv.people_fully_vaccinated, cv.total_vaccinations, cd.population,
		(cv.people_fully_vaccinated / cd.population) * 100 as Fully_VAX_Percentage
from covid_deaths cd
	full outer join COVID_VACCINATIONS cv
	on cd.date = cv.date and cd.location = cv.location
	order by location, date
--so the data shows there are only certain locations who got their 2nd dose of vaccinations. 
--lets identify that on the next query

--percentage of people fully vaccinated vs the population but filtered to those locations only that acquired there fully vaccination
select cd.location, max(cv.people_fully_vaccinated / cd.population) * 100 as Fully_VAX_Percentage
from covid_deaths cd
	full outer join COVID_VACCINATIONS cv
	on cd.date = cv.date and cd.location = cv.location
	where cv.people_fully_vaccinated is not null
	group by cd.location
	order by cd.location
--so data shows those locations only with people got their full dosage of vaccination grouped by location

--location with highest percentage of people fully vaccinated vs the population but filtered to those locations only that acquired there fully vaccination
select cd.location, max(cv.people_fully_vaccinated / cd.population) * 100 as Fully_VAX_Percentage
from covid_deaths cd
	full outer join COVID_VACCINATIONS cv
	on cd.date = cv.date and cd.location = cv.location
	where cv.people_fully_vaccinated is not null
	group by cd.location
	order by Fully_VAX_Percentage desc
--data shows that 97% of gibraltar population got their 2nd dose of vaccination

--location with least percentage of people fully vaccinated vs the population but filtered to those locations only that acquired there fully vaccination
select cd.location, max(cv.people_fully_vaccinated / cd.population) * 100 as Fully_VAX_Percentage
from covid_deaths cd
	full outer join COVID_VACCINATIONS cv
	on cd.date = cv.date and cd.location = cv.location
	where cv.people_fully_vaccinated is not null
	group by cd.location
	order by Fully_VAX_Percentage asc
--excluding null, data shows that 0.0006% of ukraines population only got ther 2nd dose of vaccination that makes them
--the location with least percentage

--now lets just identify the number of vaccinations used to people but not the number of people vs the population per location
select cd.location, max(cv.total_vaccinations) as Total_Vax_Used, cd.population
from covid_deaths cd
	full outer join COVID_VACCINATIONS cv
	on cd.date = cv.date and cd.location = cv.location
	where cv.total_vaccinations is not null
	group by cd.location, cd.population
	order by cd.location
--take note that this data only shows the number of vaccinations given, there are same person within this figure 
--and that because same person got their second dose.

--percentage of total people vaccinated vs the population per location
select cd.location, cd.population, max(cv.people_vaccinated / cd.population) * 100 as Total_VAX_Percentage
from covid_deaths cd
	full outer join COVID_VACCINATIONS cv
	on cd.date = cv.date and cd.location = cv.location
	where people_vaccinated is not null
	group by cd.location, cd.population
	order by cd.location
--take note that people_vaccinated/partially_vax is actually the total number of person that got their vaccine distinctively
	
--identify location with the highest percentage of people got their vaccination vs the population regardless fully or not
--take note that people_vaccinated/partially_vax is actually the total number of person that got their vaccine distinctively
select cd.location, cd.population, max(cv.people_vaccinated / cd.population) * 100 as Total_VAX_Percentage
from covid_deaths cd
	full outer join COVID_VACCINATIONS cv
	on cd.date = cv.date and cd.location = cv.location
	where people_vaccinated is not null
	group by cd.location, cd.population
	order by Total_VAX_Percentage desc
--data shows still the location gibraltar

--identify location with the east percentage of people got their vaccination vs the population regardless fully or not
--take note that people_vaccinated/partially_vax is actually the total number of person that got their vaccine distinctively
select cd.location, cd.population, max(cv.people_vaccinated / cd.population) * 100 as Total_VAX_Percentage
from covid_deaths cd
	full outer join COVID_VACCINATIONS cv
	on cd.date = cv.date and cd.location = cv.location
	where people_vaccinated is not null
	group by cd.location, cd.population
	order by Total_VAX_Percentage asc
--data shows location cameroon has the least percentage of population that got their vaccination.

--USING CTEs
with CTE_Covid_Vax as(
select cd.location,cd.date, cd.population, cv.new_vaccinations, cv.people_vaccinated, cv.people_fully_vaccinated, cv.total_vaccinations
from covid_deaths cd
	full outer join COVID_VACCINATIONS cv
	on cd.date = cv.date and cd.location = cv.location
	)

select location, date, max(total_vaccinations / population)*100 as TOTAL_VAX_PERCENTAGE
from CTE_Covid_Vax
where total_vaccinations is not null
group by location, date
order by location , date
--data shows that as of 2021-04-22 , 0.6% of afghanistans population are vaccinated
--CTEs specifies a rtemporary named result set. 

--TEMP TABLE
drop table if exists #VaccinatedPerPopulation_percentage
Create table #VaccinatedPerPopulation_percentage
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations nvarchar(255),
people_vaccinated nvarchar(255),
people_fully_vaccinated nvarchar(255),
total_vaccinations nvarchar(255)
)
insert into #VaccinatedPerPopulation_percentage
select cd.continent, cd.location,cd.date, cd.population ,cv.new_vaccinations, 
cv.people_vaccinated,cv.people_fully_vaccinated , cv.total_vaccinations
from covid_deaths cd
	full outer join COVID_VACCINATIONS cv
	on cd.date = cv.date and cd.location = cv.location

select continent
from #VaccinatedPerPopulation_percentage
--lets  you store and process intermmediate results by using same selection
--join capabilities or updates


--creating a view to store data for visualizations

create view Death_Percentage_per_Location as
select continent, location, date, total_cases, total_deaths, population, (total_deaths/total_cases)*100 as death_percentage 
from covid_deaths
where total_deaths <> 0 and continent is not null

create view Case_Percentage_per_population as
select location, date, total_cases, population, (total_cases/population)*100 as Covid_per_pop_percentage 
from covid_deaths

create view Total_cases_deaths_percentage_world as
select sum(new_cases) as Total_cases, sum(cast(New_deaths as int)) as Total_deaths, sum(cast(New_deaths as int)) / sum(new_cases) as death_percentage
from covid_deaths
where continent is not null 

create view Vaccination_Percentage_Overtime as
with CTE_Covid_Vax as(
select cd.continent, cd.location,cd.date, cd.population, cv.new_vaccinations, cv.people_vaccinated, cv.people_fully_vaccinated, cv.total_vaccinations
from covid_deaths cd
	full outer join COVID_VACCINATIONS cv
	on cd.date = cv.date and cd.location = cv.location
	)

select continent, location, date, population, total_vaccinations, max(total_vaccinations / population)*100 as TOTAL_VAX_PERCENTAGE
from CTE_Covid_Vax
where total_vaccinations is not null and continent is not null
group by continent, location, date, population, total_vaccinations

create view Deaths_per_continent as
select continent, max(cast(total_deaths as int)) as totalCountryDeat
from covid_deaths
where continent is not null
group by continent

create view Cases_per_continent as
select continent, max(cast(total_cases as int)) as totalCountrycases
from covid_deaths
where continent is not null
group by continent

--location and numbers of death
create view Number_deaths_Location as
select location, max(total_deaths) as TOTAL_DEATHS_per_LOC
from Covid_deaths
where total_deaths is not null
group by location


--location with least occurrence of cases
create view Number_cases_location as
select location, max(total_cases) as TOTAL_cases_per_LOC
from Covid_deaths
where total_deaths is not null
group by location




