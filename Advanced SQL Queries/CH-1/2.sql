-- where rental_duration is between 2 and 6 days
-- where length is equal to 160 minutes or rental_duration is between 2 and 6 days


-- where rental_duration is between 2 and 6 days
SELECT *
FROM film
WHERE  rental_duration >=2 
	AND rental_duration <= 6;

SELECT *
FROM film
WHERE  rental_duration BETWEEN 2 AND 6;

-- where length is equal to 160 minutes or rental_duration is between 2 and 6 days
SELECT *
FROM film
WHERE length = 160 
	OR (rental_duration >=2 
		AND rental_duration <= 6);