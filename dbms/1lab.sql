create database student;
use student;
create table student_info(
sid char(10),
name varchar(50),
marks integer,
grade char);
insert into student_info values('B200402','vinay',99,'x');
insert into student_info
(sid,name,marks,grade)
values
('B200033','jayraj',100,'X'),
('B200300','SSVP',75,'B'),
('B200001','sai',50,'D'),
('B200002','swetha',80,'A'),
('B200999','megha',30,'R'),
('B200888','vijay',66,'C');
SELECT * FROM student_info;
select sid from student_info;
select max(marks) from student_info;
select sid,name from student_info where marks=100;
select sid,name from student_info order by marks desc limit 3; 
select count(sid) from student_info where grade='X';
select name from student_info where name like 's%';