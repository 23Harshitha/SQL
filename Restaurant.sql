SELECT * FROM restaurant.userprofile;

/*Query 1
Customers can be classified into different levels according to their spending when they eat in the restaurant
This analysis is used to attract high spending customers with more variety of foods and 
attract medium paying customers by schemes*/

Select distinct budget from userprofile where budget != '?';
Select * ,
case when budget = 'high' then 'Special Dishes'
	 when budget = 'medium' then 'schemes'
     when budget = 'low' then 'coupons'
     else 'dont consider'
     end as future_plan
     from userprofile;
     
/*Query2
Knowing the customers lifestyle and interests helps the restaurant to build up infrastructure and business*/

Select distinct smoker from userprofile;
Select count(smoker) from userprofile where smoker='False';
Select count(smoker) from userprofile where smoker='True';

Select *,
case when smoker='False' then 'Add them to Indoor seatings'
     when smoker='True' then 'Add them to Rooftop seatings'
     else 'Remove from contact list'
     end as 'Reservations'
from userprofile;

/*Query3
Business should know there customers, so whether they have families or floating population helps them to plan their menu*/

Select distinct ambience from userprofile;
Select count(ambience) from userprofile where ambience='family';
Select count(ambience) from userprofile where ambience='friends';
Select count(ambience) from userprofile where ambience='solitary';

Select *,
case when ambience='family' then 'Suggest Kid Menu'
     when ambience='friends' then 'Suggest Coctail Menu'
	when ambience='solitary' then 'Suggest Counter'
     else 'Remove from contact list'
     end as 'Preferences'
from userprofile;

/*Query4 
It's always better to keep payment preferences of regular customers for convinience*/
Select distinct Upayment from userpayment;
Select * from userprofile inner join userpayment on 
userprofile.userID = userpayment.userID;

/*Query5
Customers reviews costs very much for growth of restaurant, so monitor of ratings is important for survival*/
Select * from rating_final;
Select distinct userID from rating_final;
Select * from rating_final group by userID;
Select max(rating) from rating_final;
Select max(food_rating) from rating_final;
Select max(service_rating) from rating_final;
Select userID, avg(rating), avg(food_rating), avg(service_rating) from rating_final group by userID;
Select userID,placeID from rating_final having avg(rating)>0.5 or  avg(food_rating)>0.5  or avg(service_rating)>0.5;
Select * from geoplaces2 inner join rating_final on geoplaces2.placeID = rating_final.placeID 
having avg(rating)>0.5 or  avg(food_rating)>0.5  or avg(service_rating)>0.5;

/*Query6
Restaurants location also play an important role for customers, most of the customers plan visiting restaurants based on location and price*/
Select name from geoplaces2;
Select distinct name, price from geoplaces2 order by price;

/*Query7
At the end of the day oxygen for restaurant is its food*/
SELECT * FROM restaurant.usercuisine;
Select distinct Rcuisine from usercuisine;
Select userprofile.userID, Rcuisine, userprofile.budget from userprofile inner join usercuisine on
userprofile.userID = usercuisine.userID group by userId having budget='high';






