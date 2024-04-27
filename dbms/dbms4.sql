create database dbms4;
use dbms4;

create table faculty
(
	fid int,
    fname varchar(20),
    qualification varchar(20),
	age real,
    primary key(fid)
);

insert into faculty
values
(10	,'kavitha',	'M.Tech',	32),
(11	,'vanitha','M.C.A',29),
(12	,'venu','M.Tech',33);
select * from faculty;


create table course(cid varchar(100), cname varchar(100), textbook varchar(100));
alter table course 
add constraint primary key(cid);


insert into course
values
('CS201',	'DBMS',	'Database concepts'),
('CS301'	,'COA',	'Computer architecture'),
('CS401',	'JAVA',	'Complete reference JAVA'),
('CS302',	'FLAT',	'Formal languages');

drop table teaches;
create table teaches(
fid int, 
cid varchar(20), 
year_sem varchar(20),
foreign key(fid) references faculty(fid),
foreign key(cid) references course(cid)
);

insert into teaches 
values
(10,	'CS201'	,'2_1'),
(10,	'CS301'	,'3-1'),
(12,	'CS401'	,'4-1'),
(11,	'CS301'	,'3-1'),
(11,	'CS302'	,'3-1');


-- some examples Query's

-- 1.Find faculty names whose qualification is “M.Tech” and teaches at least two different courses
select * from faculty f, teaches t where t.fid=f.fid and qualification='M.Tech';

select fname,count(cid) as No_of_courses_teach  from faculty f, teaches t where t.fid=f.fid and qualification='M.Tech' group by fname having No_of_courses_teach>=2;

-- 2.Find faculty names whose age is below 30 and teaches all the courses

select fname from faculty where age<30;

select *
from faculty f, teaches t,course c 
where c.cid=t.cid and t.fid=f.fid and age<30 ;

-- complete solution

select fname, count(t.cid) as course_teach
from faculty f, teaches t,course c 
where c.cid=t.cid and t.fid=f.fid and age<30 
group by fname having course_teach>(select count(*) from course);


-- 3.Find course name and textbooks of the courses taught by either “kavitha” or “venu”

-- complete solution 1

select cname,textbook 
from course c,teaches t,faculty f
where c.cid=t.cid and t.fid=f.fid and fname='kavitha'
union
select cname,textbook 
from course c,teaches t,faculty f
where c.cid=t.cid and t.fid=f.fid and fname='venu';


-- complete solution 2

select cname,textbook 
from course c,teaches t,faculty f
where c.cid=t.cid and t.fid=f.fid and fname in ('kavitha','venu');


-- 4.Count the no. of courses for each “year-sem” 

select year_sem,count(cid) from teaches group by year_sem;

-- 5.Alter the table courses to add a new attribute “credits” and update the credits to 4 for the courses taught by faculty with fid 10 

alter table course
add column credits int;

set sql_safe_updates=0;

update course
set credits=4 where cid in (select cid from teaches where fid=10);
select * from course;



