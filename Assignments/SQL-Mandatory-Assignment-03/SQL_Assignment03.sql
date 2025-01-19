select * from dbo.Jomato
-- SQL Assignment 3
--1. Create a stored procedure to display the restaurant name, type and cuisine where the table booking is not zero.
select RestaurantName, RestaurantType, CuisinesType from dbo.jomato where TableBooking = 0;

--2 Create a transaction and update the cuisine type ‘Cafe’ to ‘Cafeteria’. Check the result and rollback it.
-- Starting the transaction which produces the temp changes
BEGIN TRANSACTION;
Update dbo.Jomato set RestaurantType = 'cafeteria' where RestaurantType = 'cafe'; 
select * from dbo.jomato where RestaurantType = 'cafeteria';

-- Run the previous three commands and check the changes
-- Then run the rollback
Rollback;
-- Again test the changes
select * from dbo.jomato where RestaurantType = 'cafe';

--3 Generate a row number column and find the top 5 areas with the highest rating of restaurants.
Select top 10 *  from dbo.Jomato Order By Rating DESC ;

Select TOP 5 ROW_NUMBER() over (ORDER by rating Desc) as Rating_SR_Num,RestaurantName,Rating RestaurantType,CuisinesType, No_of_Rating
from dbo.Jomato 

-- 4 Use the while loop to display the 1 to 50
DECLARE @i int = 1
while @i <= 50
 BEGIN 
	--selecting the table data row wise with orderID from 1-50
	  Select * from dbo.Jomato where OrderId = @i 
	  SET @i = @i + 1
 END

--5 Write a query to Create a Top rating view to store the generated top 5 highest rating of restaurants.
Create VIEW RATED_5 AS 
select top 5 * from dbo.Jomato order by Rating DESC
 -- To delete view we use drop.
DROP View RATED_5
 -- View the Rated_5 table	
select * from RATED_5

--6 gmail configuration
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'Database Mail XPs', 1;
RECONFIGURE;

EXEC msdb.dbo.sysmail_add_account_sp
    @account_name = 'GmailAccount1',
    @email_address = 'linuxusir@gmail.com',
    @display_name = 'SQL Server Alerts',
    @replyto_address = 'vijrs25@gmail.com',
    @mailserver_name = 'smtp.gmail.com',
    @port = 587,
    @enable_ssl = 1,
    @username = 'linuxusir@gmail.com',
    @password = '****'; -- email password 

EXEC msdb.dbo.sysmail_add_profile_sp
    @profile_name = 'Vijay ratan singh1';

EXEC msdb.dbo.sysmail_add_profileaccount_sp
    @profile_name = 'Vijay ratan singh1',
    @account_name = 'GmailAccount1',
    @sequence_number = 1;


	EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'Vijay ratan singh1',
    @recipients = 'vijrs25@gmail.com',
    @subject = 'Test Email',
    @body = 'This is a test email from SQL Server using Gmail SMTP.';
