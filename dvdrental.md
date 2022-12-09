

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
