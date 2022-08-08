create database airline
use airline

create table employee(e_id int primary key identity,name nvarchar(20),age numeric(20),Department nvarchar(40))
insert into employee values('KULDEEP',34,'MARKETING')
insert into employee values('MANISH',48,'FLIGHT OPERATIONS')
insert into employee values('ROHINI',49,'REVENUE MANAGEMENT')
insert into employee values('AAKASH',53,'FINANCIAL PLANNING AND ANALYSIS')
insert into employee values('RISHABH',25,'GROUND SERVICES')

SELECT * FROM EMPLOYEE
DROP TABLE EMPLOYEE

create table customer(c_id int primary key identity,name nvarchar(20),address nvarchar(20),age numeric(20))
insert into customer values('AMIT','DELHI',34)
insert into customer values('RAHUL','LUCKNOW',42)
insert into customer values('ROHIT','GURUGRAM',28)
insert into customer values('SHALINI','BANGLORE',39)
insert into customer values('PREET','GOA',32)

create table flight(f_id int primary key identity,name nvarchar(20),where_from nvarchar(20),whereTo nvarchar(20))
insert into flight values('IndiGo','BANGLORE','DELHI')
insert into flight values('AirINDIA','DELHI','KOLKATA')
insert into flight values('KINGFISHER','CHENNAI','MUMBAI')
insert into flight values('VISTARA','LUCKNOW','GOA')
insert into flight values('SpiceJet','MUMBAI','BANGLORE')

SELECT *FROM flight


create table ticket(t_id int primary key identity,confirmation_status nvarchar(20),payment_status nvarchar(20),c_id int,f_id int,
CONSTRAINT fk_ticket_customer
foreign key (c_id)
references customer(c_id),

CONSTRAINT fk_ticket_flight
foreign key (f_id)
references flight(f_id))

insert into ticket values('CONFIRMED','PAYMENT DONE',2,5)
insert into ticket values('PENDING','PAYMENT DONE',1,3)
insert into ticket values('PENDING','PAYMENT PENDING',4,2)
insert into ticket values('CONFIRMED','PAYMENT DONE',5,3)
insert into ticket values('CONFIRMED','PAYMENT DONE',2,4)

SELECT * FROM ticket
DROP TABLE ticket

create procedure sp_customer_status
as
begin
select c.c_id,c.name,t.t_id,t.confirmation_status
from customer as c
inner join ticket as t
on
c.c_id=t.t_id order by name
end

drop procedure sp_customer_status
exec sp_customer_status


create procedure sp_flight_status
as
begin
select f.f_id,f.name,f.where_from,f.whereTo,t.t_id,t.confirmation_status
from flight as f
left join ticket as t 
on
f.f_id=t.t_id order by where_from desc
end

drop procedure sp_flight_status
exec sp_flight_status


