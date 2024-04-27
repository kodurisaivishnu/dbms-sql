create database dbms2;
-- rename(dbms2,lab2);
show databases;
use dbms2;
show tables;

drop table salesPerson;

-- create table salesPerson(sid integer, sname varchar(50),age real,primary key(sid));  it is also a way
create table salesPerson(sid integer, sname varchar(50),age real);
alter table salesPerson
add constraint primary key(sid);
desc salesperson;

insert into salesPerson values
(10,"ramana",25),
(11,'raju',30),
(12,'vimala',28);
select * from salesPerson;


create table product(pid int,pname varchar(20),rating int,category varchar(20));
insert into product values
(101,'yippie',6	,'noodles'),
(111,'maggie',8 ,'noodles'),
(121,'Good day',8,'biscuits');
select * from product;
alter table product add constraint primary key(pid);
alter table product rename products;


create table sales(
sid integer,
pid integer,
day date,
foreign key(sid) references salesPerson(sid),
primary key(sid,pid,day),
foreign key(pid) references products(pid)
 );
 
 drop table sales;
 insert into sales
 values
(10,	121,	'2015/11/01'),
(10	,	111	,	'2015/11/01'),
(10	,	111	,	'2015/11/02'),
(11,	121,	'2015/11/03'),
(12,	121,	'2015/11/03');

select * from sales;
select year(day) sales from sales;
show tables;





-- practice sql Quarey



-- 1.Count the no. of each product sales by salesperson with name “ramana”

select sid from salesPerson where sname='ramana';
select pid,count(*) from sales where sid= (select sid from salesPerson where sname='ramana') group by pid ;

SELECT P.pname, COUNT(S.pid) as sales_count
FROM Salesperson SP
JOIN Sales S ON SP.sid = S.sid
JOIN Products P ON S.pid = P.pid
WHERE SP.sname = 'ramana'
GROUP BY P.pname;

-- 2.Find the no. of products which are not listed in sales relation

select distinct(pid) from  sales;
select pid,count(*) from products where pid not in(select distinct(pid) from  sales) group by pid ;

SELECT P.pname
FROM Products P
LEFT JOIN Sales S ON P.pid = S.pid
WHERE S.pid IS NULL;


-- 3.Find the name and age of the salespersons who have done sales of all different products

-- select pid from products;

-- select sname,age,p.pid from salesperson sp,sales s,products p where sp.sid=s.sid and s.pid=p.pid;


-- select count(*) from products;

select sname,age,s.sid,count(distinct(pid)) as pc from salesperson sp,sales s where sp.sid=s.sid group by s.sid having pc=3;

delete from sales where pid=101;
select * from sales;


-- 4.Display the product details which are better in rating than product named “yippie” in category “noodles”
select rating from products where  pname='yippie'and category='noodles';
select * from products where category='noodles' and  rating>(select rating from products where  pname='yippie');

-- 5.Find the name of salesperson who have done sales of both products “Maggie” and “Good day”

select sp.sid,sp.sname,count(*) as pc from salesperson sp,sales s,products p where sp.sid=s.sid and s.pid=p.pid and p.pname in('maggie','Good day') group by sp.sid having pc>=2;



-- again revice
-- 1

select sp.sname,count(pid) from salesperson sp,sales s where sp.sid=s.sid and  sname='ramana' group by sp.sname;
-- below is the reqired answer
select pid,count(*) from salesperson sp,sales s where sp.sid=s.sid and  sname='ramana' group by s.pid;
-- for more specific if we require the name,pid of product
select p.pname,p.pid,count(*) from products p,salesperson sp,sales s where sp.sid=s.sid and s.pid=p.pid and sp.sname='ramana' group by p.pid;

-- 2

-- observe left join
select * from products p left join sales s on p.pid=s.pid;

select * from sales s left join products p on p.pid=s.pid;

-- complete solution
select * from products p left join sales s on p.pid=s.pid where s.sid is null;


-- 3 who done sales of all different products





