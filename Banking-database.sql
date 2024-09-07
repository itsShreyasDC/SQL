create table customer
(custid number primary key, 
cfname varchar(10), 
clname varchar(10)); 
desc customer;

create table manager
(mid number primary key, 
mfname varchar(10), 
mlname varchar(10));
desc manager;

create table branch
(bid number primary key, 
bloc varchar(10), 
mid number references manager(mid) on delete cascade);
desc branch;

create table atype(type varchar(2) primary key);
desc atype;

create table account(aid number primary key,
 doo date, 
custid number references customer(custid) on delete cascade, 
bid number references branch(bid) on delete cascade, 
type varchar(2) references atype(type) on delete cascade); 
desc account;

create table transaction(tid number primary key, 
tdate date, 
amount int, 
aid number references account(aid) on delete cascade); 
desc transaction;

insert into customer values(10,'Nischal','H N');
insert into manager values(7,'john','Smith');
insert into atype values('RD');

select c.cfname, c.clname, a.aid, a.type, t.tdate, t.amount
from customer c, account a, transaction t
where c.custid=a.custid and t.aid=a.aid and t.amount<0;

select t.aid, (100000-SUM(t.amount))as Balance
from transaction t, account a
where a.aid=t.aid and a.type='SB'
group by t.aid order by t.aid;
