Use fooddelivery;

/*Query1
Find customers who have never ordered*/
Select user_id from users where user_id not in (Select user_id from orders);

/*Query2
What is Average price per dish*/
SELECT * FROM fooddelivery.food;
SELECT * FROM fooddelivery.menu;
Select food.f_id, f_name, avg(price) from menu inner join food on
menu.f_id = food.f_id group by food.f_id;

/*Query3
Find top restaurants in terms of number of orders for a given month*/
SELECT * FROM fooddelivery.orders;
Select count(order_id),date from orders group by r_id order by count(order_id) desc limit 1;
Select count(order_id),date from orders group by r_id order by month(date);
Select restaurantnow.r_id, count(*) as 'month' from orders inner join restaurantnow where 
monthname(date) like 'July' group by r_id order by count(*) desc limit 1;

/*Query4
Restaurants with monthly sales more than a x value*/
SELECT * FROM fooddelivery.menu;
SELECT * FROM fooddelivery.orders;
Select *,date from orders where amount>200 group by date;
Select restaurantnow.r_id, sum(amount) as 'revenue' from orders inner join restaurantnow where 
monthname(date) like 'June' group by r_id having revenue>500;

/*Query5
Show all the oredrs with order details for a particular customer in a particular date range*/
SELECT * FROM fooddelivery.orders;
SELECT * FROM fooddelivery.users;
Select * from orders inner join users on orders.user_id = users.user_id 
group by users.user_id order by monthname(date);

/*Query6
Find restaurants with maximum repeated customers*/
SELECT * FROM fooddelivery.users;
SELECT * FROM fooddelivery.orders;
Select r_id,user_id,count(*) as 'Visits' from orders group by r_id,user_id;
/*means a person with user_id 1 has visisted r_id 1 , 1 time*/
Select orders.r_id,users.user_id, count(*) as 'num_of_users' from users inner join orders on users.user_id = orders.user_id
group by orders.r_id order by num_of_users desc;
SELECT r_id, count(*) as 'loyalcustomers' from (Select r_id, user_id, count(*) as 'visits' from orders group by r_id, user_id having visits>1) as t group by r_id
order by loyalcustomers desc limit 1;

/*Query7
month over month revenue growth at restaurant*/
SELECT * FROM fooddelivery.orders;
Select r_id, sum(amount) from orders group by r_id, monthname(date) ;
Select r_id, sum(amount) from orders group by monthname(date) ;
Select r_id from orders group by r_id;
Select *,monthname(date) as 'Month' from orders;
Select monthname(date) as 'Month', sum(amount) as 'revenue' from orders group by 1;
Select monthname(date) as 'month', sum(amount) as 'revenue' from orders
group by month
order by Month(date);
with sales as
(
Select monthname(date) as 'month', sum(amount) as 'revenue' from orders
group by month
order by Month(date)
)
Select month,revenue,LAG(revenue,1) over (order by revenue) as prev from sales;

Select month,((revenue-prev)/prev)*100 from (
with sales as
(
Select monthname(date) as 'month', sum(amount) as 'revenue' from orders
group by month
order by Month(date)
)
Select month,revenue,LAG(revenue,1) over (order by revenue) as prev from sales) t;

/*Query8
Customer name and his favorite dish*/
SELECT * FROM fooddelivery.users;
SELECT * FROM fooddelivery.food;
Select users.user_id, users.name, food.f_name, food.f_id from users inner join orders on 
users.user_id = orders.user_id inner join order_details on 
orders.order_id = order_details.order_id inner join food on 
order_details.f_id = food.f_id group by users.user_id order by users.user_id,order_details.f_id;

Select users.user_id, users.name, food.f_name, food.f_id, count(food.f_id) as 'freq' from users inner join orders on 
users.user_id = orders.user_id inner join order_details on 
orders.order_id = order_details.order_id inner join food on 
order_details.f_id = food.f_id group by users.user_id order by users.user_id,order_details.f_id desc;

/*
with fav as
(
  Select orders.user_id, order_details.f_id, count(*) as 'frequency'
  from orders inner join order_details on
  orders.order_id = order_details.order_id
  group by orders.user_id, order_details.f_id
)
Select * from 
fav t
where t.frequency =
(
Select max(t.frequency)
from fav t1
where t1.user_id = t1.user_id
)
*/
/*Query9
First order of all users*/

Select * FROM users;
Select * from orders;
Select *, monthname(date) as 'Month' from orders;
Select count(order_id),orders.user_id,monthname(date) as 'Month'from users inner join orders on users.user_id = orders.user_id
 group by orders.user_id order by 3;
Select *, monthname(date) as 'Month'from users inner join orders on users.user_id = orders.user_id
 group by orders.user_id;
 
 /*Query10
 Revenue growth of a particular restaurant*/
 SELECT * FROM fooddelivery.orders;
Select month,((revenue-prev)/prev)*100 from (
with sales as
(
Select monthname(date) as 'month', sum(amount) as 'revenue'  from orders where r_id = 1
group by month
order by Month(date) 
)
Select month,revenue,LAG(revenue,1) over (order by revenue) as prev from sales) t;






























































