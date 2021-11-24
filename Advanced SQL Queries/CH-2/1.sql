-- No Conversion 
SELECT *
FROM rental
WHERE inventory_id = 2346;

-- Implicit Conversion 
SELECT *
FROM rental
WHERE inventory_id = '2346';

-- Explicit Conversion 
SELECT *
FROM rental
WHERE inventory_id = integer '2346';

