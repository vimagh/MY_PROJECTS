select * from breweries
--SECTION A: PROFIT ANALYSIS 
--1 profit worth of the breweries, inclusive of the Anglophone and the francophone territories
select sum (profit)
from breweries

--2 . Compare the total profit between these two territories 
with t1 as (select countries, sum(profit) as profits, territories
from breweries
where months = 'January' or months = 'February' or months = 'March'
group by 1, 3
order by profits)

select territories, sum(profits) from t1
where countries = 'Senegal' or countries = 'Benin' 
or  countries = 'Togo'
group by 1
union
select territories, sum(profits) from t1
where countries = 'Nigeria' or countries = 'Ghana'
group by 1

---3 What country generated the highest profit in 2019?
with t1 as (select countries, sum(profit) as profits, years
from breweries
group by 1, 3 
order by profits desc)

 select countries, sum(profits) as profit
 from t1 where years = 2019
 group by 1
 order by profit desc limit 1
 
 ---4 Help him find the year with the highest profit

select sum(profit) as profits, years
from breweries
group by 2 
order by profits desc limit 1

---5 Which month in the three years was the least profit generated

select sum(profit) as profits, months, years
from breweries
group by 2, 3
order by profits limit 1

---6 What was the minimum profit in the month of December 2018

select profit, months, years
from breweries
where months = 'December' and years = 2018
order by profit asc limit 1

---7 Compare the profit for each of the months in 2019 

select sum(profit), months, years
from breweries
where years = 2019
group by 2, 3
order by sum(profit) desc

---8 Which particular brand generated the highest profit in Senegal
select sum(profit), brands, countries
from breweries
where countries = 'Senegal'
group by 2,3
order by sum(profit) desc limit 1

---SECTION B: BRAND ANALYSIS 
---1 top 3 brands consumed in francophone countries within last 2 years

select distinct brands, sum(quantity)
from breweries 
where years = 2018 or years = 2019 and territories = 'francophone'
group by 1
order by sum(quantity) desc limit 3

---2 top two choice of consumer brands in Ghana 
select count(sales_id)as sales, brands
from breweries
where countries = 'Ghana'
group by 2
order by count(sales_id) desc limit 1

---3 details of beers consumed in the past three years in Nigeria
 with t1 as (select sum (profit) as profits, years, brands
from breweries where countries = 'Nigeria'
group by 2,3
)

select sum (profits), years, brands
from t1  where
brands = 'budweiser' or brands = 'castle lite' or brands = 'eagle lager' 
or brands = 'hero' or brands = 'trophy'
group by 2,3
order by years desc

---4 Favorites malt brand in Anglophone region between 2018 and 2019 
with t1 as (select sum(profit) as profits, brands
from breweries
where countries = 'Ghana' or countries = 'Nigeria' 
and years = 2018 or years = 2019
group by 2)

select profits, brands
from t1 where brands = 'beta malt' or brands = 'grand malt'
order by profits desc

---5 Which brands sold the highest in 2019 in Nigeria
select count(sales_id)as sales, brands
from breweries
where countries = 'Nigeria' and years = 2019
group by 2
order by count(sales_id) desc limit 1

---6 Favorites brand in South_South region in Nigeria 
select count (distinct sales_id), brands
from breweries
where countries = 'Nigeria' and region = 'southsouth'
group by 2
order by count (distinct sales_id) desc

---7 Beer consumption in Nigeria
 with t1 as (select distinct brands, profit, sum (quantity)as sales, years
from breweries where countries = 'Nigeria'
group by 1,2,4
)

select distinct brands, sum (sales) as quantiy, years
from t1  where
brands = 'budweiser' or brands = 'castle lite' or brands = 'eagle lager' 
or brands = 'hero' or brands = 'trophy'
group by 1,3
order by years desc

---8 Level of consumption of Budweiser in the regions in Nigeria 

with t1 as (select profit, sum ( quantity)as sales, region, brands
from breweries where countries = 'Nigeria'
group by 1,3,4
)

select sum(profit), sum (sales), region, brands
from t1  where
brands = 'budweiser' 
group by 3,4
order by region desc

---9 Level of consumption of Budweiser in the regions in Nigeria in 2019 

with t1 as (select sum ( quantity)as sales, region, brands
from breweries where countries = 'Nigeria' and years = 2019
group by 2,3
)

select sum (sales) as quantity, region, brands
from t1  where
brands = 'budweiser' 
group by 2, 3
order by region desc

---SECTION C: COUNTRIES ANALYSIS

---1 Country with the highest consumption of beer
with t1 as (select countries, sum(quantity) as quantity, brands
from breweries
where brands = 'budweiser' or brands = 'castle lite' or brands = 'eagle lager' 
or brands = 'hero' or brands = 'trophy'
group by 1, 3)

select countries, sum (quantity)
from t1
group by 1
order by sum (quantity) desc limit 1

---2 Highest sales personnel of Budweiser in Senegal
with t1 as (select sales_rep, sum(quantity), countries, brands
from breweries
group by 1,3, 4)

select sales_rep, sum, brands, countries
from t1 
where countries = 'Senegal' and brands = 'budweiser'
order by sum desc limit 1

---3 Country with the highest profit of the fourth quarter in 2019
with t1 as (select countries, sum(profit) as profits, months
from breweries
where years = 2019 
group by 1, 3
order by profits desc)

select countries, sum(profits)
from t1
where months = 'October' or 
months = 'November' or months = 'December'
group by 1
order by sum(profits) desc limit 1