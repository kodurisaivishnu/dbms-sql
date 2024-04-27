show databases;

create database week2;
use week2;

create table student_info(slno int, sid char(10),name varchar(30),marks int, grade char);
desc student_info;

insert into student_info values(1,"B200402","vinay",99,'X');
insert into student_info values(2,"B200033",'jayraj',100,'X');
insert into student_info values(2,"B200300",'ssvp',75,'B');

-- mistakely given slno same to correct it
-- before we set off to safe mode
set sql_safe_updates=0;
update student_info set slno=3 where name='ssvp';

insert into student_info values(4,"B200001",'sai',50,'D');
insert into student_info 
	values
	(5,"B200002",'swetha',80,'A'),
	(6,"B200999",'megha',30,'R'),
	(7,"B200888",'vijay',66,'C');

select * from student_info;
show tables;

-- creating a view
create view vw_student_info as select sid,name,marks,grade,slno from student_info;
select * from vw_student_info;

-- creating another table using old table data
 create table student_info1 as select sid,name,slno,marks,grade from student_info;
 select * from student_info1;
 
 -- delete a record from student_info table
 insert into student_info value(8,"B20","xyz",0,'f');
 select * from student_info;
 delete from student_info where slno=8;
 select * from student_info;
 
 -- Alter table
 
 Alter table student_info
 add column remarks varchar(12);
 select * from student_info;
 
 -- Alter drop
 alter table student_info drop column remarks;
  alter table student_info drop remarks;
 select * from student_info;
 
 -- even slno
 select * from student_info where (slno%2)=0;
 
 -- odd slno
  select * from student_info where (slno%2)!=0;

 select count(name) from student_info;
 
 -- order by
 select sid from student_info order by sid desc;
 select marks from student_info order by sid;
 select marks from student_info order by marks;
 select * from student_info order by marks;
 
 select marks from student_info order by marks desc;
 select name,marks from student_info order by marks desc;
 
 -- limit
 -- top 2
 select name,marks from student_info order by marks desc limit 2;
 select name,marks from student_info order by marks desc limit 20;
 
 
 desc student_info;
 
 -- insert and delete
 
 insert into student_info value(8,"qwm",'qm',9,'Q');
select * from student_info;
 delete from student_info where marks=9;
 
 -- observe (clarity visit week 2 html file)
 insert into student_info value(1,"B200402",'vinay',99,'X');
 delete from student_info where slno=1;
 select * from student_info;
 insert into student_info value(1,"B200402","vinay",99,'X');
 
 -- create view
 create view new_view as select slno,sid,name,marks,grade from student_info order by slno;
 select * from new_view;
 
 -- creating a new table from old table
 create table student_info2 as select slno,sid,name,marks,grade from new_view;
 select * from student_info2;
 
-- drop
 drop table student_info2;
 
 -- create an new table from view
 CREATE TABLE student_info2 as select slno,sid,name,marks,grade from new_view;
 select * from student_info2;
 drop table student_info2;
 
 
 CREATE TABLE student_info2 as select slno,sid,name,marks,grade from new_view order by slno;
 select * from student_info2;
 
select * from student_info1;
select * from student_info;

CREATE TABLE student_info as select slno,sid,name,marks,grade from student_info2;



															-- SOME QUERIES
 
 
 select * from student_info where name like "%s%";
 select * from student_info where name like "s%";
 select * from student_info where name like "%s";