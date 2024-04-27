create database lab2;
use lab2;
show databases;

show tables;

-- #1

-- to create a table
create table sailer(sid int,sname varchar(40),rating tinyint,age real);

-- to describe the table
 desc sailer;
 
 -- inserting values to the table(sailer)
 insert into sailer values(22,"Dustin",7,45.0);
 insert into sailer values(29,"Brutus",1,33),(31,"Lubber",8,55.5);
 insert into sailer values(32,"Andy",8,25.5),(58,"Rusty",10,35),(64,"Horatio",7,35),(71,"Zorba",10,16),(74,"Horatio",9,40),(85,"Art",3,25.5),(95,"bob",3,63.5);
 
 -- to see values in sailer
 select * from sailer;
 
 #2
 
  create table reserves(sid int,bid int, day date);
  desc reserves;
  
  -- inserting values
  insert into reserves value(22,101,'1998-10-10');
  insert into reserves value(22,102,'1998-10-10');
  insert into reserves value(22,103,'1998-10-08'),(22,104,'1998-10-07'),(31,102,'1998-11-10'),(31,103,'1998-11-06'),(31,104,'1998-11-12'),(64,101,'1998-09-05');
  insert into reserves value(64,102,'1998-09-08'),(74,103,'1998-09-08');
  
  
  -- some QUARIES
  
  -- 1) to extract month from the day(dob)
  select month(day) from reserves;
  
  
  --  for all values
  select * from reserves;
  
  -- #3
  
  create table boats(bid int,bname varchar(30),color varchar(10));
  desc boats;
  
  -- inserting values
  
  insert into boats values(101,"Interlake","Blue"),(102,"Interlake","Red"),(103,"Clipper","Green"),(104,"Marin","Red");
  
  -- for all values
  select * from boats;
  
  --        				 ----------------------------------->     some QUARIES to do        ksv<----------------------------
  
  -- 1) display names of sailers
  select sname from sailer;
  
  --  2)display count of sailers 
  select count(sname) from sailer;
  select count(*) from sailer;
  
  select color from boats;
  
  
  -- 3) display age>40
  select age from sailer where age>40;
  
  
  -- 4)
  select color from boats where bname="Interlake";
  
  -- 5)
  select sname,sid from sailer where rating=8;
  
  -- 6)select boat id  from sailer has reserved by sid 22
  select bid from reserves where sid=22;
  
  -- 7)
  select count(sid) from sailer where rating=3;
  
  -- 8) using order by and limit
  select sname from sailer;
  select sname from sailer order by age;
  select sname,age from sailer order by age;
  select sname,age from sailer order by age asc;
  select sname,age from sailer order by age desc;
  
  select sname,age from sailer order by age desc limit 3;
  
  --  view all tables
  
  select * from sailer;
  select * from boats;
  select * from reserves;
  
  
  -- 9)
  
  select sid from reserves where bid =(select bid from boats where color="Red" limit 1);
  select bid from boats where color="Red" limit 1;
  
  select bid from boats where color="Red";
  select sid from reserves where bid in(select bid from boats where color="Red");
  
  

-- exists

mysql> select * from sailer s where exists(select * from reserves where s.sid=sid);
+-----+---------+--------+------+---------+
| sid | sname   | rating | age  | address |
+-----+---------+--------+------+---------+
|  22 | Dustin  |      7 |   45 | houton  |
|  31 | Lubber  |      8 | 55.5 | NULL    |
|  64 | Horatio |      7 |   35 | NULL    |
|  74 | Horatio |      9 |   40 | NULL    |
+-----+---------+--------+------+---------+
4 rows in set (0.00 sec)

mysql> select * from sailer s where not exists(select * from reserves where s.sid=sid);
+-----+--------+--------+------+---------+
| sid | sname  | rating | age  | address |
+-----+--------+--------+------+---------+
|  29 | Brutus |      1 |   33 | NULL    |
|  32 | Andy   |      8 | 25.5 | NULL    |
|  58 | Rusty  |     10 |   35 | NULL    |
|  71 | Zorba  |     10 |   16 | NULL    |
|  85 | Art    |      3 | 25.5 | NULL    |
|  95 | bob    |      3 | 63.5 | NULL    |
+-----+--------+--------+------+---------+
6 rows in set (0.00 sec)


-- names of boats reserved by all sailers

mysql> select bname from boats b where not exists((select sid from sailer) except(select sid from reserves where b.bid=bid));
Empty set (0.00 sec)

-- names of sailers who have reserves all red boats;

mysql> select sname from sailer s where not exists ((select bid from boats where color='red') except(select bid from reserves where sid=s.sid));
+--------+
| sname  |
+--------+
| Dustin |
| Lubber |
+--------+
2 rows in set (0.00 sec)

-- name of sailer who reerved all boats

mysql> select sname from sailer s where not exists ((select bid from boats) except(select bid from reserves where sid=s.sid));
+--------+
| sname  |
+--------+
| Dustin |
+--------+
1 row in set (0.00 sec)




-- all sid reserves correseponding boats

mysql> select s.sid,count(bid) from sailer s left join reserves r on s.sid=r.sid group by sid;
+-----+------------+
| sid | count(bid) |
+-----+------------+
|  22 |          4 |
|  29 |          0 |
|  31 |          3 |
|  32 |          0 |
|  58 |          0 |
|  64 |          2 |
|  71 |          0 |
|  74 |          1 |
|  85 |          0 |
|  95 |          0 |
+-----+------------+
10 rows in set (0.01 sec)



mysql> select max(t.c) from (select sid s,count(bid) c from reserves group by sid ) as t;
+----------+
| max(t.c) |
+----------+
|        4 |
+----------+
1 row in set (0.00 sec)

mysql> select sid,count(bid) from reserves group by sid having count(bid)=(select max(t.c) from (select sid s,count(bid) c from reserves group by sid ) as t);
+------+------------+
| sid  | count(bid) |
+------+------------+
|   22 |          4 |
+------+------------+
1 row in set (0.00 sec)