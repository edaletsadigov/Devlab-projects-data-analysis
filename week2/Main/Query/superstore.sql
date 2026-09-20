--Profile the table: row count, distinct customers, distinct products, min and max order date
select  count(*) as row_count,
        count(distinct CUSTOMER_ID ) as count_of_customers, 
        count(distinct PRODUCT_ID) as count_of_products, 
        min(to_date(ORDER_DATE,'mm,dd,yyyy')) as min_date, 
        max(to_date(ORDER_DATE,'mm,dd,yyyy')) as max_date
from SUPERSTORE;


describe superstore;

-- NULL count for every column (one row per column, or a single row with one COUNT per column)

select 
    count(*) - count(row_id) as null_row_id,
    count(*) - count(order_id) as null_order_id,
    count(*) - count(ORDER_DATE) as null_order_date,
    count(*) - count(SHIP_DATE) as null_ship_date,
    count(*) - count(SHIP_MODE) as null_ship_mode,
    count(*) - count(CUSTOMER_ID) as null_customer_id,
    count(*) - count(CUSTOMER_NAME) as null_customer_name,
    count(*) - count(SEGMENT) as null_segment,
    count(*) - count(COUNTRY) as null_country,
    count(*) - count(CITY) as null_city,
    count(*) - count(STATE) as null_state,
    count(*) - count(POSTAL_CODE) as null_postal_code,
    count(*) - count(REGION) as null_region,
    count(*) - count(PRODUCT_ID) as null_product_id,
    count(*) - count(CATEGORY) as null_category,
    count(*) - count(SUB_CATEGORY) as null_sub_category,
    count(*) - count(PRODUCT_NAME) as null_product_name,
    count(*) - count(SALES ) as null_sales,
    count(*) - count(QUANTITY ) as null_quantity,
    count(*) - count(DISCOUNT) as null_discount,
    count(*) - count(PROFIT)  as null_profit
 from SUPERSTORE;



--Detect duplicate order lines: GROUP BY the natural key and HAVING COUNT(*) > 1
select 
    ORDER_ID,
    product_id, 
    count(*) as count_of_orders 
from SUPERSTORE
group by ORDER_ID,PRODUCT_ID
having count(*)>1;


--Q4 Average days_to_ship per Ship Mode, using SQL date arithmetic (SQLite: julianday(ship_date) - julianday(order_date))
SELECT SHIP_MODE,
       ROUND(AVG(TO_DATE(SHIP_DATE, 'MM,DD,YYYY') - TO_DATE(ORDER_DATE, 'MM,DD,YYYY')), 2) AS avg_days_to_ship
FROM SUPERSTORE
GROUP BY SHIP_MODE
ORDER BY avg_days_to_ship;



--Q5 SUM(Sales), SUM(Profit) and profit margin (Profit/Sales) grouped by Region, Category and Sub-Category, ordered by profit ascending
select 
    region, 
    category, 
    SUB_CATEGORY,
    sum(sales) as total_sales,
    sum(PROFIT) as total_profit,
    round(sum(profit)/nullif(sum(sales),0),3) as profit_margin
from SUPERSTORE
group by region,category,sub_category
order by total_profit asc;



--Q6 Top 5 and bottom 5 Sub-Categories by total profit in a single result set (UNION ALL of two ordered subqueries, or RANK() in a CTE)
select * from (select 
    SUB_CATEGORY,
    sum(PROFIT) as profit_subcategory 
from SUPERSTORE
group by SUB_CATEGORY
order by profit_subcategory desc
fetch first 5 rows only)

union all

select * from (select 
    SUB_CATEGORY,
    sum(PROFIT) as profit_subcategory 
from SUPERSTORE
group by SUB_CATEGORY
order by profit_subcategory asc
fetch first 5 rows only);


--RANK() in a CTE

with subcategory_profit as (
    select 
        sub_category,
        sum(profit) as profit_subcategory2 
    from SUPERSTORE
    group by sub_category
),


ranked as (
    select 
    sub_category,
    profit_subcategory2,
    rank() over(order by profit_subcategory2 asc) as profit_subcategory2_asc,
    rank() over(order by profit_subcategory2 desc) as profit_subcategory2_desc
    from subcategory_profit
)

SELECT
    sub_category,
    profit_subcategory2,
    CASE
        WHEN profit_subcategory2_desc <= 5 THEN 'TOP'
        WHEN profit_subcategory2_asc  <= 5 THEN 'BOTTOM'
    END AS rank_group
FROM ranked
WHERE profit_subcategory2_desc <= 5
   OR profit_subcategory2_asc <= 5
ORDER BY profit_subcategory2 DESC;




--Q7 Discount bands via CASE WHEN (0, 1-20%, 21-40%, 41%+) with order count, avg profit and total profit per band
SELECT
    discount_band,
    COUNT(order_id)       AS order_count,
    ROUND(AVG(profit), 2) AS avg_profit,
    ROUND(SUM(profit), 2) AS total_profit
FROM (
    SELECT
        order_id,
        profit,
        CASE
            WHEN discount = 0                    THEN 'zero'
            WHEN discount BETWEEN 0.01 AND 0.2   THEN 'lower'
            WHEN discount BETWEEN 0.21 AND 0.4   THEN 'middle'
            WHEN discount > 0.4                  THEN 'high'
            ELSE 'unknown'  -- catches NULL discount, kept separate on purpose
        END AS discount_band
    FROM superstore
)
GROUP BY discount_band
ORDER BY discount_band;

--Q8 Total sales per year with YoY absolute and percentage change using LAG()
with absolute as (
select extract( year from to_date(order_date,'mm,dd,yyyy')) as year, sales from SUPERSTORE)

select 
    year,
    sum(sales) total_sales,
    sum(sales) - lag(sum(sales)) OVER (ORDER BY year) AS yoy_absolute,
    round((sum(sales)- lag(sum(sales)) OVER (ORDER BY year))*100/NULLIF(lag(sum(sales)) OVER (ORDER BY year), 0)) AS yoy_percentage
from absolute
group by year
order by year;
--Q9 Sub-categories with negative total profit, and the share of total revenue they represent

select 
    SUB_CATEGORY,
    sum(profit) as total_profit,
    sum(SALES) as total_sales,
    round(sum(sales)*100/(select sum(sales) from SUPERSTORE),2) as revenue_share,
    ROUND(SUM(profit) / NULLIF(SUM(sales), 0), 3) AS profit_margin
from SUPERSTORE
group by SUB_CATEGORY
having sum(profit) <0;



--Q10 Top 10 customers by lifetime profit, with their order count and average order value

select 
    customer_name,
    customer_id,
    sum(profit) as lifetime_profit,
    count(distinct order_id) as count_of_orders ,
    sum(sales) as total_sales,
    round(sum(sales)/count(distinct order_id),2) as AOV 
from SUPERSTORE
group by customer_name,customer_id
order by sum(profit) desc
fetch first 10 rows only;




--Final

WITH yearly AS (
    SELECT EXTRACT(YEAR FROM TO_DATE(order_date, 'MM,DD,YYYY')) AS year,
           sales,
           profit
    FROM superstore
)
SELECT year,
       ROUND(SUM(sales), 0)                         AS total_sales,
       ROUND(SUM(profit), 0)                        AS total_profit,
       ROUND(SUM(profit) / NULLIF(SUM(sales), 0), 3) AS profit_margin
FROM yearly
GROUP BY year
ORDER BY year;