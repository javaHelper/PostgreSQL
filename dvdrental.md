# Chapter-20: PostgreSQL HAVING

```sql
SELECT
	customer_id,
	SUM (amount)
FROM
	payment
GROUP BY
	customer_id
HAVING
	SUM (amount) > 200;
	
customer_id|sum   |
-----------+------+
        526|208.58|
        148|211.55|
	
SELECT
	store_id,
	COUNT (customer_id)
FROM
	customer
GROUP BY
	store_id
	
store_id|count|
--------+-----+
       1|  326|
       2|  273|
       
SELECT
	store_id,
	COUNT (customer_id)
FROM
	customer
GROUP BY
	store_id
HAVING
	COUNT (customer_id) > 300;
	
store_id|count|
--------+-----+
       1|  326|	
```

-----------
# Chapter-19: PostgreSQL GROUP BY

```sql
SELECT
   customer_id
FROM
   payment
GROUP BY
   customer_id;
   
customer_id|
-----------+
        184|
         87|
        477|
        273|
        550|
         51|
        394|
	
SELECT
	customer_id,
	SUM (amount)
FROM
	payment
GROUP BY
	customer_id;
	
customer_id|sum   |
-----------+------+
        184| 80.80|
         87|137.72|
        477|106.79|
        273|130.72|
        550|151.69|
         51|123.70|
        394| 77.80|
        272| 65.87|
	
SELECT
	customer_id,
	SUM (amount)
FROM
	payment
GROUP BY
	customer_id
ORDER BY
	SUM (amount) DESC;

customer_id|sum   |
-----------+------+
        148|211.55|
        526|208.58|
        178|194.61|
        137|191.62|
        144|189.60|
        459|183.63|
        181|167.67|
        410|167.62|
	

SELECT
	first_name || ' ' || last_name full_name,
	SUM (amount) amount
FROM
	payment
INNER JOIN customer USING (customer_id)    	
GROUP BY
	full_name
ORDER BY amount DESC;	

full_name            |amount|
---------------------+------+
Eleanor Hunt         |211.55|
Karl Seal            |208.58|
Marion Snyder        |194.61|
Rhonda Kennedy       |191.62|
Clara Shaw           |189.60|
Tommy Collazo        |183.63|
Ana Bradley          |167.67|
Curtis Irby          |167.62|
Marcia Dean          |166.61|


SELECT
	staff_id,
	COUNT (payment_id)
FROM
	payment
GROUP BY
	staff_id;

staff_id|count|
--------+-----+
       1| 7292|
       2| 7304|
       
SELECT 
	customer_id, 
	staff_id, 
	SUM(amount) 
FROM 
	payment
GROUP BY 
	staff_id, 
	customer_id
ORDER BY 
    customer_id;
    
customer_id|staff_id|sum   |
-----------+--------+------+
          1|       2| 53.85|
          1|       1| 60.85|
          2|       2| 67.88|
          2|       1| 55.86|
          3|       1| 59.88|
          3|       2| 70.88|
          4|       2| 31.90|
          4|       1| 49.88|
          5|       1| 63.86|
          5|       2| 70.79|
	  
SELECT 
	DATE(payment_date) paid_date, 
	SUM(amount) sum
FROM 
	payment
GROUP BY
	DATE(payment_date);
	
paid_date |sum    |
----------+-------+
2007-02-14| 116.73|
2007-02-19|1290.90|
2007-02-20|1219.09|
2007-03-19|2617.69|
2007-04-26| 347.21|
2007-04-08|2227.84|
2007-02-15|1188.92|
2007-04-28|2622.73|
2007-03-17|2442.16|
2007-03-20|2669.89|	
```

---------------

# Chapter-18: PostgreSQL NATURAL JOIN Explained By Examples

paid_date |sum    |
----------+-------+
2007-02-14| 116.73|
2007-02-19|1290.90|
2007-02-20|1219.09|
2007-03-19|2617.69|
2007-04-26| 347.21|
2007-04-08|2227.84|
2007-02-15|1188.92|
2007-04-28|2622.73|
2007-03-17|2442.16|
2007-03-20|2669.89|

```sql
DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
	category_id serial PRIMARY KEY,
	category_name VARCHAR (255) NOT NULL
);

DROP TABLE IF EXISTS products;
CREATE TABLE products (
	product_id serial PRIMARY KEY,
	product_name VARCHAR (255) NOT NULL,
	category_id INT NOT NULL,
	FOREIGN KEY (category_id) REFERENCES categories (category_id)
);

INSERT INTO categories (category_name)
VALUES
	('Smart Phone'),
	('Laptop'),
	('Tablet');

INSERT INTO products (product_name, category_id)
VALUES
	('iPhone', 1),
	('Samsung Galaxy', 1),
	('HP Elite', 2),
	('Lenovo Thinkpad', 2),
	('iPad', 3),
	('Kindle Fire', 3);
	
SELECT * FROM products
NATURAL JOIN categories;

OR

SELECT	* FROM products
INNER JOIN categories USING (category_id);

category_id|product_id|product_name   |category_name|
-----------+----------+---------------+-------------+
          1|         1|iPhone         |Smart Phone  |
          1|         2|Samsung Galaxy |Smart Phone  |
          2|         3|HP Elite       |Laptop       |
          2|         4|Lenovo Thinkpad|Laptop       |
          3|         5|iPad           |Tablet       |
          3|         6|Kindle Fire    |Tablet       |
	  
	  
```

-------------
# Chapter-17: PostgreSQL Cross Join By Example

```sql
DROP TABLE IF EXISTS T1;
CREATE TABLE T1 (label CHAR(1) PRIMARY KEY);

DROP TABLE IF EXISTS T2;
CREATE TABLE T2 (score INT PRIMARY KEY);

INSERT INTO T1 (label)
VALUES
	('A'),
	('B');

INSERT INTO T2 (score)
VALUES
	(1),
	(2),
	(3);
	
SELECT *
FROM T1
CROSS JOIN T2;

label|score|
-----+-----+
A    |    1|
B    |    1|
A    |    2|
B    |    2|
A    |    3|
B    |    3|


```

------------

# Chapter-16: PostgreSQL FULL OUTER JOIN

```sql
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS employees;

CREATE TABLE departments (
	department_id serial PRIMARY KEY,
	department_name VARCHAR (255) NOT NULL
);

CREATE TABLE employees (
	employee_id serial PRIMARY KEY,
	employee_name VARCHAR (255),
	department_id INTEGER
);

INSERT INTO departments (department_name)
VALUES
	('Sales'),
	('Marketing'),
	('HR'),
	('IT'),
	('Production');

INSERT INTO employees (
	employee_name,
	department_id
)
VALUES
	('Bette Nicholson', 1),
	('Christian Gable', 1),
	('Joe Swank', 2),
	('Fred Costner', 3),
	('Sandra Kilmer', 4),
	('Julia Mcqueen', NULL);
	
SELECT
	employee_name,
	department_name
FROM
	employees e
FULL OUTER JOIN departments d 
        ON d.department_id = e.department_id;
	
employee_name  |department_name|
---------------+---------------+
Bette Nicholson|Sales          |
Christian Gable|Sales          |
Joe Swank      |Marketing      |
Fred Costner   |HR             |
Sandra Kilmer  |IT             |
Julia Mcqueen  |               |
               |Production     |
	       
SELECT
	employee_name,
	department_name
FROM
	employees e
FULL OUTER JOIN departments d 
        ON d.department_id = e.department_id
WHERE
	employee_name IS NULL;
	
OR 

SELECT
	employee_name,
	department_name
FROM
	employees e
FULL OUTER JOIN departments d ON d.department_id = e.department_id
WHERE
	department_name IS NULL;
	
employee_name|department_name|
-------------+---------------+
             |Production     |
	     
	     
```

--------
# Chapter-15: PostgreSQL Self-Join

```sql
CREATE TABLE employee (
	employee_id INT PRIMARY KEY,
	first_name VARCHAR (255) NOT NULL,
	last_name VARCHAR (255) NOT NULL,
	manager_id INT,
	FOREIGN KEY (manager_id) 
	REFERENCES employee (employee_id) 
	ON DELETE CASCADE
);
INSERT INTO employee (
	employee_id,
	first_name,
	last_name,
	manager_id
)
VALUES
	(1, 'Windy', 'Hays', NULL),
	(2, 'Ava', 'Christensen', 1),
	(3, 'Hassan', 'Conner', 1),
	(4, 'Anna', 'Reeves', 2),
	(5, 'Sau', 'Norman', 2),
	(6, 'Kelsie', 'Hays', 3),
	(7, 'Tory', 'Goff', 3),
	(8, 'Salley', 'Lester', 3);
	
SELECT
    e.first_name || ' ' || e.last_name employee,
    m .first_name || ' ' || m .last_name manager
FROM
    employee e
INNER JOIN employee m ON m .employee_id = e.manager_id
ORDER BY manager;

employee       |manager        |
---------------+---------------+
Sau Norman     |Ava Christensen|
Anna Reeves    |Ava Christensen|
Salley Lester  |Hassan Conner  |
Kelsie Hays    |Hassan Conner  |
Tory Goff      |Hassan Conner  |
Ava Christensen|Windy Hays     |
Hassan Conner  |Windy Hays     |

SELECT
    e.first_name || ' ' || e.last_name employee,
    m .first_name || ' ' || m .last_name manager
FROM
    employee e
LEFT JOIN employee m ON m .employee_id = e.manager_id
ORDER BY manager;

employee       |manager        |
---------------+---------------+
Anna Reeves    |Ava Christensen|
Sau Norman     |Ava Christensen|
Salley Lester  |Hassan Conner  |
Kelsie Hays    |Hassan Conner  |
Tory Goff      |Hassan Conner  |
Hassan Conner  |Windy Hays     |
Ava Christensen|Windy Hays     |
Windy Hays     |               |

SELECT
    f1.title,
    f2.title,
    f1.length
FROM
    film f1
INNER JOIN film f2 
    ON f1.film_id <> f2.film_id AND 
       f1.length = f2.length;
       
title               |title                 |length|
--------------------+----------------------+------+
Chamber Italian     |Resurrection Silverado|   117|
Chamber Italian     |Magic Mallrats        |   117|
Chamber Italian     |Graffiti Love         |   117|
Chamber Italian     |Affair Prejudice      |   117|
Grosse Wonderful    |Hurricane Affair      |    49|
Grosse Wonderful    |Hook Chariots         |    49|
Grosse Wonderful    |Heavenly Gun          |    49|
Grosse Wonderful    |Doors President       |    49|
Airport Pollock     |Sense Greek           |    54|
Airport Pollock     |October Submarine     |    54|       
```

---------------
# Chapter-14: Left Join

```sql
select f.film_id , f.title , i.inventory_id 
from film f 
left join inventory i 
on i.film_id = f.film_id 
order by f.title ;

film_id|title                      |inventory_id|
-------+---------------------------+------------+
      1|Academy Dinosaur           |           6|
      1|Academy Dinosaur           |           1|
      1|Academy Dinosaur           |           4|
      1|Academy Dinosaur           |           7|
      1|Academy Dinosaur           |           3|
      1|Academy Dinosaur           |           5|
      1|Academy Dinosaur           |           8|
      1|Academy Dinosaur           |           2|
      2|Ace Goldfinger             |           9|
      2|Ace Goldfinger             |          10|
      2|Ace Goldfinger             |          11|
      3|Adaptation Holes           |          12|
      3|Adaptation Holes           |          13|
      3|Adaptation Holes           |          14|
      
      
select f.film_id , f.title , i.inventory_id 
from film f 
left join inventory i 
on i.film_id = f.film_id 
where i.film_id is null
order by f.title ;

film_id|title                 |inventory_id|
-------+----------------------+------------+
     14|Alice Fantasia        |            |
     33|Apollo Teen           |            |
     36|Argonauts Town        |            |
     38|Ark Ridgemont         |            |
     41|Arsenic Independence  |            |
     87|Boondock Ballroom     |            |
    108|Butch Panther         |            |
    128|Catch Amistad         |            |
    144|Chinatown Gladiator   |            |
    148|Chocolate Duck        |            |
    171|Commandments Express  |            |
    192|Crossing Divorce      |            |
    
SELECT
	f.film_id,
	title,
	inventory_id
FROM
	film f
LEFT JOIN inventory i USING (film_id)
WHERE i.film_id IS NULL
ORDER BY title;

film_id|title                 |inventory_id|
-------+----------------------+------------+
     14|Alice Fantasia        |            |
     33|Apollo Teen           |            |
     36|Argonauts Town        |            |
     38|Ark Ridgemont         |            |
     41|Arsenic Independence  |            |
     87|Boondock Ballroom     |            |
    108|Butch Panther         |            |
    128|Catch Amistad         |            |
    144|Chinatown Gladiator   |            |
    148|Chocolate Duck        |            |
    171|Commandments Express  |            |
    192|Crossing Divorce      |            |
```

# Chapter-13: Inner Join

```sql
select c.customer_id , c.first_name , c.last_name , p.amount , p.payment_date 
from customer c 
inner join payment p 
	on p.customer_id = c.customer_id 
order by p.payment_date 
	
customer_id|first_name|last_name  |amount|payment_date       |
-----------+----------+-----------+------+-------------------+
        416|Jeffery   |Pinson     |  2.99|2007-02-14 21:21:59|
        516|Elmer     |Noe        |  4.99|2007-02-14 21:23:39|
        239|Minnie    |Romero     |  4.99|2007-02-14 21:29:00|
        592|Terrance  |Roush      |  6.99|2007-02-14 21:41:12|
         49|Joyce     |Edwards    |  0.99|2007-02-14 21:44:52|
        264|Gwendolyn |May        |  3.99|2007-02-14 21:44:53|
         46|Catherine |Campbell   |  4.99|2007-02-14 21:45:29|
        481|Herman    |Devore     |  2.99|2007-02-14 22:03:35|
        139|Amber     |Dixon      |  2.99|2007-02-14 22:11:22|
	
select c.customer_id , c.first_name , c.last_name , p.amount , p.payment_date 
from customer c 
inner join payment p 
	on p.customer_id = c.customer_id 
where c.customer_id = 2;

customer_id|first_name|last_name|amount|payment_date       |
-----------+----------+---------+------+-------------------+
          2|Patricia  |Johnson  |  2.99|2007-02-17 19:23:24|
          2|Patricia  |Johnson  |  0.99|2007-03-01 08:13:52|
          2|Patricia  |Johnson  |  0.99|2007-03-02 00:39:22|
          2|Patricia  |Johnson  |  5.99|2007-03-02 06:10:07|
          2|Patricia  |Johnson  |  6.99|2007-03-02 09:12:14|
          2|Patricia  |Johnson  |  2.99|2007-03-02 12:13:19|
          2|Patricia  |Johnson  |  2.99|2007-03-17 02:20:44|
          2|Patricia  |Johnson  |  2.99|2007-03-19 04:54:30|
          2|Patricia  |Johnson  |  4.99|2007-03-21 11:52:58|
	  
	  
SELECT
	customer_id,
	first_name,
	last_name,
	amount,
	payment_date
FROM
	customer
INNER JOIN payment USING(customer_id)
ORDER BY payment_date;

customer_id|first_name|last_name  |amount|payment_date       |
-----------+----------+-----------+------+-------------------+
        416|Jeffery   |Pinson     |  2.99|2007-02-14 21:21:59|
        516|Elmer     |Noe        |  4.99|2007-02-14 21:23:39|
        239|Minnie    |Romero     |  4.99|2007-02-14 21:29:00|
        592|Terrance  |Roush      |  6.99|2007-02-14 21:41:12|
         49|Joyce     |Edwards    |  0.99|2007-02-14 21:44:52|
        264|Gwendolyn |May        |  3.99|2007-02-14 21:44:53|
	
select c.customer_id,
	c.first_name customer_first_name,
	c.last_name customer_last_name,
	s.first_name staff_first_name,
	s.last_name staff_last_name,
	amount,
	payment_date 
from customer c 
inner join payment p 
on p.customer_id = c.customer_id 
inner join staff s 
on p.staff_id = s.staff_id 
order by p.payment_date 

customer_id|customer_first_name|customer_last_name|staff_first_name|staff_last_name|amount|payment_date       |
-----------+-------------------+------------------+----------------+---------------+------+-------------------+
        416|Jeffery            |Pinson            |Jon             |Stephens       |  2.99|2007-02-14 21:21:59|
        516|Elmer              |Noe               |Jon             |Stephens       |  4.99|2007-02-14 21:23:39|
        239|Minnie             |Romero            |Mike            |Hillyer        |  4.99|2007-02-14 21:29:00|
        592|Terrance           |Roush             |Jon             |Stephens       |  6.99|2007-02-14 21:41:12|
         49|Joyce              |Edwards           |Mike            |Hillyer        |  0.99|2007-02-14 21:44:52|
        264|Gwendolyn          |May               |Jon             |Stephens       |  3.99|2007-02-14 21:44:53|
         46|Catherine          |Campbell          |Mike            |Hillyer        |  4.99|2007-02-14 21:45:29|
        481|Herman             |Devore            |Jon             |Stephens       |  2.99|2007-02-14 22:03:35|
        139|Amber              |Dixon             |Jon             |Stephens       |  2.99|2007-02-14 22:11:22|

```


-------------
# Chapter-12: PostgreSQL Joins

```sql
CREATE TABLE basket_a (
    a INT PRIMARY KEY,
    fruit_a VARCHAR (100) NOT NULL
);

CREATE TABLE basket_b (
    b INT PRIMARY KEY,
    fruit_b VARCHAR (100) NOT NULL
);

INSERT INTO basket_a (a, fruit_a)
VALUES
    (1, 'Apple'),
    (2, 'Orange'),
    (3, 'Banana'),
    (4, 'Cucumber');

INSERT INTO basket_b (b, fruit_b)
VALUES
    (1, 'Orange'),
    (2, 'Apple'),
    (3, 'Watermelon'),
    (4, 'Pear');
    
# Inner join

select ba.a , ba.fruit_a , bb.b , bb.fruit_b 
from basket_a ba 
inner join basket_b bb 
on ba.fruit_a = bb.fruit_b ;

a|fruit_a|b|fruit_b|
-+-------+-+-------+
1|Apple  |2|Apple  |
2|Orange |1|Orange |

# Left Join

select ba.a , ba.fruit_a , bb.b , bb.fruit_b 
from basket_a ba 
left join basket_b bb 
on ba.fruit_a = bb.fruit_b ;

a|fruit_a |b|fruit_b|
-+--------+-+-------+
1|Apple   |2|Apple  |
2|Orange  |1|Orange |
3|Banana  | |       |
4|Cucumber| |       |

# Left Outer Join

select ba.a , ba.fruit_a , bb.b , bb.fruit_b 
from basket_a ba 
left join basket_b bb 
on ba.fruit_a = bb.fruit_b 
where b is null ;

a|fruit_a |b|fruit_b|
-+--------+-+-------+
3|Banana  | |       |
4|Cucumber| |       |

select ba.a , ba.fruit_a , bb.b , bb.fruit_b 
from basket_a ba 
right join basket_b bb 
on ba.fruit_a = bb.fruit_b ;

a|fruit_a|b|fruit_b   |
-+-------+-+----------+
2|Orange |1|Orange    |
1|Apple  |2|Apple     |
 |       |3|Watermelon|
 |       |4|Pear      |
   
   
select ba.a , ba.fruit_a , bb.b , bb.fruit_b 
from basket_a ba 
right outer join basket_b bb 
on ba.fruit_a = bb.fruit_b 
where a is null;

a|fruit_a|b|fruit_b   |
-+-------+-+----------+
 |       |3|Watermelon|
 |       |4|Pear      |
 
 
 select ba.a , ba.fruit_a , bb.b , bb.fruit_b 
from basket_a ba 
full outer join basket_b bb 
on ba.fruit_a = bb.fruit_b ;

a|fruit_a |b|fruit_b   |
-+--------+-+----------+
1|Apple   |2|Apple     |
2|Orange  |1|Orange    |
3|Banana  | |          |
4|Cucumber| |          |
 |        |3|Watermelon|
 |        |4|Pear      |
 
 
 
select ba.a , ba.fruit_a , bb.b , bb.fruit_b 
from basket_a ba 
full outer join basket_b bb 
on ba.fruit_a = bb.fruit_b 
where a is null or b is null ;

a|fruit_a |b|fruit_b   |
-+--------+-+----------+
3|Banana  | |          |
4|Cucumber| |          |
 |        |3|Watermelon|
 |        |4|Pear      |
```

![image](https://user-images.githubusercontent.com/54174687/206704704-a0f05e15-6d33-447e-bfc5-4354d4c85d81.png)


-----------
# Chapter-11: PostgreSQL IS NULL

```sql
CREATE TABLE contacts(
    id SERIAL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(15),
    PRIMARY KEY (id)
);

INSERT INTO contacts(first_name, last_name, email, phone)
VALUES ('John','Doe','john.doe@example.com',NULL),
    ('Lily','Bush','lily.bush@example.com','(408-234-2764)');
    
    
select id, first_name , last_name , email , phone 
from contacts c 
where phone = NULL;

The statement returns no row. This is because the expression phone = NULL in the WHERE clause always returns false.

select id, first_name , last_name , email , phone 
from contacts c 
where phone is NULL;

id|first_name|last_name|email               |phone|
--+----------+---------+--------------------+-----+
 1|John      |Doe      |john.doe@example.com|     |
 
select id, first_name , last_name , email , phone 
from contacts c 
where phone is not NULL;

id|first_name|last_name|email                |phone         |
--+----------+---------+---------------------+--------------+
 2|Lily      |Bush     |lily.bush@example.com|(408-234-2764)|
```


---------
# Chapter-10: PostgreSQL LIKE

```sql
select first_name , last_name 
from customer c 
where first_name like 'Jen%';

first_name|last_name|
----------+---------+
Jennifer  |Davis    |
Jennie    |Terry    |
Jenny     |Castro   |

select first_name , last_name 
from customer c 
where first_name like '%er%'
order by first_name ;

first_name |last_name  |
-----------+-----------+
Albert     |Crouse     |
Alberto    |Henning    |
Alexander  |Fennell    |
Amber      |Dixon      |

select first_name , last_name 
from customer c 
where first_name like '_her%'
order by first_name ;

first_name|last_name|
----------+---------+
Cheryl    |Murphy   |
Sherri    |Rhodes   |
Sherry    |Marshall |
Theresa   |Watson   |

select first_name , last_name 
from customer c 
where first_name not like 'Jen%'
order by first_name ;

first_name |last_name  |
-----------+-----------+
Aaron      |Selby      |
Adam       |Gooch      |
Adrian     |Clary      |
Agnes      |Bishop     |
Alan       |Kahn       |

select first_name , last_name 
from customer c 
where first_name ilike 'BAR%'
order by first_name ;

first_name|last_name|
----------+---------+
Barbara   |Jones    |
Barry     |Lovelace |


```

--------------
# Chapter-9: PostgreSQL BETWEEN

```sql
select customer_id , payment_id , amount 
from payment p 
where amount between 8 and 9;

customer_id|payment_id|amount|
-----------+----------+------+
        343|     17517|  8.99|
        347|     17529|  8.99|
        347|     17532|  8.99|
        348|     17535|  8.99|
        349|     17540|  8.99|
        379|     17648|  8.99|
	
select customer_id , payment_id , amount 
from payment p 
where amount not between 8 and 9;

customer_id|payment_id|amount|
-----------+----------+------+
        341|     17503|  7.99|
        341|     17504|  1.99|
        341|     17505|  7.99|
        341|     17506|  2.99|
        341|     17507|  7.99|
	
select customer_id , payment_id , amount 
from payment p 
where payment_date BETWEEN '2007-02-07' AND '2007-02-15';

customer_id|payment_id|amount|
-----------+----------+------+
        368|     17610|  0.99|
        370|     17617|  6.99|
        402|     17743|  4.99|
        416|     17793|  2.99|
        432|     17854|  5.99|
	
	
```

-------------
# Chapter-8:  PostgreSQL IN

```sql
SELECT customer_id,
	rental_id,
	return_date
FROM
	rental
WHERE
	customer_id IN (1, 2)
ORDER BY
	return_date DESC;
	
customer_id|rental_id|return_date        |
-----------+---------+-------------------+
          2|    15145|2005-08-31 15:51:04|
          1|    15315|2005-08-30 01:51:46|
          2|    14743|2005-08-29 00:18:56|
          1|    15298|2005-08-28 22:49:37|
          2|    14475|2005-08-27 08:59:32|
          1|    14825|2005-08-27 07:01:57|
          2|    15907|2005-08-25 23:23:35|
	  
SELECT
	rental_id,
	customer_id,
	return_date
FROM
	rental
WHERE
	customer_id = 1 OR customer_id = 2
ORDER BY
	return_date DESC;
	
rental_id|customer_id|return_date        |
---------+-----------+-------------------+
    15145|          2|2005-08-31 15:51:04|
    15315|          1|2005-08-30 01:51:46|
    14743|          2|2005-08-29 00:18:56|
    15298|          1|2005-08-28 22:49:37|
    14475|          2|2005-08-27 08:59:32|
    14825|          1|2005-08-27 07:01:57|
    15907|          2|2005-08-25 23:23:35|
    12963|          2|2005-08-23 11:37:04|
    
SELECT
	customer_id,
	rental_id,
	return_date
FROM
	rental
WHERE
	customer_id NOT IN (1, 2);
	
customer_id|rental_id|return_date        |
-----------+---------+-------------------+
        459|        2|2005-05-28 19:40:33|
        408|        3|2005-06-01 22:12:39|
        333|        4|2005-06-03 01:43:41|
        222|        5|2005-06-02 04:33:21|
        549|        6|2005-05-27 01:32:07|
        269|        7|2005-05-29 20:34:53|
        239|        8|2005-05-27 23:33:46|
        126|        9|2005-05-28 00:22:40|	

SELECT
	customer_id,
	rental_id,
	return_date
FROM
	rental
WHERE
	customer_id <> 1
AND customer_id <> 2;


SELECT customer_id
FROM rental
WHERE CAST (return_date AS DATE) = '2005-05-27'
ORDER BY customer_id;

customer_id|
-----------+
         37|
         47|
         48|
         65|
         73|
         75|
         93|
        114|
        119|
        131|
        158|
	
SELECT
	customer_id,
	first_name,
	last_name
FROM
	customer
WHERE
	customer_id IN (
		SELECT customer_id
		FROM rental
		WHERE CAST (return_date AS DATE) = '2005-05-27'
	)
ORDER BY customer_id;

customer_id|first_name|last_name  |
-----------+----------+-----------+
         37|Pamela    |Baker      |
         47|Frances   |Parker     |
         48|Ann       |Evans      |
         65|Rose      |Howard     |
         73|Beverly   |Brooks     |
         75|Tammy     |Sanders    |
         93|Phyllis   |Foster     |
        114|Grace     |Ellis      |
        119|Sherry    |Marshall   |
        131|Monica    |Hicks      |
```

--------------
# Chapter-7: PostgreSQL FETCH

```sql
SELECT
    film_id,
    title
FROM
    film
ORDER BY
    title 
FETCH FIRST ROW ONLY;

film_id|title           |
-------+----------------+
      1|Academy Dinosaur|
      
      
SELECT
    film_id,
    title
FROM
    film
ORDER BY
    title 
FETCH FIRST 1 ROW ONLY;

film_id|title           |
-------+----------------+
      1|Academy Dinosaur|
      
SELECT
    film_id,
    title
FROM
    film
ORDER BY
    title 
FETCH FIRST 5 ROW ONLY;

film_id|title           |
-------+----------------+
      1|Academy Dinosaur|
      2|Ace Goldfinger  |
      3|Adaptation Holes|
      4|Affair Prejudice|
      5|African Egg     |
      
SELECT
    film_id,
    title
FROM
    film
ORDER BY
    title 
OFFSET 5 ROWS 
FETCH FIRST 5 ROW ONLY; 

film_id|title           |
-------+----------------+
      6|Agent Truman    |
      7|Airplane Sierra |
      8|Airport Pollock |
      9|Alabama Devil   |
     10|Aladdin Calendar|
```


----------------------
# Chapter-6: PostgreSQL LIMIT

```sql
select film_id, title,release_year
from film
ORDER by film_id
LIMIT 5;

film_id|title           |release_year|
-------+----------------+------------+
      1|Academy Dinosaur|        2006|
      2|Ace Goldfinger  |        2006|
      3|Adaptation Holes|        2006|
      4|Affair Prejudice|        2006|
      5|African Egg     |        2006|
      
To retrieve 4 films starting from the fourth one ordered by film_id, you use both LIMIT and OFFSET clauses as follows:

select film_id, title, release_year
from film
ORDER by film_id
LIMIT 4 OFFSET 3;

film_id|title           |release_year|
-------+----------------+------------+
      4|Affair Prejudice|        2006|
      5|African Egg     |        2006|
      6|Agent Truman    |        2006|
      7|Airplane Sierra |        2006|
      
select
	film_id,
	title,
	rental_rate
from
	film
order by
	rental_rate desc
limit 10;

film_id|title              |rental_rate|
-------+-------------------+-----------+
     13|Ali Forever        |       4.99|
     20|Amelie Hellfighters|       4.99|
      7|Airplane Sierra    |       4.99|
     10|Aladdin Calendar   |       4.99|
      2|Ace Goldfinger     |       4.99|
      8|Airport Pollock    |       4.99|
     98|Bright Encounters  |       4.99|
    133|Chamber Italian    |       4.99|
    384|Grosse Wonderful   |       4.99|
     21|American Circus    |       4.99|

```

# Chapter-5: PostgreSQL WHERE

```sql
select last_name , first_name  
from customer c 
where first_name ='Jamie';

last_name|first_name|
---------+----------+
Rice     |Jamie     |
Waugh    |Jamie     |

select last_name , first_name  
from customer c 
where first_name ='Jamie' and last_name ='Rice';

last_name|first_name|
---------+----------+
Rice     |Jamie     |

select last_name , first_name  
from customer c 
where first_name ='Rodriguez' or last_name ='Adam';

last_name|first_name|
---------+----------+
Adam     |Nathaniel |


select first_name, last_name
from customer
WHERE first_name IN ('Ann','Anne','Annie');

first_name|last_name|
----------+---------+
Ann       |Evans    |
Anne      |Powell   |
Annie     |Russell  |


select first_name, last_name
from customer
WHERE first_name like 'Ann%';

first_name|last_name|
----------+---------+
Anna      |Hill     |
Ann       |Evans    |
Anne      |Powell   |
Annie     |Russell  |
Annette   |Olson    |


select first_name, length(last_name) name_length
from customer
WHERE first_name like 'A%'
and length(last_name) between 3 and 5
order by name_length;

first_name|name_length|
----------+-----------+
Audrey    |          3|
Alan      |          4|
Antonio   |          4|
Andre     |          4|
Anna      |          4|
Annette   |          5|
Andrew    |          5|
Adam      |          5|
Aaron     |          5|
Amy       |          5|
Adrian    |          5|
Ann       |          5|
Amber     |          5|
April     |          5|
Alicia    |          5|


select first_name, last_name , length(last_name) name_length
from customer
WHERE first_name like 'Bra%'
and last_name <> 'Motley';

first_name|last_name|name_length|
----------+---------+-----------+
Brandy    |Graves   |          6|
Brandon   |Huey     |          4|
Brad      |Mccurdy  |          7|

```


------------------------------
# Chapter-4: PostgreSQL SELECT DISTINCT

```sql
CREATE TABLE distinct_demo (
	id serial NOT NULL PRIMARY KEY,
	bcolor VARCHAR,
	fcolor VARCHAR
);

INSERT INTO distinct_demo (bcolor, fcolor)
VALUES
	('red', 'red'),
	('red', 'red'),
	('red', NULL),
	(NULL, 'red'),
	('red', 'green'),
	('red', 'blue'),
	('green', 'red'),
	('green', 'blue'),
	('green', 'green'),
	('blue', 'red'),
	('blue', 'green'),
	('blue', 'blue');
	
select distinct (bcolor)
from distinct_demo 
order by bcolor ;

select distinct (bcolor), fcolor 
from distinct_demo 
order by bcolor, fcolor  ;

bcolor|fcolor|
------+------+
blue  |blue  |
blue  |green |
blue  |red   |
green |blue  |
green |green |
green |red   |
red   |blue  |
red   |green |
red   |red   |
red   |      |
      |red   |
      
      
select DISTINCT ON (bcolor) bcolor, fcolor
from distinct_demo 
ORDER by bcolor, fcolor;

bcolor|fcolor|
------+------+
blue  |blue  |
green |blue  |
red   |blue  |
      |red   |
```


# Chapter-3 - PostgreSQL ORDER BY

```sql
select first_name, last_name from customer c order by first_name asc;

first_name |last_name  |
-----------+-----------+
Aaron      |Selby      |
Adam       |Gooch      |
Adrian     |Clary      |
Agnes      |Bishop     |
Alan       |Kahn       |
Albert     |Crouse     |
Alberto    |Henning    |
Alex       |Gresham    |
Alexander  |Fennell    |

select first_name, last_name 
from customer c 
order by first_name asc,
last_name desc;

first_name |last_name  |
-----------+-----------+
Aaron      |Selby      |
Adam       |Gooch      |
Adrian     |Clary      |
Agnes      |Bishop     |
Alan       |Kahn       |
Albert     |Crouse     |

Using PostgreSQL ORDER BY clause to sort rows by expressions

select first_name, LENGTH(first_name) len
from customer
order by len desc;

first_name |len|
-----------+---+
Christopher| 11|
Jacqueline | 10|
Constance  |  9|
Katherine  |  9|
Nathaniel  |  9|
Catherine  |  9|

PostgreSQL ORDER BY clause and NULL

-- create a new table
CREATE TABLE sort_demo(
	num INT
);

-- insert some data
INSERT INTO sort_demo(num)
VALUES(1),(2),(3),(null);

SELECT num
FROM sort_demo
ORDER BY num;

num|
---+
  1|
  2|
  3|
   |

SELECT num
FROM sort_demo
ORDER BY num NULLS LAST;

num|
---+
  1|
  2|
  3|
   |

```
---------------
# Chapter-2 - PostgreSQL Column Alias

```sql
select first_name, last_name as surname from customer c ;

Dorothy   |Taylor    |
Lisa      |Anderson  |
Nancy     |Thomas    |
Karen     |Jackson   |
Betty     |White     |
Helen     |Harris    |
Sandra    |Martin    |
Donna     |Thompson  |
Carol     |Garcia    |
Ruth      |Martinez  |
Sharon    |Robinson  |
Michelle  |Clark     |
Laura     |Rodriguez |
Sarah     |Lewis     |
Kimberly  |Lee       |
Deborah   |Walker    |
Jessica   |Hall      |
Shirley   |Allen     |


select first_name || ' ' || last_name AS full_name from customer c ;

full_name           |
--------------------+
Jared Ely           |
Mary Smith          |
Patricia Johnson    |
Linda Williams      |
Barbara Jones       |
Elizabeth Brown     |
Jennifer Davis      |
Maria Miller        |
Susan Wilson        |

select first_name || ' ' || last_name "full name" from customer c ;

full name         |
------------------+
Jared Ely         |
Mary Smith        |
Patricia Johnson  |
Linda Williams    |
Barbara Jones     |
Elizabeth Brown   |
Jennifer Davis    |
Maria Miller      |
Susan Wilson      |

```


--------------------
# Chapter-1

# Select 

```sql
select first_name, last_name, email, store_id from customer c ;

select first_name || ' ' || last_name, email from customer c ;
```
