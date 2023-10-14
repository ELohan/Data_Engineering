use world;

show tables;

SELECT * FROM city;
SELECT * FROM country;
SELECT * FROM countrylanguage;
describe city;
describe country;
describe countrylanguage;


#List the Countries with the Highest Population:
#This query lists the top 10 countries with the highest populations in descending order.
SELECT Name, Population
FROM Country
ORDER BY Population DESC
LIMIT 10;

#Count the Number of Cities in Each Country:
#This query counts the number of cities in each country and lists them in descending order of city count.
SELECT Country.Name, COUNT(City.Name) AS Num_Cities
FROM Country
LEFT JOIN City ON Country.Code = City.CountryCode
GROUP BY Country.Name
ORDER BY Num_Cities DESC;

#List the Official Languages of a Country (e.g., Germany):
#This query retrieves the official languages of a specific country ('Ireland' in this example).
SELECT Country.Name, Language
FROM CountryLanguage
JOIN Country ON Country.Code = CountryLanguage.CountryCode
WHERE IsOfficial = 'T' AND Country.Name = 'Ireland';


#Calculate the Average Life Expectancy Worldwide:
#This query calculates and returns the average life expectancy across all countries.
SELECT AVG(LifeExpectancy)
FROM Country;


#Find the Most Spoken Languages Worldwide:
#This query identifies and lists the top 5 most spoken languages in the world based on the number of countries where they are spoken.
SELECT Language, COUNT(*) AS Num_Countries
FROM CountryLanguage
GROUP BY Language
ORDER BY Num_Countries DESC
LIMIT 5;

#List the Countries with a Population Above a Certain Threshold (e.g., 100 million):
#This query retrieves countries with populations exceeding a specified threshold (100 million in this example).
SELECT Name, Population
FROM Country
WHERE Population > 100000000;

#Identify Countries with No Coastline:
#This query finds and lists countries that have no coastline.
SELECT Name
FROM Country
WHERE Coastline = '0';

#Retrieve the Continent with the Most Countries:
#This query identifies the continent with the most countries and returns its name.
SELECT Continent, COUNT(*) AS Num_Countries
FROM Country
GROUP BY Continent
ORDER BY Num_Countries DESC
LIMIT 1;

#Complex Queries

#Find Countries with the Highest and Lowest Populations:
SELECT
    H.Name AS Highest_Population_Country,
    H.Population AS Highest_Population,
    L.Name AS Lowest_Population_Country,
    L.Population AS Lowest_Population
FROM
    (SELECT Name, Population
     FROM Country
     ORDER BY Population DESC
     LIMIT 1) AS H
JOIN
    (SELECT Name, Population
     FROM Country
     ORDER BY Population ASC
     LIMIT 1) AS L;
     
     
#2)Calculate the Average Population of Cities in Each Country:
SELECT
    Country.Name AS Country_Name,
    AVG(City.Population) AS Avg_City_Population
FROM
    Country
LEFT JOIN
    City ON Country.Code = City.CountryCode
GROUP BY
    Country_Name
ORDER BY
    Avg_City_Population DESC;

#3)List Countries with Multiple Official Languages:
SELECT
    Country.Name AS Country_Name,
    COUNT(*) AS Num_Official_Languages
FROM
    Country
JOIN
    CountryLanguage ON Country.Code = CountryLanguage.CountryCode
WHERE
    CountryLanguage.IsOfficial = 'T'
GROUP BY
    Country_Name
HAVING
    Num_Official_Languages > 1
ORDER BY
    Num_Official_Languages DESC;

#4)Find Countries with the Largest Land Area in Each Continent:
SELECT
    Continent,
    Country.Name AS Country_Name,
    MAX(SurfaceArea) AS Largest_Surface_Area
FROM
    Country
JOIN
    (SELECT Continent, MAX(SurfaceArea) AS Max_Surface_Area
     FROM Country
     GROUP BY Continent) AS MaxSurface
ON
    Country.Continent = MaxSurface.Continent
WHERE
    SurfaceArea = Max_Surface_Area
GROUP BY
    Continent, Country_Name;

#5)Calculate the Total Population of Continents and Their Share of World Population:
SELECT
    Country.Continent,
    SUM(Country.Population) AS Total_Population,
    SUM(Country.Population) / (SELECT SUM(Population) FROM Country) AS World_Population_Share
FROM
    Country
GROUP BY
    Country.Continent;










