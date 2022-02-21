CREATE TABLE sales_data (
    sales_date date,
    sales_year varchar,
    cus_id varchar,
	cus_age int,
    cus_gender varchar,
    cus_country text,
    cus_state text,
    prod_category varchar,
    prod_subcategory varchar,
    product varchar,
    ord_quantity int,
    unit_cost int,
    unit_price int,
    cost int,
    revenue int
    );
	
	
	SELECT *
FROM sales_data;

SELECT CONCAT(DATE_PART('quarter',SALES_DATE),'Q',TO_CHAR(SALES_DATE,'yy')) AS QUARTER, sum(revenue-cost) as profit
FROM SALES_DATA
group by quarter
ORDER BY QUARTER;

SELECT CONCAT(DATE_PART('quarter',SALES_DATE),'Q',TO_CHAR(SALES_DATE,'yy')) QUARTER, sum(revenue-cost) as profit
FROM SALES_DATA
group by quarter
having CONCAT(DATE_PART('quarter',SALES_DATE),'Q',TO_CHAR(SALES_DATE,'yy')) like '2%'
ORDER BY QUARTER;

(SELECT SUM(REVENUE - COST) AS PROFIT,
	CUS_COUNTRY
FROM SALES_DATA
GROUP BY CUS_COUNTRY
order by profit
limit 1)
union (SELECT SUM(REVENUE - COST) AS PROFIT,
	CUS_COUNTRY
FROM SALES_DATA
GROUP BY CUS_COUNTRY
order by profit desc
limit 1);

SELECT SUM(REVENUE - COST) AS PROFIT,
	CUS_COUNTRY
FROM SALES_DATA
group by CUS_COUNTRY
order by profit desc;

select prod_category, sum(revenue) as revenue
from sales_data
group by prod_category
order by revenue desc;

select prod_category, sum(ord_quantity) as quantity
from sales_data
group by prod_category
order by quantity desc;

select product, sum(revenue-cost) as profit
from sales_data
group by product
order by profit desc;