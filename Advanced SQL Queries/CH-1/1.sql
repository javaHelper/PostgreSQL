-- where release_year is 2006 and rental_duration is 6 days
-- where release_year is 2006 or rental_duration is 6 days
-- where release_year is 2006 and rental_duration is not 6 days

-- where release_year is 2006 and rental_duration is 6 days
SELECT *
FROM film
WHERE release_year = 2006
	AND rental_duration = 6;

-- where release_year is 2006 or rental_duration is 6 days
SELECT *
FROM film
WHERE release_year = 2006
	OR rental_duration = 6;

-- where release_year is 2006 and rental_duration is not 6 days
SELECT *
FROM film
WHERE release_year = 2006
	AND NOT rental_duration = 6;

SELECT *
FROM film
WHERE release_year = 2006
	AND rental_duration <> 6;