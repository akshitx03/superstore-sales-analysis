-- ============================================
-- SUPERSTORE SALES ANALYSIS
-- SQL PROJECT
-- Database: superstore
-- Table: sales
-- Total Records: 10,194
-- ============================================
-- ============================================
-- 1. DATA IMPORT
-- ============================================
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/superstore cleaned.csv'
INTO TABLE sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    `Row ID`,
    `Order ID`,
    @order_date,
    @ship_date,
    `Ship Mode`,
    `Customer ID`,
    `Customer Name`,
    `Segment`,
    `Country`,
    `City`,
    `State`,
    `Postal Code`,
    `Region`,
    `Product ID`,
    `Category`,
    `Sub-Category`,
    `Product Name`,
    `Sales`,
    `Quantity`,
    `Discount`,
    `Profit`
)
SET
    `Order Date` = STR_TO_DATE(@order_date, '%m/%d/%Y'),
    `Ship Date` = STR_TO_DATE(@ship_date, '%m/%d/%Y');
    -- ============================================
-- 2. BASIC DATA OVERVIEW
-- ============================================
    SELECT COUNT(*) FROM sales;
    SELECT * FROM sales LIMIT 5;
    SELECT SUM(sales) as total_sales from sales;
    select sum(profit) as total_profit from sales;
    select count(*) as total_orders from sales;
    select avg(sales) as average_sales from sales;
    -- ============================================
-- 3. SALES & PROFIT ANALYSIS
-- ============================================
    select category, sum(sales) as total_sales,
    sum(profit) as total_profit from sales
    group by category
    order by total_sales desc;
    -- ============================================
-- 4. REGION ANALYSIS
-- ============================================
    select region,
    sum(sales) as total_sales from sales
    group by region
    order by total_sales desc;
    select region,
    sum(profit) as total_profit from sales
    group by region
    order by total_profit desc;
    select region,
    sum(sales) as total_sales,
    sum(profit) as total_profit from sales
    group by region
    order by total_sales desc;
    select region,
sum(sales) as total_sales,
sum(profit) as total_profit from sales
group by region
order by total_sales desc;
    -- ============================================
-- 5. CATEGORY ANALYSIS
-- ============================================
    select* from sales
    where category = 'technology';
    select distinct category
    from sales;
    select* from sales
    where category = 'furniture';
    select sum(sales) as technology_sales from sales
    where category = 'technology';
    select sum(sales) as furniture_sales from sales
    where category ='furniture';
    select* from sales
    where category ='technology'
	and sales > 5000;
    select count(*) as ordr_count from sales
    where category = 'technology'
    and sales > 4000;
    select* from sales
    where category = 'technology'
    or category = 'furniture';
    select count(*) from sales
    where category in('technology','furniture');
    select* from sales
    limit 1;
    -- ============================================
-- 6. PRODUCT ANALYSIS
-- ============================================
    SELECT `Product Name`, Sales
FROM sales
LIMIT 10;
select `product name`,
sum(sales) as total_sales from sales
group by `product name`
order by total_sales desc
limit 10;
select `product name`,
sum(profit) as total_profit from sales
group by `product name`
order by total_profit desc
limit 5;
-- ============================================
-- 7. SUB-CATEGORY ANALYSIS
-- ============================================
select `sub-category`,
sum(sales) as total_sales,
sum(profit) as total_profit from sales
group by `sub-category`
order by total_sales desc;
select `sub-category`,
sum(sales) as total_sales,
sum(profit) as total_profit from sales
group by `sub-category`
having sum(profit) < 0
order by total_profit asc;
-- ============================================
-- 8. SEGMENT ANALYSIS
-- ============================================
select segment,
sum(sales) as total_sales,
sum(profit) as total_profit from sales
group by segment
order by total_sales desc;
-- ============================================
-- 9. SHIP MODE ANALYSIS
-- ============================================
select `ship mode`,
sum(sales) as total_sales,
sum(profit) as total_profit from sales
group by `ship mode`
order by total_sales desc;
-- ============================================
-- 10. STATE ANALYSIS
-- ============================================
select state,
sum(sales) as total_sales,
sum(profit) as total_profit from sales
group by state
order by total_sales desc;
-- ============================================
-- 11. CITY ANALYSIS
-- ============================================
select city,
sum(sales) as total_sales,
sum(profit) as total_profit from sales
group by city
order by total_sales;
-- ============================================
-- 12. ORDER DATE ANALYSIS
-- ============================================
select year(`order date`),month(`order date`),
sum(sales) as total_sales,
sum(profit) as total_profit from sales
group by year(`order date`),month(`order date`)
having sum(sales)>7000
order by total_sales desc
limit 10;
-- ============================================
-- 13. CUSTOMER ANALYSIS
-- ============================================
select `customer id`,`customer name`,
sum(sales) as total_sales from sales
group by `customer id`,`customer name`
order by total_sales desc
limit 10;
select `customer id`,`customer name`,
sum(profit) as total_profit from sales
group by `customer id`,`customer name`
order by total_profit desc
limit 10;
-- ============================================
-- 14. DISCOUNT ANALYSIS
-- ============================================
select discount,
sum(sales) as total_sales,
sum(profit)as total_profit from sales
group by discount
order by discount;
select discount,
count(*) as order_count,
avg(profit) as avg_profit from sales
group by discount
order by discount;
-- ============================================
-- 15. SHIPPING ANALYSIS
-- ============================================
select `order id`, `order date`,`ship date`,
datediff(`ship date`,`order date`) as shipping_days
from sales
limit 20;
select `ship mode`,
avg(datediff(`ship date`,`order date`)) as avg_shipping_days
from sales
group by `ship mode`
limit 20;
-- ============================================
-- 16. PROFIT MARGIN ANALYSIS
-- ============================================
select
sum(sales)as total_sales,
sum(profit) as total_profit,
sum(profit)/sum(sales)*100 as profit_margin_percentage
from sales
;
select category,
sum(sales) as total_sales,
sum(profit) as total_profit,
sum(profit)/sum(sales)*100 as profit_margin_percentage
from sales
group by category;
select category,
sum(profit) as total_profit from sales
group by category
order by total_profit desc
limit 1;
select category,
avg(profit) as avg_profit from sales
group by category
order by avg_profit desc
limit 1;
select category,
count(*) as total_order from sales
group by category
order by total_order desc
limit 1;
select region,
sum(sales) as total_sales,
sum(profit) as total_profit,
sum(profit)/sum(sales)*100 as profit_margin_percentage
from sales
group by region
order by profit_margin_percentage desc
limit 1;
-- ============================================
-- 17. BUSINESS ANALYSIS
-- ============================================a
select category,
sum(sales)as total_sales from sales
group by category
order by total_sales desc
limit 1;
select * from sales
where category ='technology'
and sales > 500;
select `sub-category`,
sum(profit) as total_profit from sales
group by `sub-category`
having total_profit < 0
order by total_profit desc;
