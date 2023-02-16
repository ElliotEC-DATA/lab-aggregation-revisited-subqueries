use sakila;

-- 1 Select the first name, last name, and email address of all the customers who have rented a movie.

select * from rental;

select c.first_name, c.last_name, c.email from customer c
join rental r on c.customer_id = r.customer_id
group by r.customer_id
limit 20;


-- 2 What is the average payment made by each customer

select * from payment;

-- get the average per customer first

select customer_id, avg(amount) avg_amount from payment
group by customer_id;

-- get the average of this query second

select avg(avg_amount) from (
	select customer_id, avg(amount) avg_amount from payment
	group by customer_id
)sub1;

-- 3 Select the name and email address of all the customers who have rented the "Action" movies.

-- getting the id of it

select category_id from category
where name = 'Action';

select * from (
	select c.first_name, c.last_name, c.email from customer c
	join rental r on c.customer_id = r.customer_id
    join inventory i on r.inventory_id = i.inventory_id
    join film_category fc on i.film_id = fc.film_id
    where fc.category_id = 1
    )sub1;

-- 4 Use the case statement to create a new column classifying existing columns as either or high value -
-- -transactions based on the amount of payment. If the amount is between 0 and 2, label should be low and if the amount-
-- -is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.


select payment_id, customer_id, staff_id, rental_id, amount,
case when amount between 0 and 2 then 'Low' 
when amount between 2 and 4 then 'Medium' when amount > 4 then 'High' 
end as 'transaction_value', 
payment_date, last_update from payment;


