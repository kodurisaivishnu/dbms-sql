use sailorsext;

-- 1
select sname from sailor where sname like 'j%'; 

-- 2
select * from sailor s, reserves r,marinas m where s.sid=r.sid and r.mid=m.mid and rating in(select min(rating) from sailor);

-- 3
select * from sailor s, reserves r, boats b where s.sid=r.sid and b.bid=r.bid and sname<>'john' and color in(select color from sailor s, reserves r , boats b where s.sid=r.sid and r.bid=b.bid and sname='john') order by sname;

-- 4
select sname,count(*) bcount from sailor s,reserves r where s.sid=r.sid group by sname having bcount>1;

-- 5
select location,count(*) from marinas group by location having count(*)>2;

-- 6
select bname,count(sid) r_count from boats b, reserves r where b.bid=r.bid group by bname having r_count>1;

-- 7
select mname,avg(age) from marinas m,reserves r,sailor s where s.sid=r.sid and r.mid=m.mid group by mname;

-- 8
select * from boats where color in (select color from boats group by color having count(*)>1) ;

select * from reserves;
-- 9
select distinct sname from sailor s, reserves r where s.sid=r.sid and rating>=8 or s.sid in(select sid from reserves where bid='b204');

select sid from sailor where rating>=8;
select sid from reserves where bid='b204';

select sname from sailor where sid in(select sid from sailor where rating>=8) or sid in(select sid from reserves where bid='b204');

-- 10

select sname,count(*) from sailor s, reserves r, boats b where s.sid=r.sid and b.bid=r.bid  and bname like 'Sea%' group by sname having count(*)=(select count(*) from boats where bname like 'Sea%');




-- 11
select sname,count(*) no_of_reservations from sailor s, reserves r where s.sid=r.sid group by sname;

-- 12
select bname from boats where bid not in(select distinct bid from reserves);

-- 13
select * from sailor s,reserves r, boats b where s.sid=r.sid and b.bid=r.bid and color<>'blue';

-- 14
select * from sailor s,boats b,reserves r, marinas m where r.mid=m.mid and r.bid=b.bid and s.sid=r.sid and mname='Cove Haven' and age>26;

-- 15
select sname,rating from sailor where sid in(select sid from reserves group by sid having count(*)>=2);

-- 16
select bid from reserves r, sailor s where s.sid=r.sid and age>=20 group by bid having count(*)>=2;

-- more specific solution
select  distinct bid from reserves r,sailor s where r.sid=s.sid and  bid in(select bid from reserves group by bid having count(*)>=2) and age>=20;

-- 17
 select sname from sailor where sid in(select sid from reserves where bid in(select bid from boats where color in(select color from boats b,reserves r where b.bid=r.bid group by color having count(*)<2))) order by sname;
 
 select * from sailor s,reserves r where s.sid=r.sid and bid in(select b.bid from boats b, reserves r where r.bid=b.bid group by b.bid having count(*)=1) order by(sname);
-- 18
select sname from sailor where sid in(select sid from reserves where mid in(select mid from marinas where mname='Lakeview'));


show tables;
