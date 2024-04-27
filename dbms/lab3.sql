use lab2;
show tables;

select * from reserves;
select * from boats;


-- converting sid as primary key 

Alter table sailer 
add constraint primary key(sid);

-- checking 

insert into sailer(sid) value(22);

delete from sailer where sid=2;


-- foreigrn key

 
Alter table reserves add constraint 
foreign key(sid) references sailer(sid);

Alter table reserves 
add foreign key(bid) references boats(bid);


-- quaries 


select color from boats where bid=any(select bid from reserves where sid=64);
select color from boats where bid in(select bid from reserves where sid=64);
select color from boats where bid not in (select bid from reserves where sid=64);
select color from boats where bid not in (select bid from reserves where sid=31);

-- display color of the boat reserved by labber

select color from boats where bid in(select bid from reserves where sid in(select sid from sailer where sname="Lubber"));
select color from boats where bid in(select bid from reserves where sid in(select sid from sailer where sname="Labber"));

