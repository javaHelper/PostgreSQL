-- Display the number of total rental in history
-- Display the first ever rental and the latest rental
-- Find out total rental payment collected from customers

-- Display the number of total rental in history
SELECT COUNT(*)
FROM rental;

-- Display the first ever rental and the latest rental
SELECT min(rental_date) FirstRental, 
	max(rental_date) LastRental
FROM rental;

-- Find out total rental payment collected from customers
SELECT sum(amount) RentalAmount
FROM payment;
