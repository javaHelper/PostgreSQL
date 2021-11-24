-- Retrieve all the rows - 
-- while combining first_name and last_name in single column
-- with extra column which will list the initials of the actor
-- where the length of the name is of 4 characters
-- while converting all the last name in the upper case
-- while replacing character a with character @ in column first_name

-- while combining first_name and last_name in single column
SELECT first_name, last_name, first_name || ' ' || last_name AS full_name
FROM Actor;

SELECT first_name, last_name, CONCAT(first_name, ' ', last_name) AS full_name
FROM Actor;

-- with extra column which will list the initials of the actor
SELECT first_name, last_name, LEFT(first_name,1) || LEFT(last_name,1) AS Initials
FROM Actor;

-- where the length of the name is of 4 characters
SELECT first_name, last_name
FROM Actor
WHERE LENGTH(first_name) = 4
	OR LENGTH(last_name) = 4;


SELECT first_name, last_name
FROM Actor
WHERE LENGTH(first_name) = 4
	AND LENGTH(last_name) = 4;
	
-- while converting all the last name in the upper case
SELECT first_name, last_name, UPPER(last_name) UpperLastName
FROM Actor;

-- while replacing character a with character @ in column first_name
SELECT first_name, REPLACE(first_name,'a','@'), last_name
FROM Actor;
