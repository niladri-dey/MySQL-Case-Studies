SELECT * FROM campusx.smartphones;

/*
SQL GROUPING AND SORTING
Sorting data
1.Find top 5 samsung phones with biggest screen size
2.Sort all the phones in decending order of number of total cameras
3.Sort data on the basis of PPI(Pixel per Inches)in decreasing order
4.Find the phone with second lergest battery
5.Find the name and rating of the wrost rated apple phone
6.Sort phones alphabetically and then on the baasis of rating in desc order
7.Sort phone alphabetically and then on the basis of price in asc order
*/

SELECT model,screen_size FROM campusx.smartphones
WHERE brand_name='samsung'
ORDER BY screen_size DESC LIMIT 5 ;

SELECT model,num_front_cameras + num_rear_cameras AS Total_Cameras
FROM campusx.smartphones
ORDER BY Total_Cameras DESC;

SELECT model,
ROUND(SQRT(resolution_width*resolution_width+resolution_height*resolution_height)/screen_size) AS PPI
FROM campusx.smartphones
ORDER BY PPI DESC;

SELECT model,battery_capacity
FROM campusx.smartphones
ORDER BY battery_capacity DESC LIMIT 1,1;

SELECT model,rating
FROM campusx.smartphones
WHERE brand_name='apple'
ORDER BY rating ASC LIMIT 1;

SELECT * FROM campusx.smartphones
ORDER BY brand_name ASC,price ASC;

/*
1.Group smartphones by brand and get the count,average price,max rating
avg screen size and average battery capaity
2.Group smartphones by wheather they have an NFC and get the average price and rating
3.Group smartphones by extended memory available and get the average price and rating
4.Group sartphones by the brand and processor brand and get the count of models 
and the average primary camera resolution(rear)
5.Find the 5 most costly smartphones brands.
6.Which brand makes the smallest screen smartphones
7.Avg price of 5g smartphones and non 5g smartphones.
8.Group smartphones by brands and find the brand with the highest no of models
that have both NFC and an IR blaster.
9.Find all samsung 5g enabled phones and find out the average price for NFC and non NFC
10.Find the phone name price of the costliest phone.
*/

SELECT brand_name,COUNT(*) AS No_phones,
ROUND(AVG(price)) AS 'Avg price',
MAX(rating) AS 'Max ratings',
ROUND(AVG(screen_size),2) AS 'Avg Screen Size',
ROUND(AVG(battery_capacity),2) AS 'Avg Battery Capacity'
FROM campusx.smartphones
GROUP BY brand_name
ORDER BY No_phones DESC;

SELECT has_nfc,
AVG(price) AS 'Avg Price',
ROUND(AVG(rating),2) AS 'Avg Rating'
FROM campusx.smartphones
GROUP BY has_nfc;

SELECT extended_memory_available, COUNT(*) AS NO_AVAILABLE_PHONE,
AVG(price) AS 'Avg Price',
ROUND(AVG(rating),2) AS 'Avg Rating'
FROM campusx.smartphones
GROUP BY extended_memory_available;

SELECT brand_name,processor_brand,
COUNT(*) AS 'NO_PHONES',
ROUND(AVG(primary_camera_rear)) AS 'Avg Camera resolutions'
FROM campusx.smartphones
GROUP BY brand_name,processor_brand
ORDER BY brand_name;

SELECT brand_name,
ROUND(AVG(price)) AS 'Avg_Price'
FROM campusx.smartphones
GROUP BY brand_name
ORDER BY Avg_Price DESC LIMIT 5;

SELECT brand_name,
ROUND(AVG(screen_size)) AS 'Avg_Screen_Size'
FROM campusx.smartphones
GROUP BY brand_name
ORDER BY Avg_Screen_Size ASC;

SELECT has_5g,
COUNT(*) AS 'No_Phones',
ROUND(AVG(price)) AS 'Avg_price'
FROM campusx.smartphones
GROUP BY has_5g;

SELECT brand_name,COUNT(*) AS 'Phone_Available'
FROM campusx.smartphones
WHERE has_nfc='true' AND has_ir_blaster='true'
GROUP BY brand_name
ORDER BY Phone_Available DESC;

SELECT has_nfc,
ROUND(AVG(price)) AS 'Avg Price'
FROM campusx.smartphones
WHERE has_5g='true' AND brand_name='samsung'
GROUP BY has_nfc;

/*
HAVING CLAUSE
1.Find the average ratig of smartphone brands which have more than 20 phones
2. Find the top 3 sartphones brands with the highest avg ram that have a 
refresh rate of at least 90 HZ and fast charging available and don't 
consider brand which have less than 10 phones
3.Find the average price of all the phone brands with average rating >70
and num_phones more than 10 among all 5g enable phones 
*/

SELECT brand_name,COUNT(*) AS 'No_of_phones',
ROUND(AVG(rating)) AS 'Avg_rating'
FROM campusx.smartphones
GROUP BY brand_name
HAVING No_of_phones>40
ORDER BY Avg_rating ASC;

SELECT brand_name,COUNT(*) AS 'No_of_phones',
ROUND(AVG(ram_capacity)) AS 'Average RAM'
FROM campusx.smartphones
WHERE fast_charging_available= 1 AND refresh_rate>= 90
GROUP BY brand_name
HAVING No_of_phones>10
ORDER BY 'Average RAM' DESC LIMIT 3;
