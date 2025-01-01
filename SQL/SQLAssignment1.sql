/* SQL Assignment 1
Problem statement :ABC Fashion is a leading retailer with a vast customer base and a team of dedicated sales
 representatives. They have a Sales Order Processing System that helps manage customer
 orders and interactions
 */

 -- Create tables and insert data 

 CREATE TABLE Salesman (
    SalesmanId INT,
    Name VARCHAR(255),
    Commission DECIMAL(10, 2),
    City VARCHAR(255),
    Age INT
);

INSERT INTO Salesman (SalesmanId, Name, Commission, City, Age)
VALUES
    (101, 'Joe', 50, 'California', 17),
    (102, 'Simon', 75, 'Texas', 25),
    (103, 'Jessie', 105, 'Florida', 35),
    (104, 'Danny', 100, 'Texas', 22),
    (105, 'Lia', 65, 'New Jersey', 30);

 CREATE TABLE SalesmanTable2 (
    SalesmanId INT,
    Name VARCHAR(255),
    Commission DECIMAL(10, 2),
    City VARCHAR(255),
    Age INT
);

INSERT INTO SalesmanTable2(SalesmanId, Name, Commission, City, Age)
VALUES
    (201, 'Joe', 50, 'California', 17),
    (202, 'Simon', 75, 'Texas', 25),
    (203, 'Jessie', 105, 'Florida', 35),
    (104, 'Danny', 100, 'Texas', 22),
    (105, 'Lia', 65, 'New Jersey', 30);


CREATE TABLE Customer (
    SalesmanId INT,
    CustomerId INT,
    CustomerName VARCHAR(255),
    PurchaseAmount INT,
    );

INSERT INTO Customer (SalesmanId, CustomerId, CustomerName, PurchaseAmount)
VALUES
    (101, 2345, 'Andrew', 550),
    (103, 1575, 'Lucky', 4500),
    (104, 2345, 'Andrew', 4000),
    (107, 3747, 'Remona', 2700),
    (110, 4004, 'Julia', 4545);

CREATE TABLE Orders (OrderId int, CustomerId int, SalesmanId int, Orderdate Date, Amount money)

INSERT INTO Orders Values 
(5001,2345,101,'2021-07-01',550),
(5003,1234,105,'2022-02-15',1500)
select * from Orders
select * from Salesman
select * from Customer
-- T1. Insert a new record in your Orders table
select * from Orders
insert into Orders values(5005 ,3232, 501, '2021-12-25', '277')

-- T2.1.Add Primary key constraint for SalesmanId column in Salesman table. 
select * from Salesman
 --first make it not null for PK
alter table dbo.salesman
alter column salesmanid int not null
-- add primary key
alter table dbo.salesman
add primary key (SalesmanId)

-- T2.2.Add default constraint for City column in Salesman table. 
select * from Salesman
alter table salesman
--alter column city DEFAULT 'Pune';
alter table salesman 
ADD CONSTRAINT DF_Salesman_Age
DEFAULT 'pune' FOR City;
Update Salesman Set city=default where age= 25
-- Testing for Age
update Salesman SET Age = default where City ='florida'
select * from Salesman
-- T2.3.Add Foreign key constraint for SalesmanIdcolumn in Customer table. 

alter table customer
add constraint FK_salesManID
Foreign key (salesmanId) references salesman(salesmanID)

-- T2.4.Add not null constraint in Customer_name column for the Customer table.
select * from Customer
alter table Customer
alter column CustomerName varchar(255) not null ;
--------------------------

--T3 fetch and like use
-- adding into salesman id as foreign key restriction
insert into Salesman values (54 , 'salesman Freddy' , 5900.00 , 'jalgaon', 28)
insert into Salesman values (55 , 'salesman rob' , 5900.00 , 'jalgaon', 28)
insert into Salesman values (56 , 'salesman sharma' , 5900.00 , 'jalgaon', 28)
insert into Customer values (2354,'Nitin',909000,54 )
insert into Customer values (2354,'Pitin',90,55 )
insert into Customer values (2354,'Sitin',1000,56 )
select * from Customer
where CustomerName like '%n' and PurchaseAmount >500

--T4 Set for salesManID
Select * from Customer
Union
Select * from Salesman