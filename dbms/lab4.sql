use lab2;
-- print all table
select * from sailer;

-- display names of sailer with rating above 7
select sname from sailer where rating>7;

-- display names of sailer with rating above 7 and age <50
select sname from sailer where rating>7 and age<50;

-- display sid and sname from sailer where age is b/w 30 and 50
select sid,sname from sailer where age between 30 and 50;

-- display sid and sname from sailer names starting with s
select sid from sailer where sname like "s%";

-- select sid and name of sailer ehere name starts with B and having length 3
select sid,sname from sailer where sname like"B%" and length(sname)=3;

-- select names of the sailer in order by rating
-- Ascending order
select sname,rating from sailer order by rating asc;
-- Descending order
select sname,rating from sailer order by rating desc;

-- display count of sailer
select count(*) from sailer;

-- Display color of boats
select color from boats;

-- Display highest rating of sailers
select max(rating) from sailer;

-- Dispaly avg age of sailer
select avg(age) from sailer;

-- Display name of sailer with highest rating
select sname from sailer where rating=(select max(rating) from sailer);

-- display name and rating of youngest sailer
select sname,age,rating from sailer where age=(select min(age) from sailer);

-- display name of sailers who have rating better than that of some sailers called hotatio
select sname from sailer where rating>(select min(rating) from sailer where sname="Horatio");

-- display names of sailers who have rating better than that of all sailers called horatio
select sname from sailer where rating>(select max(rating) from sailer where sname="Horatio");

-- display name of  sailer who is older than the oldest sailers with rating 10
select sname from sailer where rating=10 and age=(select max(age) from sailer where rating=10);


-- display the count boats reserved by each sailer 
select sid,count(bid) from reserves group by sid;

-- 18 display count of boats for each color
select color,count(r.bid) from reserves r,boats b where b.bid=r.bid group by color;

-- combines information from 3 tables
select * from sailer s,reserves r,boats b where s.sid=r.sid and r.bid=b.bid;

-- group by

select count(*) from reserves;
-- number of sailer who reserved boat
select count(*) from reserves group by sid;
select sid,count(*) from reserves group by sid;
select bid,count(*) from reserves group by bid;
select day,count(*) from reserves group by day;
select rating,avg(age) from sailer group by rating;
select rating,count(*),avg(age) from sailer group by rating;

-- who have reseved at least one boat
select sname from sailer where sid in(select sid from reserves);

select * from sailer,reserves;
select * from reserves,boats;
select * from sailer,reserves,boats;
select * from sailer s,reserves r where s.sid=r.sid;
select sid,sname from sailer where sid in(select sid from reserves);

-- disp id and name of sailer who have reserved at least 1 boats 
select s.sid,s.sname,bid from sailer s,reserves r where s.sid=r.sid;
select sid ,sname from sailer where sid in(select sid from reserves);

-- 19 display the id of the sailer who have reserved max number of boats
select sname from sailer where sid in(select sid from reserves group by sid having count(bid)=(select count(*) from boats));
                                                
-- 20 display id of the sailer who have reserved boat no 103
select sid from reserves where bid=103;

-- 21 display name of the sailer who have reserved boat no 103
select sname from sailer where sid in(select sid from reserves where bid=103);

-- 22 id's of sailer who reserved red boat
select distinct(sid) from reserves where bid in(select bid from boats where color="Red");

-- 23 name of sailer who reserved at least 1 boat
select sname,sid from sailer where sid in(select sid from reserves);

-- 24 name of sailer who have not reserved at least 1 boat
select sname,sid from sailer where sid not in(select sid from reserves);

-- 25 names of the sailer who have reserved red boat
select sname from sailer where sid in(select sid from reserves where bid in(select bid from boats where color="Red"));

-- 26 name of the sailer who have reserved at least 2 boats
select sname from sailer where sid in(select sid from reserves group by sid having count(bid)>=2) ;

-- 27 name of the saailer who have reserved all boats
select sname from sailer where sid in(select sid from reserves group by sid having count(bid)=(select count(*) from boats));

-- exactly two boats
select sname from sailer where sid in(select sid from reserves group by sid having count(bid)=2) ;


--  28 name of the sailer who reserved either red or green boats
select sname from sailer where sid in(select sid from reserves where bid in(select bid from boats where color="Red" or color="Green"));

-- 29 names of the sailer who have reserved both red and green

select sname from sailer where sid in(select sid from reserves where bid in(select bid from boats where color="Red" and color="Green"));

 
 select bid from boats where color="Red" and color="Green";
 
 select sid from reserves where bid in(select bid from boats where color="Red") and bid In(select bid from boats where color ="Green");
 
 select sid from reserves where bid in(select bid from boats where color="Red");
 select sid from reserves where bid in(select bid from boats where color="Green");
 
 select sname from sailer where sid in(select sid from reserves where bid in(select bid from boats where color="Red")) and sid in(select sid from reserves where bid in(select bid from boats where color="Green"));
   
																					select sid,sname from sailer where sid in(select sid from reserves where bid in(select bid from boats where color="Red") intersect (select sid from reserves where bid In(select bid from boats where color ="Green")));
 
  select sname from sailer where sid in(select sid from reserves where bid in(select bid from boats where color="Red")) and sid not in(select sid from reserves where bid in(select bid from boats where color="Green"));

 
 select sid,sname from sailer where sid in (select sid from reserves where bid in (select bid from boats where color ="Red")) 
 Except sid in(select sid from reserves where bid in (select bid from boats where color="Green"));
 
 
 
 
 
SELECT s.sname
FROM sailer s
JOIN reserves r ON s.sid = r.sid
JOIN boats b ON r.bid = b.bid
WHERE b.color IN ('Red', 'Green')
GROUP BY s.sid, s.sname
HAVING COUNT(DISTINCT b.color) = 2;


select sid from reserves where bid=102 and bid=104;

-- 30 name of the sailer who have reserved only red boats but not green boats

select * from sailer s,reserves r, boats b where s.sid=r.sid and b.bid=r.bid and color<>'Green';

 select sid,sname from sailer where sid in (select sid from reserves where bid in (select bid from boats where color ="Red")) 
 Except sid in(select sid from reserves where bid in (select bid from boats where color="Green"));
 
 

-- 31 names of the sailer with age below 50 and have reserved green colored boats
SELECT sname,sid from sailer where age<50 and sid in(select sid from reserves where bid in(select bid from boats where color="Green"));

-- 32 dispaly all cobinations of sailer and reserves
select * from sailer,reserves;

-- 33 display name of the sailer and  date on which  sailer has reserved the boats for all sailers
select s.sname,r.day from sailer s,reserves r where s.sid=r.sid;

-- 34 dispaly name of sailers and day on which he has reserved the boat for boat no 103
select s.sname,r.day from sailer s,reserves r where r.bid=103  and r.sid=s.sid;

select sname from sailer where sid in(select sid)

-- mam
select sname from sailer s where sid in (select sid from reserves where bid=103);



























-- corealated queary
select sname from sailer s where Exists (select * from reserves r where bid=103 and s.sid=r.sid);


********** except
















select * from sailer,reserves;

select * from sailer s,reserves r,boats b where s.sid=r.sid and r.bid=b.bid;



-- having is written with group by
-- dispaly no of sailer for each rating level

select rating,count(age)  from sailer group by rating;

-- dispaly rating for which the no of sailer =1
select rating,count(age)  from sailer group by rating having count(*)=1;



-- 25 name of sailer who have resered at least 2 boats
select sname from sailer where sid in(select sid from reserves group by sid having count(bid)>=2) ;

-- NAME OF SAILER WHO HAVE RESERVED ALL BOATS
select sname from sailer where sid in(select sid from reserves group by sid having count(bid)=(select count(*) from boats));






-- self cross product

select s.sname,s.sid from sailer s,reserves r1,reserves r2 where s.sid=r1.sid and r1.sid=r2.sid and r1.bid!=r2.bid;




-- who have reserved 1 boat
select sname from sailer s where exists (select * from reserves r where s.sid=r.sid);

-- not reserved 1 boat using exits
select sname from sailer s where not exists (select * from reserves r where s.sid=r.sid);


-- to rename table

alter table name
rename sailer;

-- to rename column

alter table sailer 
rename column sname to name;

alter table sailer rename column name to sname;



select * from sailer;

select count(*) from reserves;


