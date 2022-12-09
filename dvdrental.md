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
