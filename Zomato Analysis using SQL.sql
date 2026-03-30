create database zomato_project;
use zomato_project;
select * from data;
SELECT * FROM countrycode;
Select * from currency;
show tables;
desc countrycode;


-- No of Restaurants
select count(restaurantid) as Total_Restaurants_Count from data;

-- No of Cities
SELECT 
    COUNT(DISTINCT City) AS Total_Cities
FROM data;

-- Average Ratings
select avg(rating) from data;

-- Total Country
SELECT COUNT(DISTINCT Country) AS Total_Countries
FROM countrycode;

-- Total Cuisines
Select count(distinct cuisines) as Cuisines_Count from data;

-- Number of Restaurants based on City
select city, count(RestaurantID) as No_of_Restaurants from data
group by city;

-- Number of Restaurants based on Country
SELECT C.Country, COUNT(D.restaurantID) as Restaurants_Count
FROM data D
JOIN countrycode C
ON D.CountryCode = C.`Country Code`
GROUP BY C.Country;


-- Percentage of Restaurants based on "Has_Table_booking"
SELECT
    has_table_booking,
    COUNT(*) AS count_of_value,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM data), 2) AS percentage_has_table_booking
FROM
    data
GROUP BY
    has_table_booking;

-- Percentage of Restaurants based on "Has_Online_delivery"
SELECT
    has_online_delivery,
    COUNT(*) AS count_of_value,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM data), 2) AS percentage
FROM
    data
GROUP BY
    has_online_delivery;

-- Count of Restaurants based o n Average Ratings
SELECT rating, count(rating) as No_Restaurants
from data
group by rating
order by count(rating) desc;

-- Number of Restaurants opening based on Year 
Select year, count(year) as No_of_Restaurants 
from data
group by year;

-- Number of Restaurants opening based on Quarter
Select quarter, count(quarter) as No_of_Restaurants
from data
group by quarter;

-- Number of Restaurants opening based on Month
SELECT 
    MONTHNAME(Datekey_Opening) AS MonthName,
    COUNT(*) AS No_of_Restaurants
FROM data
GROUP BY MONTHNAME(Datekey_Opening);

-- Number of Restaurants opening based on Year , Quarter , Month

SELECT 
    YEAR(Datekey_Opening) AS Year,
    QUARTER(Datekey_Opening) AS Quarter,
    MONTH(Datekey_Opening) AS Month,
    COUNT(RestaurantID) AS Total_Restaurants
FROM data
GROUP BY 
    YEAR(Datekey_Opening),
    QUARTER(Datekey_Opening),
    MONTH(Datekey_Opening)
ORDER BY 
    Year, Quarter, Month;


-- Creating price buckets based on cost (USD)
SELECT 
    CASE 
        WHEN (d.Average_Cost_for_two * cr.`USD Rate`) <= 10 THEN '0-10 USD'
        WHEN (d.Average_Cost_for_two * cr.`USD Rate`) <= 25 THEN '11-25 USD'
        WHEN (d.Average_Cost_for_two * cr.`USD Rate`) <= 50 THEN '26-50 USD'
        WHEN (d.Average_Cost_for_two * cr.`USD Rate`) <= 100 THEN '51-100 USD'
        ELSE '100+ USD'
    END AS Price_Bucket_USD,
    
    COUNT(*) AS No_of_Restaurants

FROM data d
JOIN currency cr 
ON d.Currency = cr.Currency

GROUP BY Price_Bucket_USD;

-- Eating week of the day preference
SELECT 
    `Weekday/Weekend`,
    COUNT(*) AS No_of_Restaurants
FROM data
GROUP BY `Weekday/Weekend`;

-- Ranking cities by number of restaurants
SELECT 
    City,
    COUNT(*) AS Restaurants,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS Rank_City
FROM data
GROUP BY City;

