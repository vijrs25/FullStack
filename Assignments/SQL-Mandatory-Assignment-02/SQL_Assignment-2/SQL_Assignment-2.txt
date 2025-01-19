--SQL Assignmemt 2

--Task 1. Create a user-defined functions to stuff the Chicken into ‘Quick Bites’. Eg: ‘Quick Chicken Bites’.
-- Solution
update dbo.Jomato

--We can also use Replace instead of funtion-> SET RestaurantType = REPLACE(RestaurantType,'1231','Ca')
SET RestaurantType = dbo.nameRepalce(RestaurantType)

/*****Function nameReplace()
CREATE FUNCTION nameReset( @restType VARCHAR(100))
RETURNS VARCHAR(100)
AS
BEGIN
	Return replace(@restType,'Quick Bites', 'Quick Chicken Bytes');
END;
select * from dbo.Jomato
******/

--Task 2:  Use the function to display the restaurant name and cuisine type which has the maximum number of rating.
--Solution
--It can be done in three ways
--Here Top 15 is for top highest rating restaurants
--1. with rating greater than 4.7
select RestaurantName, CAST(Rating as decimal(5,1)) as 'PEA' From dbo.Jomato 
where Rating > 4.7 

-- Order by rating DECS give the top restaurant from top to bottom
SELECT RestaurantName , MAX(Rating) as HighestRatedRestraunt
FROM dbo.Jomato
GROUP BY RestaurantName
Order by HighestRatedRestraunt DESC

/****** After creating a Method

CREATE FUNCTION dbo.MAC1()
RETURNS Float
AS
	BEGIN
	Declare @result Float;
		Select @result = MAX(Rating) from dbo.Jomato;
		return @result;
	END;
*****/
select dbo.MAC1() as 'MAX RATING PRESENT';

--Task 3:Create a Rating Status column to display the rating as 
--‘Excellent’ if it has more the 4 start rating, 
--‘Good’ if it has above 3.5 and below 5 star rating,
--‘Average’ if it is above 3 and below 3.5 and 
--‘Bad’ if it is below 3 star rating.

/*** Solution with Case
 Select RestaurantName,
	case
		when Rating >4 then 'excellent'
		when rating <4 and Rating >3.5 then 'good'
		when Rating <3.5 and rating >3 then 'average'
		else 'bad'
	end as 'restaurant ratings'
from dbo.Jomato; ***/

Select RestaurantName ,Dbo.ratReview(Rating) as 'Reviews' from Dbo.jomato

/** Solution with If else

Create FUNCTION RatingReview(
    @ratingLevel FLOAT
)
RETURNS nvarchar(50)
AS
BEGIN
    IF @ratingLevel > 4 
    BEGIN
        RETURN 'xcellent';
    END
    ELSE IF @ratingLevel > 3.5 AND @ratingLevel <= 4 
    BEGIN
        RETURN 'Good';
    END
    ELSE IF @ratingLevel > 3 AND @ratingLevel <= 3.5 
    BEGIN
        RETURN 'Average';
    END
    ELSE 
    BEGIN
        RETURN 'Bad';	
    END
	return 'No Ratings available'
END;

 ******/
SELECT dbo.RatingReview(Rating) as 'RatingReview' from dbo.Jomato;

--Task 4. Find the Ceil, floor and absolute values of the rating column and display the current date and separately display the year, month_name and day.
 
--Solution 
 Select RestaurantName, Rating , FLOOR(rating) as Floor_Rating, CEILING(Rating) as Ceiling_rating, 
 GETDATE() as 'Currrent Date',
 DAY(GETDATE()) as Day,
 Month(GETDATE()) as Month, 
 Year(GETDATE()) as Year from  dbo.Jomato;

--Task 5. Display the restaurant type and total average cost using rollup.
-- With the help of Rollup I can have the Subtotal based on Resturant type across all the Areas.
SELECT area, restaurantType ,AVG(Averagecost) as 'Restaurant Avr Cost' from dbo.Jomato group by ROllup(RestaurantType, area ) ;
-- Without Rollup i can have basic average.
SELECT restaurantType ,AVG(Averagecost) as 'Restaurant Avr Cost' from dbo.Jomato group by (RestaurantType) order by RestaurantType ASC; 