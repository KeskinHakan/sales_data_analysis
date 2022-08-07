-- In this study, dataset is imported to PostgreSQL helping with pg4admin console. Firstly, new table is created with column/data type names.

CREATE TABLE sales  (
    index_ numeric,	
    CustomerID numeric,	
    TOTAL_ORDERS numeric,	
    REVENUE numeric,	
    AVERAGE_ORDER_VALUE numeric,	
    CARRIAGE_REVENUE numeric,	
    AVERAGESHIPPING numeric,	
    FIRST_ORDER_DATE date,	
    LATEST_ORDER_DATE date,	
    AVGDAYSBETWEENORDERS numeric,	
    DAYSSINCELASTORDER numeric,	
    MONDAY_ORDERS numeric,	
    TUESDAY_ORDERS numeric,	
    WEDNESDAY_ORDERS numeric,	
    THURSDAY_ORDERS numeric,	
    FRIDAY_ORDERS numeric,	
    SATURDAY_ORDERS numeric,	
    SUNDAY_ORDERS numeric,	
    MONDAY_REVENUE numeric,	
    TUESDAY_REVENUE numeric,	
    WEDNESDAY_REVENUE numeric,		
    THURSDAY_REVENUE numeric,	
    FRIDAY_REVENUE numeric,	
    SATURDAY_REVENUE numeric,		
    SUNDAY_REVENUE numeric,	
    WEEK1_DAY01_DAY07_ORDERS numeric,	
    WEEK2_DAY08_DAY15_ORDERS numeric,	
    WEEK3_DAY16_DAY23_ORDERS numeric,		
    WEEK4_DAY24_DAY31_ORDERS numeric,	
    WEEK1_DAY01_DAY07_REVENUE numeric,	
    WEEK2_DAY08_DAY15_REVENUE numeric,	
    WEEK3_DAY16_DAY23_REVENUE numeric,		
    WEEK4_DAY24_DAY31_REVENUE numeric,	
    TIME_0000_0600_ORDERS numeric,	
    TIME_0601_1200_ORDERS numeric,
    TIME_1200_1800_ORDERS numeric,	
    TIME_1801_2359_ORDERS numeric,	
    TIME_0000_0600_REVENUE numeric,		
    TIME_0601_1200_REVENUE numeric,		
    TIME_1200_1800_REVENUE numeric,	
    TIME_1801_2359_REVENUE numeric
);

-- Sales table is created with this columns. Now, dataset is imported from the file. If you want to use this dataset, please change the dataset path! Dataset is available also in this folder as "Sales.csv"

COPY sales FROM 'C:\Users\hakan\Downloads\archive\Sales.csv' DELIMITER ',' CSV

-- Now, dataset can be checked to understand the all variables of the data.

SELECT *
FROM sales

-- I prefer to create new tables to visualize the data in Tableau. Because of that, some critical or valuable parts of the data are filtered and sorted to use for the data analysis.

-- First table is the "top_ten_order" thats mean, top ten customers who have the highest total orders are filtered from "sales" table. 

CREATE TABLE top_ten_order AS
SELECT customerid, totalorders FROM sales
ORDER BY totalorders DESC
LIMIT 10

-- Second table is the "top_ten_revenue" thats mean, top ten customers who have the highest revenue are filtered from "sales" table. 

CREATE TABLE top_ten_revenue AS
SELECT customer_id, revenue FROM sales3
ORDER BY revenue DESC
LIMIT 10

-- Third one is the interesting data to analysis for this dataset. For this one, sum of the revenues are filtered by the time zone
-- What does it mean time zone? Thats mean, the day is divided as four quarter part from 00:00-06:00/06:01-12:00/12:01-18:00/18:01-24:00
-- This way, we can understand the most used time by the customers, and we can give some discounts or giveaway for the most used times to the customers.

-- Creating table

CREATE TABLE time_frame (
    id_ varchar(50),
    sum_ integer)

-- Insert data from "sales" table

INSERT INTO time_frame (id_,average) SELECT 'Q1', SUM(time_0000_0600_revenue) FROM sales;
INSERT INTO time_frame (id_,average) SELECT 'Q2', SUM(time_0601_1200_revenue) FROM sales;
INSERT INTO time_frame (id_,average) SELECT 'Q3', SUM(time_1200_1800_revenue) FROM sales;
INSERT INTO time_frame (id_,average) SELECT 'Q4', SUM(time_1801_2359_revenue) FROM sales;

-- Now, we have another valuable data in this datasets. These are the total revenue and orders for weekday and weekend. We can see the consumer habit of the customers.
-- Then, we can rearrange the campaing and special offers according to these results.

-- Lets create tables helping with "sales" table.

CREATE TABLE weekday_weekend_orders (
    day_zone varchar(50),
    total_orders integer)
    
INSERT INTO weekday_weekend_orders (day_zone,total_orders) SELECT 'weekday', SUM(monday_orders+tuesday_orders+wednesday_orders+tuesday_orders+friday_orders) FROM sales;
INSERT INTO weekday_weekend_orders (day_zone,total_orders) SELECT 'weekend', SUM(saturday_orders+sunday_orders) FROM sales;

CREATE TABLE weekday_weekend_revenue (
    day_zone varchar(50),
    total_revenues integer)
    
INSERT INTO weekday_weekend_revenue (day_zone,total_revenues) SELECT 'weekday', SUM(monday_revenue+tuesday_revenue+wednesday_revenue+tuesday_revenue+friday_revenue) FROM sales;
INSERT INTO weekday_weekend_revenue (day_zone,total_revenues) SELECT 'weekend', SUM(saturday_revenue+sunday_revenue) FROM sales;

-- Now, all tables are ready for the analysis. The other parameters and comparisons will be done helping with the main data on Tableau.

-- Visualization of the data can be seen here: [Link will be added]
