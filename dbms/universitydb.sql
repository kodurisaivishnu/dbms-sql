mysql> create table student(id int primary key,name varchar(100),dept_name varchar(100),tot_cred int);
Query OK, 0 rows affected (0.02 sec)

mysql> desc student;
+-----------+--------------+------+-----+---------+-------+
| Field     | Type         | Null | Key | Default | Extra |
+-----------+--------------+------+-----+---------+-------+
| id        | int          | NO   | PRI | NULL    |       |
| name      | varchar(100) | YES  |     | NULL    |       |
| dept_name | varchar(100) | YES  |     | NULL    |       |
| tot_cred  | int          | YES  |     | NULL    |       |
+-----------+--------------+------+-----+---------+-------+
4 rows in set (0.00 sec)

mysql>insert into student values()





mysql> create table department(dept_name varchar(100) primary key,building varchar(10),budget double);
Query OK, 0 rows affected (0.03 sec)


mysql> insert into department values ('Physics','AB-I',100000),('Computer Science','AB-II',150000),('Maths','AB-III',80000);
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> select *from department;
+------------------+----------+--------+
| dept_name        | building | budget |
+------------------+----------+--------+
| Computer Science | AB-II    | 150000 |
| Maths            | AB-III   |  80000 |
| Physics          | AB-I     | 100000 |
+------------------+----------+--------+
3 rows in set (0.00 sec)



mysql> alter table student add constraint foreign key(dept_name) references department(dept_name);
Query OK, 3 rows affected (0.11 sec)
Records: 3  Duplicates: 0  Warnings: 0


mysql> create table course(course_id varchar(100) primary key,title varchar(100),dept_name varchar(100),credits int, foreign key(dept_name) references department(dept_name));
Query OK, 0 rows affected (0.07 sec);


create table instructor(id int primary key,name varchar(100),dept_name varchar(100),salary int,foreign key(dept_name) references department(dept_name));


insert into instructor values(22222,"Einstein","Physics",95000),
(33333,"Korth","Computer Science",75000),
(45454,"Mozart","Maths",60000),
(55555,"Navathe","Computer Science",100000);

create table section(course_id varchar(100),sec_id varchar(50),semester int,year varchar(20),building varchar(30),room_number int,primary key(course_id,sec_id,semester), foreign key(course_id) references course(course_id));

insert into section values
('CS-2201',	'CS-21'	,1,	'E2','AB-II',112),
('Ph-101','PUC-11',1,'P1','AB-I',	111),
('MA-201','CS-21',1,'E2','AB-II',112),
('CS-3201','CS-31',1,'E3','AB-II',101);

select * from section;


use university;
insert into course values
('CS-2201','DBMS','Computer Science',4),
('CS-3201','OS','Computer Science',4),
('MA-201','PS','Maths',3),
('Ph-101','Physics-1','Physics',3);



select * from department;

use university;
show tables;

drop table teaches;

create table teaches(id int ,course_id varchar(100),sec_id varchar(20),semester int, year varchar(10),
foreign key(course_id,sec_id,semester,year)
references section(course_id,sec_id,semester,year),
primary key(id,course_id,sec_id,semester,year)
);

create table teaches( id int, course_id varchar(7),sec_id varchar(7),semester int,year char(2),
foreign key (id) references instructor(id),
primary key(id,course_id,sec_id,semester,year));


alter table teaches
 add constraint foreign key(course_id,sec_id,semester,year)
 references section(course_id,sec_id,semester,year);
 
 select * from section;



















