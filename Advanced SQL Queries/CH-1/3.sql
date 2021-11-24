-- while converting length of movie from minute to hour
-- where the length of the movie is over 2 hours
-- while converting rental_rate to nearest higher integer 

-- while converting length of movie from minute to hour
SELECT film_id, title, length, 
		(length/60.0) length_in_hour,
		round((length/60.0),2) length_in_hour_round
FROM film;

-- where the length of the movie is over 2 hours
SELECT film_id, title, length, 
		(length/60.0) length_in_hour,
		round((length/60.0),2) length_in_hour_round
FROM film
WHERE length > 120;

SELECT film_id, title, length, 
		(length/60.0) length_in_hour,
		round((length/60.0),2) length_in_hour_round
FROM film
WHERE (length/60.0) > 2;

-- while converting rental_rate to nearest higher integer 
SELECT film_id, title, rental_rate , 
		ceiling(rental_rate) rental_rate_new
FROM film;

