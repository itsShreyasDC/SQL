create table department
(dno number(2) primary key,
dname varchar(4));

create table branch
(bcode number(3) primary key,
bname varchar(4),
dno number(2) references department(dno));

create table course
(ccode number(4) primary key,
 cname varchar(4), 
credits number(1),
dno number(2) references department(dno));

create table branchcourse
(bcode number(3) references branch(bcode),
ccode number(4) references course(ccode), 
sem number(1));
alter table branchcourse add primary key(bcode,ccode);
desc branchcourse;

create table student
(rollno number(2) primary key,
name varchar(10),
dob date, 
gender char,
doa date,
bcode number(3) references branch(bcode));
alter table student add constraint chk check (gender in ('M','F'));

create table enroll
(rollno number(2) references student(rollno),
ccode number(4) references course(ccode),
sess varchar(10),grade char);

insert into department values(05,'mee');
select * from department;
insert into branch values(110,'mee',05);
select * from branch;
insert into course values(1012,'oops',4,05);
select * from course;
insert into branchcourse values(110,1011,5);
select * from branchcourse;
insert into student values(05,'neha','01-may-2001','F','01-may-2023',110);
select * from student;
insert into enroll values(5,1005,'may23','A');
select * from enroll;

select d.dno,d.dname
from department d
where d.dno in (select b.dno
from branch b
group by b.dno having count(b.bcode)>2);