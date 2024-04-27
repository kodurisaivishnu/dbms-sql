use dbms;
-- 1
select * from employee;
select Bdate from employee where Fname='John' and Mname='B' and Lname="Smith";



-- 2   Retrieve the name and address of all employees who work for the ‘Research’ department
select * from department;
select Dnumber from department where Dname='Research';
select Fname,Mname,Lname from employee where Dno in(select Dnumber from department where Dname='Research');
select concat(Fname," ",Mname," ",Lname),Address from employee where Dno in(select Dnumber from department where Dname='Research');

SELECT Fname, Lname, Address
FROM employee, department
WHERE Dname='Research' AND Dnumber = Dno;



-- 3 For every project located in ‘Stafford’, list the project number, the controlling department number,
-- and the department manager’s last name, address, and birth date.

select * from project;
select Dnum from project where Plocation='Stafford';

select P.Pnumber,P.Dnum,e.Lname,e.Address,e.Bdate from project p,employee e,department d where  p.Dnum=d.Dnumber and d.Mgr_ssn=e.Ssn and Plocation='Stafford';

SELECT Pnumber, Dnum, Lname, Address, Bdate
FROM project, department, employee
WHERE Dnum = Dnumber AND Mgr_ssn = Ssn AND 
Plocation = 'Stafford';


-- 4. For each employee, retrieve the employee’s first and last name and the first and last name of his or her immediate supervisor.
select e1.Ssn,e1.Super_ssn,e2.Ssn,e2.Super_ssn from employee e1,employee e2 where e1.Ssn=e2.Super_ssn;

-- select e1.Ssn,e1.Super_ssn,e2.Ssn,e2.Super_ssn from employee e1,employee e2;


-- 5.Query: Write a query which is retrieves all the attribute values of any EMPLOYE who works in DEPARTMENT number 5
select e.* from employee e where e.Dno=5;

-- 6.Query: write a query which is retrieves all the attributes of an EMPLOYEE and attributes of the DEPARTMENT in which he or she works for research department (every employee )of the ‘Research’ department.

select e.* from employee e,department d where e.Dno=d.Dnumber and d.Dname='Research';

-- 7.Query: write a query which is specifies the CROSS PRODUCT of the EMPLOYEE and DEPARTMENT relations.
select * from employee,department;

--  8. & 9      Query: Select all EMPLOYEE  Ssns in the database.
select Ssn from employee;

-- 10.Retrieve the salary of every employee .
select salary from employee;

-- 11.Query: Retrieve the all distinct salary value.
select distinct(salary) from employee;

-- 12.Make a list of all project numbers for projects that involve an employee whose last name is ‘Smith’, either as a worker 
-- or as a manager of the department that controls the project.

-- who is Manager
select Pnumber from project,employee,department where Lname='Smith' and  Dnum=Dnumber and Mgr_ssn=Ssn;
--  who is worker
select Pnumber from employee,works_on,project where Lname='Smith' and Pnumber=Pno and Essn=Ssn;

-- Complete Solution																				****************************8********************8 imp 
(select Pnumber from project,employee,department where Lname='Smith' and  Dnum=Dnumber and Mgr_ssn=Ssn)
union
(select Pnumber from employee,works_on,project where Lname='Smith' and Pnumber=Pno and Essn=Ssn);

-- 13.Query: Retrieve all employees whose address is in Houston, Texas(TX). 
select Fname,Lname from employee where address like  '%Houston,TX';

-- 14.Query: Find all employees who were born during the 1950s.
select * from employee where year(Bdate)>1950;

-- 15.Query: Show the resulting salaries if every employee working on the ‘ProductX’ project is given a 10 percent raise.
select Fname,Lname,0.1*salary+salary as increased_sal from employee,works_on,project where Pname='ProductX' and Pnumber=Pno and Essn=SSn;

SELECT E.Fname, E.Lname, 1.1 * E.Salary AS Increased_sal
FROM EMPLOYEE AS E, WORKS_ON AS W, PROJECT AS P
WHERE E.Ssn = W.Essn AND W.Pno = P.Pnumber AND 
P.Pname = 'ProductX';

-- 16.Query: Retrieve all employees in department 5 whose salary is between $30,000 and $40,000. 
select * from employee where Dno=5 and (salary between 30000 and 40000);

-- 17.Retrieve a list of employees and the projects they are working on, ordered by department and within each department, ordered alphabetically by last name, then first name. 
select d.dname,e.Lname,e.Fname,p.Pname from department d,employee e,works_on w,project p where d.Dnumber=e.Dno and e.Ssn=w.Essn and w.pno=p.Pnumber order by d.Dname,Lname,Fname;

select * from department;

SELECT D.Dname, E.Lname, E.Fname, P.Pname
FROM DEPARTMENT AS D, EMPLOYEE AS E, WORKS_ON AS W, 
PROJECT AS P
WHERE D.Dnumber = E.Dno AND E.Ssn = W.Essn AND W.Pno = 
P.Pnumber
ORDER BY D.Dname, E.Lname, E.Fname;

-- 18: Retrieve the name of all employees who do not have supervisors.
select * from employee where Super_ssn is null;

-- 19.Query: Retrieve the name of each employee who has a dependent with the same first name and is the same sex as the employee.
select e.Fname,e.Lname from employee e, dependent d where e.Ssn=d.Essn and e.Sex=d.Sex and e.Fname=d.Dependent_name;

SELECT E.Fname, E.Lname
FROM EMPLOYEE AS E, DEPENDENT AS D
WHERE E.Ssn = D.Essn AND E.Sex = D.Sex
 AND E.Fname = D.Dependent_name;
 
 
 SELECT E.Fname, E.Lname
FROM EMPLOYEE AS E
WHERE E.Ssn IN ( SELECT D.Essn
 FROM DEPENDENT AS D
 WHERE E.Fname = D.Dependent_name
 AND E.Sex = D.Sex );
 
 
 -- 20.Query: write a query which is retrieve In general, a query written with nested select-from-where blocks and using the = or IN comparison operators can always be expressed as a single block query.

select E.Fname,E.Lname from employee E where E.Ssn in(select d.Essn from dependent d where E.Fname-d.Dependent_name and E.sex=d.sex);


-- 21.Retrieve the names of employee who have no dependents. 

select e.Fname,e.Lname from employee e , dependent d where e.ssn not in( select d.Essn  where.Ssn=d.Essn);

SELECT Fname, Lname
FROM EMPLOYEE
WHERE NOT EXISTS ( SELECT *
 FROM DEPENDENT
 WHERE Ssn = Essn );
 
 -- my solution
 
 select distinct(Essn) from dependent;
 select Fname,Lname from employee where Ssn not in(select distinct(Essn) from dependent);



-- 22 List the name of managers who have at least one dependent.
select distinct(concat(e.Fname," ",e.Lname)) from employee e,department d, dependent dt where d.Mgr_Ssn=e.Super_Ssn and d.mgr_ssn=dt.Essn;

select * from dependent;

SELECT Fname, Lname
FROM EMPLOYEE
WHERE EXISTS ( SELECT *
 FROM DEPENDENT
 WHERE Ssn = Essn )
 AND
 EXISTS ( SELECT *
 FROM DEPARTMENT
 WHERE Ssn = Mgr_ssn );
 
 -- 23.Query: Retrieve the Social Security numbers(ssn) of all employee who work on project numbers 1, 2, or 3.          *************************
 
 select * from employee e,Works_on w where e.Ssn=w.Essn and Pno in(1,2,3);
 
 -- 24.Query: Find the sum of the salaries of all employees, the maximum salary, the minimum salary, and the average salary.
 
select sum(Salary) from employee;
select max(Salary) from employee;
select min(Salary) from employee;
select avg(salary) from employee;

-- 25.Query: Find the sum of the salaries of all employees of the ‘Research’ department, as well as the maximum salary, the minimum salary, and the average salary in this department.
select sum(Salary) ,max(Salary),min(Salary),avg(Salary) from employee e,department d where d.Dnumber=e.Dno and d.Dname='Research';

-- 26. Retrieve the total number of employees in the company.
select count(*) from employee;
 
 
 -- 27. Retrieve the total number of employees in the company and the number of employees in the ‘Research’ department.
 
--  select count(t1.*) as t1,count (e.*) from employee e,(select ) as t1;
 select  count(distinct(Ssn)),count(*) from employee,department where dname= 'Research';
 select count(distinct(Ssn)),count(t1.Ksv) from (select Dno as ksv from employee where Dno=5) as t1,employee e ;
 
 -- alternate solution
 
 select count(*) from employee;
 select count(*) from employee e,department d where e.Dno=d.Dnumber and Dname='Research';
 
 
 -- 28 Query: Count the number of distinct salary value in the database.
 select count(distinct(Salary)) from employee;
 
 -- 29.Query: For each department, retrieve the department number, the number of employees in the department, and their average salary.
 
 select Dno,count(*),avg(Salary) from department d,employee e where e.Dno=d.Dnumber group by Dno;
 
 -- 30.Query: For each project, retrieve the project number, the project name, and the number of employees who work on that project.
 -- select distinct(concat(Pno," ",Pname)), from project p,works_on  w where p.Pnumber=w.Pno group by Pno;
 select Pno,Pname,count(*) from project p, works_on w where  p.Pnumber=w.Pno group by Pno;
 
 -- 31.Query:  For each project on which more than two employees work, retrieve the project number, the project name, and the number of employees who work on the project.
 
 select Pno,Pname,count(*) from project p, works_on w where p.Pnumber=w.Pno group by Pno having count(*)>2;
 
 
-- 32.Query:  For each project, retrieve the project number, the project name, and the number of employees from department 5 who work on the project.
select Pno,Pname,count(*) from works_on w,department d,project p where P.Pnumber=W.Pno and p.Dnum=d.Dnumber and Dnum=5 group by Pno;

-- doubt

select * from works_on w,department d,project p where P.Pnumber=W.Pno and p.Dnum=d.Dnumber;  
 
 select * from works_on w,project p,department d where P.Pnumber=w.Pno and p.dnum=d.Dnumber;
 
 
 
 -- 33.Query: For each department that has more than five employees, retrieve the department number and the number of its employees who are making more than $40,000.
 
 select Dno,count(*) from department d ,employee e where e.Dno=d.Dnumber group by Dno;
 
 select Dno,count(*) from department d ,employee e where e.Dno=d.Dnumber group by Dno having count(*)>5;
 







-- queation 33 and   


mysql> use dbms;
Database changed
mysql> select dno,count(ssn) from employee group by dno;
+-----+------------+
| dno | count(ssn) |
+-----+------------+
|   1 |          1 |
|   4 |          3 |
|   5 |          4 |
+-----+------------+
3 rows in set (0.03 sec)

mysql> select dno,count(ssn) from employee where salary>40000 group by dno;
+-----+------------+
| dno | count(ssn) |
+-----+------------+
|   1 |          1 |
|   4 |          1 |
+-----+------------+
2 rows in set (0.01 sec)

mysql> select dno,count(ssn) from employee where salary>40000 and dno in (select dno from employee group by dno having count(ssn)>3) group by dno;
Empty set (0.01 sec)

-- final ans
mysql> select dno,count(ssn) from employee where salary>40000 and dno in (select dno from employee group by dno having count(ssn)>=3) group by dno;
+-----+------------+
| dno | count(ssn) |
+-----+------------+
|   4 |          1 |
+-----+------------+
1 row in set (0.00 sec)

mysql>