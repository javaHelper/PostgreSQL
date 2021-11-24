-- Retrieve all the rows - 
-- while displaying rental duration in days and hours
-- where rental duration of movie is over 3 days
-- where rental duration of movie is over 100 hours
-- while adding an extra column with fix return_date as 7 days from rental

SELECT *
FROM rental;
-- while displaying rental duration in days and hours
SELECT (return_date - rental_date) AS rented_days
FROM rental;

-- where rental duration of movie is over 3 days
SELECT (return_date - rental_date) rented_days,
	EXTRACT(days FROM return_date - rental_date)
FROM rental
WHERE EXTRACT(days FROM return_date - rental_date) > 3;

-- where rental duration of movie is over 100 hours
SELECT (return_date - rental_date) rented_days, 
	EXTRACT(epoch FROM (return_date - rental_date))/3600
FROM rental
WHERE EXTRACT(epoch FROM (return_date - rental_date))/3600 > 100;

-- while adding an extra column with fix return_date as 7 days from rental
SELECT rental_date, 
	return_date AS original_return_date,
	rental_date + interval '7 day' AS new_return_date,
	return_date - (rental_date + interval '7 day') difference
FROM rental;