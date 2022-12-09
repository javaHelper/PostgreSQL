


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


```


--------------------
# Chapter-1

# Select 

```sql
select first_name, last_name, email, store_id from customer c ;

select first_name || ' ' || last_name, email from customer c ;
```
