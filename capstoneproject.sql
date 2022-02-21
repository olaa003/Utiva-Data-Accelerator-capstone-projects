--to create table
create table international_brewies(
sales_id int,
	sales_rep varchar(255),
	emails varchar(255),
	brands varchar(255),
	plant_cost int,
	unit_price int,
	quantity int,
	cost int,
	profit int,
	countries varchar(255),
	region varchar(255),
	months varchar(255),
	years int
)


--PROFIT ANALYSIS

--1. Within the space of the last three years, what was the profit worth of the breweries,
--inclusive of the anglophone and the francophone territories?
select sum(profit) from international_brewies;

--2. Compare the total profit between these two territories in order for the territory manager,
--Mr. Stone made a strategic decision that will aid profit maximization in 2020.
select distinct countries from international_brewies;

SELECT CASE
	WHEN COUNTRIES in ('Benin','Senegal','Togo') THEN 'FRANCOPHONE'
	WHEN COUNTRIES in ('Ghana','Nigeria') THEN 'ANGLOPHONE'
	END TERRITORIES,
	SUM(PROFIT)
FROM INTERNATIONAL_BREWIES
GROUP BY TERRITORIES;


--3. Country that generated the highest profit in 2019
select sum(profit) as profit, countries from international_brewies
where years=2019
group by countries
order by profit desc
limit 1;

--4. Help him find the year with the highest profit.
select sum(profit) as profit, years from international_brewies
group by years
order by profit desc
limit 1;

--5. Which month in the three years was the least profit generated?
select sum(profit) as profit, months from international_brewies
group by months
order by profit
limit 1;

--6. What was the minimum profit in the month of December 2018?
select min(profit) as profit, months, years from international_brewies
where years=2018 and months='December'
group by months,years
order by months desc;

--7. Compare the profit in percentage for each of the month in 2019
select round((month_profit/sum(month_profit)over())*100,2), months
		from 
(select sum(profit) as month_profit, months from international_brewies where years=2019 group by months)as p_per_month;

--8. Which particular brand generated the highest profit in Senegal?

SELECT  COUNTRIES,
	sum(PROFIT) as profit,
	brands
FROM INTERNATIONAL_BREWIES
where countries='Senegal'
group by brands, countries
order by profit desc
limit 1;


--BRAND ANALYSIS


--1. Within the last two years, the brand manager wants to know the top three brands
--consumed in the francophone countries
select distinct brands from international_brewies;

SELECT 
	BRANDS,
	SUM(QUANTITY) AS TOTAL_NO_CONSUMED
FROM INTERNATIONAL_BREWIES
WHERE YEARS > 2017 and countries in ('Benin','Senegal','Togo')
GROUP BY BRANDS
order by TOTAL_NO_CONSUMED desc
limit 3;


--. Find out the top two choice of consumer brands in Ghana
SELECT 
	BRANDS,
	SUM(QUANTITY) AS TOTAL_NO_CONSUMED
FROM INTERNATIONAL_BREWIES
WHERE countries='Ghana'
GROUP BY BRANDS
order by TOTAL_NO_CONSUMED desc
limit 2;

--3. Find out the details of beers consumed in the past three years in the most oil reached
--country in West Africa
 select brands,sum(quantity) as total_quantity, sum(profit) as total_profit from international_brewies 
 where countries = 'Nigeria' and brands in ('Trophy','Hero','eagle lager','budweiser','castle lite')
 group by brands
 order by total_profit desc;
 
 --4. Favorites malt brand in Anglophone region between 2018 and 2019
SELECT 
	BRANDS,
	SUM(QUANTITY) AS TOTAL_NO_CONSUMED
FROM INTERNATIONAL_BREWIES
WHERE YEARS > 2017 and countries in ('Nigeria','Ghana') and brands in ('grand malt','beta malt')
GROUP BY BRANDS
order by TOTAL_NO_CONSUMED desc
limit 1;

--5. Which brands sold the highest in 2019 in Nigeria?
SELECT 
	BRANDS,
	SUM(QUANTITY) AS TOTAL_NO_CONSUMED
FROM INTERNATIONAL_BREWIES
WHERE YEARS = 2019 and countries ='Nigeria'
GROUP BY BRANDS
order by TOTAL_NO_CONSUMED desc
limit 1;

--6. Favorites brand in South_South region in Nigeria
SELECT 
	BRANDS,
	SUM(QUANTITY) AS TOTAL_NO_CONSUMED
FROM INTERNATIONAL_BREWIES
WHERE region='southsouth' and countries ='Nigeria'
GROUP BY BRANDS
order by TOTAL_NO_CONSUMED desc
limit 1;

--7. Bear consumption in Nigeria
SELECT 
	BRANDS,
	SUM(QUANTITY) AS TOTAL_NO_CONSUMED,
	sum(profit) as total_profit,
	max(unit_price) as unit_price,
	region
FROM INTERNATIONAL_BREWIES
WHERE countries ='Nigeria' and brands in ('Trophy','Hero','eagle lager','budweiser','castle lite')
GROUP BY BRANDS,region
order by brands desc;

--. Level of consumption of Budweiser in the regions in Nigeria
SELECT 
	BRANDS,
	SUM(QUANTITY) AS TOTAL_NO_CONSUMED,
	region
FROM INTERNATIONAL_BREWIES
WHERE countries ='Nigeria' and brands='budweiser'
group by brands,region;

--select distinct brands from international_brewies;

--9. Level of consumption of Budweiser in the regions in Nigeria in 2019 (Decision on Promo)
SELECT 
	BRANDS,
	SUM(QUANTITY) AS TOTAL_NO_CONSUMED,
	region
FROM INTERNATIONAL_BREWIES
WHERE countries ='Nigeria' and brands='budweiser' and years=2019
group by brands,region;



--COUNTRIES ANALYSIS


--. Country with the highest consumption of beer.
SELECT 
	countries,
	SUM(QUANTITY) AS TOTAL_NO_CONSUMED
FROM INTERNATIONAL_BREWIES
where brands not in ('grand malt','beta malt')
group by countries
order by TOTAL_NO_CONSUMED desc
limit 1;

--2. Highest sales personnel of Budweiser in Senegal
SELECT 
	SUM(QUANTITY) AS TOTAL_NO_SOLD,
	sales_rep
FROM INTERNATIONAL_BREWIES
where countries='Senegal' and brands='budweiser'
group by sales_rep
order by TOTAL_NO_SOLD desc
limit 1;

--3. Country with the highest profit of the fourth quarter in 2019
select countries, sum(profit) as total_profit_per_country
from international_brewies
where years=2019 and months in('October','November','December')
group by countries
order by total_profit_per_country desc
limit 1;

select distinct months from international_brewies;