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
