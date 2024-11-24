-- Basic Select statements
select * from customer
select customer_name, age, region from customer

-- Selecting distint shipmodes from sales table
-- and categories from product table
select distinct ship_mode from sales
select distinct category from product

-- where Conditions
select customer_name from customer where age > 30
select * from sales where sales > 500 and discount > 0.5

-- In and Between
select * from customer where region in('South','West')

-- order by and Limit
select * from sales order by sales desc limit 5
select * from customer order by age asc limit 10

-- Like condition
select * from customer where customer_name like 'A%'
select * from product where sub_category like 'Chairs%'

-- Aggregate Functions
select sum(sales) from sales
select sum(sales) from sales where profit > 100
select count(customer_id) from customer
select avg(profit) from sales

-- Case Statements
select *, case when profit > 50 then 'High_Profit'
else 'Lowprofit' end from sales

-- Groupby and Joins, aliasing
select sum(sales),b.category from sales as a
inner join product as b 
on a.product_id = b.product_id
group by category


select a.customer_name,a.age,a.country,b.sales from 
customer as a left join sales as b
on a.customer_id =b.customer_id


-- Subqueries
select a.product_name,a.product_id,b.quantity
from product as a
left join
(select sum(quantity) as quantity,product_id  from sales 
group by product_id 
order by quantity desc) as b
on a.product_id = b.product_id
order by b.quantity desc


-- string functions
select upper(category) as Upper_case_category
from product


select customer_name, concat(city, ' ', state, ' ', country)
as Location from customer


-- date and time functions
select age(ship_date,order_date)as Shipping_Duration from sales

select extract(year from order_date) as YEAR from sales 

-- window functions
select a.customer_name,a.age,a.region,b.sales, row_number()
over(partition by a.region order by b.sales) as row_num
from customer as a
inner join sales as b
on a.customer_id = b.customer_id


select a.customer_name,a.age,a.region,b.sales, rank()
over(partition by a.region order by sales desc) as row_num
from customer as a
inner join sales as b
on a.customer_id = b.customer_id

select a.customer_name,a.age,a.region,b.sales, dense_rank()
over(partition by a.region order by sales desc) as row_num
from customer as a
inner join sales as b
on a.customer_id = b.customer_id


-- Altering Tables

alter table customer add "Phone_number" varchar
alter table customer drop "Phone_number" 
alter table customer rename column "region" to "customer_region"

-- Adding constraits
alter table product add primary key ("product_id")
alter table sales add constraint product_id
foreign key("product_id") references product

-- Advanced Queries
-- Customers that havent placed any others
select * from  customer where customer_id not in 
(select customer_id from sales)

-- products that havent been sold before
select * from  product where product_id not in 
(select product_id from sales)

-- top 10 customers that have generated the highest revenue
select a.*,b.total_sales_per_customer from customer as a
inner join (select customer_id, sum(sales) as 
total_sales_per_customer from sales
group by customer_id
order by total_sales_per_customer desc limit 10) as b
on a.customer_id = b.customer_id




