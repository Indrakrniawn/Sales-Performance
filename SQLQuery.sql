-- SALES PERFORMANCE


--CEK TABEL sales_order

select *
from sales_order;


--Overall Performance by Years

select datepart(year, order_date) as Years,sum(sales) as Total_Sales, count(order_id) as Total_Order
from sales_order
where order_status like '%Order Finished%'
group by datepart(year, order_date)
order by datepart(year, order_date);


--OVERALL PERFORMANCE BY PRODUCT SUB CATEGORY

select datepart(year, order_date) as Years, product_sub_category, count(order_id) as Total_Order
from sales_order
where order_status like '%Order Finished%'
group by datepart(year, order_date), product_sub_category
order by datepart(year, order_date), Total_Order desc;  --By Order

select datepart(year, order_date) as Years, product_sub_category, sum(sales) as Total_Sales
from sales_order
where order_status like '%Order Finished%'
group by datepart(year, order_date), product_sub_category
order by datepart(year, order_date), Total_Sales desc;  --By Sales

select product_category, product_sub_category, sum(order_quantity) as Total_Product
from sales_order
where order_status like '%Order Finished%'
group by product_category, product_sub_category --Total product of sales


--BURN RATE ANALYSIS

select datepart(year, order_date) as Years, sum(sales) as Total_Sales, sum(discount_value) as Promotion_Value,
	round((sum(discount_value)/sum(sales)) * 100, 2) as Burn_Rate_Percentage
from sales_order
where order_status like '%Order Finished%'
group by datepart(year, order_date)
order by datepart(year, order_date);

select datepart(year, order_date) as Years,product_category, product_sub_category, sum(sales) as Total_Sales,
	sum(discount_value) as Promotion_Value, round((sum(discount_value)/sum(sales)) * 100, 2) as Burn_Rate_Percentage
from sales_order
where order_status like '%Order Finished%'
group by datepart(year, order_date), product_category, product_sub_category
order by datepart(year, order_date);


--CUSTOMERS GROWTH

select datepart(year, order_date) as Years, count(distinct customer) as Total_Customers
from sales_order
where order_status like '%Order Finished%'
group by datepart(year, order_date);  --Total Customers

select b1.Years, count(b1.customer) as New_Customer
from
	(select customer, min(datepart(year, order_date)) as Years
	from sales_order
	where order_status like '%Order Finished%'
	group by customer) b1
group by Years;  --New Customers

select (count(distinct customer) * 100)/585 as retention_rate
from sales_order
where order_date like '%2009%' and order_status like '%Order Finished%' and customer in
	(select distinct customer
	from sales_order
	where order_date like '%2010%' and order_status like '%Order Finished%') --Retention Rate 2009

select (count(distinct customer) * 100)/593 as retention_rate
from sales_order
where order_date like '%2010%' and order_status like '%Order Finished%' and customer in
	(select distinct customer
	from sales_order
	where order_date like '%2011%' and order_status like '%Order Finished%') --Retention Rate 2010

select (count(distinct customer) * 100)/581 as retention_rate
from sales_order
where order_date like '%2011%' and order_status like '%Order Finished%' and customer in
	(select distinct customer
	from sales_order
	where order_date like '%2012%' and order_status like '%Order Finished%') --Retention Rate 2011



