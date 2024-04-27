create database gs;

use gs;

create table emp(eno int,ename varchar(6),addr varchar(10));
insert into emp values
(1,"ram","delhi"),
(2,"varun","chd"),
(3,"ravi","chd"),
(4,"amrit","delhi");

select * from emp;

alter table emp
add constraint primary key(eno);


create table dept(dname varchar(10),name varchar(10),eno int);

insert into dept
values
("d1",'hr',1),
('d2','it',2),
('d3','mrkt',4);

select * from emp left outer join dept on(emp.eno=dept.eno) union
select * from emp right outer join dept on(emp.eno=dept.eno);

alter table dept
add constraint foreign key(eno) references emp(eno);


update dept
set eno=3 where name='mrkt' ;

set sql_safe_updates =0;

-- lec40


create table study40(sid varchar(2),cid varchar(2),since int);

insert into study40
values
('s1','c1',2016),
('s2','c2',2017),
('s1','c2',2017);

-- get sid who is enrolled in atleast two courses
select sid,count(*) from study40 group by sid having count(*)>=2;

 -- using self join
 -- observe
 select * from study40 as t1,study40 as t2;
 
 -- now
 select * from study40 t1,study40 t2 where t1.sid=t2.sid and t1.cid<>t2.cid;
 
 
 -- find the emp name who worked ina a dept having same location as their address
 
 

