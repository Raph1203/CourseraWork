-- 5) List the cities with the most reviews in descending order:
SELECT sum(review_count) AS 'total_reviews'
	,city
FROM business
GROUP BY city
ORDER BY total_reviews DESC

-- 6) Find the distribution of star ratings to the business in the following cities:

SELECT name
  ,city
  ,stars
  ,review_count
--  ,sum(review_count) AS 'count'
FROM business
WHERE city = 'Avon'
ORDER BY stars
--GROUP BY stars

-- +-----------------------------------------------+------+-------+--------------+
-- | name                                          | city | stars | review_count |
-- +-----------------------------------------------+------+-------+--------------+
-- | Portrait Innovations                          | Avon |   1.5 |           10 |
-- | Helen & Kal's                                 | Avon |   2.5 |            3 |
-- | Mr. Handyman of Cleveland's Northwest Suburbs | Avon |   2.5 |            3 |
-- | Light Salon & Spa                             | Avon |   3.5 |            7 |
-- | Winking Lizard Tavern                         | Avon |   3.5 |           31 |
-- | Mulligans Pub and Grill                       | Avon |   3.5 |           50 |
-- | Marc's                                        | Avon |   4.0 |            4 |
-- | Cambria hotel & suites Avon - Cleveland       | Avon |   4.0 |           17 |
-- | Dervish Mediterranean & Turkish Grill         | Avon |   4.5 |           31 |
-- | Hoban Pest Control                            | Avon |   5.0 |            3 |
-- +-----------------------------------------------+------+-------+--------------+

-- 7)Find the top 3 users based on their total number of reviews:

SELECT name
  ,review_count
FROM user
ORDER BY review_count DESC
LIMIT 3

-- 8) Does posting more reviews correlate with more fans?
SELECT name
  ,review_count
  ,fans
FROM user
ORDER BY review_count DESC

-- +-----------+--------------+------+
-- | name      | review_count | fans |
-- +-----------+--------------+------+
-- | Gerald    |         2000 |  253 |
-- | Sara      |         1629 |   50 |
-- | Yuri      |         1339 |   76 |
-- | .Hon      |         1246 |  101 |
-- | William   |         1215 |  126 |
-- | Harald    |         1153 |  311 |
-- | eric      |         1116 |   16 |
-- | Roanna    |         1039 |  104 |
-- | Mimi      |          968 |  497 |
-- | Christine |          930 |  173 |
-- | Ed        |          904 |   38 |
-- | Nicole    |          864 |   43 |
-- | Fran      |          862 |  124 |
-- | Mark      |          861 |  115 |
-- | Christina |          842 |   85 |
-- | Dominic   |          836 |   37 |
-- | Lissa     |          834 |  120 |
-- | Lisa      |          813 |  159 |
-- | Alison    |          775 |   61 |
-- | Sui       |          754 |   78 |
-- | Tim       |          702 |   35 |
-- | L         |          696 |   10 |
-- | Angela    |          694 |  101 |
-- | Crissy    |          676 |   25 |
-- | Lyn       |          675 |   45 |
-- +-----------+--------------+------+

-- +-----------+--------------+------+
-- | name      | review_count | fans |
-- +-----------+--------------+------+
-- | Amy       |          609 |  503 |
-- | Mimi      |          968 |  497 |
-- | Harald    |         1153 |  311 |
-- | Gerald    |         2000 |  253 |
-- | Christine |          930 |  173 |
-- | Lisa      |          813 |  159 |
-- | Cat       |          377 |  133 |
-- | William   |         1215 |  126 |
-- | Fran      |          862 |  124 |
-- | Lissa     |          834 |  120 |
-- | Mark      |          861 |  115 |
-- | Tiffany   |          408 |  111 |
-- | bernice   |          255 |  105 |
-- | Roanna    |         1039 |  104 |
-- | Angela    |          694 |  101 |
-- | .Hon      |         1246 |  101 |
-- | Ben       |          307 |   96 |
-- | Linda     |          584 |   89 |
-- | Christina |          842 |   85 |
-- | Jessica   |          220 |   84 |
-- | Greg      |          408 |   81 |
-- | Nieves    |          178 |   80 |
-- | Sui       |          754 |   78 |
-- | Yuri      |         1339 |   76 |
-- | Nicole    |          161 |   73 |
-- +-----------+--------------+------+

-- 9. Are there more reviews with the word "love" or with the word "hate" in them?
CREATE TABLE LoveHate (
	Love int,
	Hate int);
	
CREATE VIEW [LoveHate] AS
SELECT COUNT(text) AS 'Hate'
FROM review

--Pick one city and category of your choice and group the businesses in that city or category by their overall star rating. Compare the businesses with 2-3 stars to the businesses with 4-5 stars and answer the following questions. Include your code.
-- The following code returns the complete list of restaurants in Toronto with reviews, groups the results by restaurant name, and orders the results by star rating in descending order
SELECT c.category
	,b.name
	,b.city
	,b.stars
	,b.review_count
	FROM business b
INNER JOIN category c ON b.id = c.business_id
WHERE b.city = 'Toronto'AND c.category = 'Restaurants'
GROUP BY b.name
ORDER BY stars DESC
-- +-------------+--------------------+---------+-------+--------------+
-- | category    | name               | city    | stars | review_count |
-- +-------------+--------------------+---------+-------+--------------+
-- | Restaurants | Cabin Fever        | Toronto |   4.5 |           26 |
-- | Restaurants | Sushi Osaka        | Toronto |   4.5 |            8 |
-- | Restaurants | Edulis             | Toronto |   4.0 |           89 |
-- | Restaurants | Mama Mia           | Toronto |   4.0 |            8 |
-- | Restaurants | Naniwa-Taro        | Toronto |   4.0 |           75 |
-- | Restaurants | The Kosher Gourmet | Toronto |   3.5 |            3 |
-- | Restaurants | Big Smoke Burger   | Toronto |   3.0 |           47 |
-- | Restaurants | Pizzaiolo          | Toronto |   3.0 |           34 |
-- | Restaurants | 99 Cent Sushi      | Toronto |   2.0 |            5 |
-- | Restaurants | Royal Dumpling     | Toronto |   1.5 |            4 |
-- +-------------+--------------------+---------+-------+--------------+

-- This code returns the hours for Tortonto resatuarants with a rating between 2 and 3 and ordered by hours
SELECT c.category
	,b.name
	,b.city
	,b.stars
	,h.hours
FROM business b
INNER JOIN category c ON b.id = c.business_id
INNER JOIN hours h ON b.id = h.business_id
WHERE b.city = 'Toronto'
	AND c.category = 'Restaurants'
	AND stars BETWEEN 2
		AND 3
GROUP BY h.hours
ORDER BY h.hours

-- +-------------+------------------+---------+-------+-----------------------+
-- | category    | name             | city    | stars | hours                 |
-- +-------------+------------------+---------+-------+-----------------------+
-- | Restaurants | Big Smoke Burger | Toronto |   3.0 | Friday|10:30-21:00    |
-- | Restaurants | 99 Cent Sushi    | Toronto |   2.0 | Friday|11:00-23:00    |
-- | Restaurants | Pizzaiolo        | Toronto |   3.0 | Friday|9:00-4:00      |
-- | Restaurants | Big Smoke Burger | Toronto |   3.0 | Monday|10:30-21:00    |
-- | Restaurants | 99 Cent Sushi    | Toronto |   2.0 | Monday|11:00-23:00    |
-- | Restaurants | Pizzaiolo        | Toronto |   3.0 | Monday|9:00-23:00     |
-- | Restaurants | Pizzaiolo        | Toronto |   3.0 | Saturday|10:00-4:00   |
-- | Restaurants | Big Smoke Burger | Toronto |   3.0 | Saturday|10:30-21:00  |
-- | Restaurants | 99 Cent Sushi    | Toronto |   2.0 | Saturday|11:00-23:00  |
-- | Restaurants | Pizzaiolo        | Toronto |   3.0 | Sunday|10:00-23:00    |
-- | Restaurants | Big Smoke Burger | Toronto |   3.0 | Sunday|11:00-19:00    |
-- | Restaurants | 99 Cent Sushi    | Toronto |   2.0 | Sunday|11:00-23:00    |
-- | Restaurants | Big Smoke Burger | Toronto |   3.0 | Thursday|10:30-21:00  |
-- | Restaurants | 99 Cent Sushi    | Toronto |   2.0 | Thursday|11:00-23:00  |
-- | Restaurants | Pizzaiolo        | Toronto |   3.0 | Thursday|9:00-23:00   |
-- | Restaurants | Big Smoke Burger | Toronto |   3.0 | Tuesday|10:30-21:00   |
-- | Restaurants | 99 Cent Sushi    | Toronto |   2.0 | Tuesday|11:00-23:00   |
-- | Restaurants | Pizzaiolo        | Toronto |   3.0 | Tuesday|9:00-23:00    |
-- | Restaurants | Big Smoke Burger | Toronto |   3.0 | Wednesday|10:30-21:00 |
-- | Restaurants | 99 Cent Sushi    | Toronto |   2.0 | Wednesday|11:00-23:00 |
-- | Restaurants | Pizzaiolo        | Toronto |   3.0 | Wednesday|9:00-23:00  |
-- +-------------+------------------+---------+-------+-----------------------+

-- This code returns the hours for Tortonto resatuarants with a rating between 4 and 5 and ordered by hours
SELECT c.category
	,b.name
	,b.city
	,b.stars
	,h.hours
FROM business b
INNER JOIN category c ON b.id = c.business_id
INNER JOIN hours h ON b.id = h.business_id
WHERE b.city = 'Toronto'
	AND c.category = 'Restaurants'
	AND stars BETWEEN 4
		AND 5
GROUP BY h.hours
ORDER BY h.hours

-- +-------------+-------------+---------+-------+-----------------------+
-- | category    | name        | city    | stars | hours                 |
-- +-------------+-------------+---------+-------+-----------------------+
-- | Restaurants | Sushi Osaka | Toronto |   4.5 | Friday|11:00-23:00    |
-- | Restaurants | Edulis      | Toronto |   4.0 | Friday|18:00-23:00    |
-- | Restaurants | Cabin Fever | Toronto |   4.5 | Friday|18:00-2:00     |
-- | Restaurants | Sushi Osaka | Toronto |   4.5 | Monday|11:00-23:00    |
-- | Restaurants | Cabin Fever | Toronto |   4.5 | Monday|16:00-2:00     |
-- | Restaurants | Sushi Osaka | Toronto |   4.5 | Saturday|11:00-23:00  |
-- | Restaurants | Cabin Fever | Toronto |   4.5 | Saturday|16:00-2:00   |
-- | Restaurants | Edulis      | Toronto |   4.0 | Saturday|18:00-23:00  |
-- | Restaurants | Edulis      | Toronto |   4.0 | Sunday|12:00-16:00    |
-- | Restaurants | Sushi Osaka | Toronto |   4.5 | Sunday|14:00-23:00    |
-- | Restaurants | Cabin Fever | Toronto |   4.5 | Sunday|16:00-2:00     |
-- | Restaurants | Sushi Osaka | Toronto |   4.5 | Thursday|11:00-23:00  |
-- | Restaurants | Edulis      | Toronto |   4.0 | Thursday|18:00-23:00  |
-- | Restaurants | Cabin Fever | Toronto |   4.5 | Thursday|18:00-2:00   |
-- | Restaurants | Sushi Osaka | Toronto |   4.5 | Tuesday|11:00-23:00   |
-- | Restaurants | Cabin Fever | Toronto |   4.5 | Tuesday|18:00-2:00    |
-- | Restaurants | Sushi Osaka | Toronto |   4.5 | Wednesday|11:00-23:00 |
-- | Restaurants | Edulis      | Toronto |   4.0 | Wednesday|18:00-23:00 |
-- | Restaurants | Cabin Fever | Toronto |   4.5 | Wednesday|18:00-2:00  |
-- +-------------+-------------+---------+-------+-----------------------+

-- This code is used to return rating and location data for comparison to address question 1iii.
SELECT b.name
	,b.neighborhood
	,b.latitude
	,b.longitude
	,b.stars
	,b.review_count
FROM business b
INNER JOIN category c ON b.id = c.business_id
WHERE b.city = 'Toronto'
	AND c.category = 'Restaurants'
ORDER BY b.neighborhood

-- +--------------------+------------------------+----------+-----------+-------+--------------+
-- | name               | neighborhood           | latitude | longitude | stars | review_count |
-- +--------------------+------------------------+----------+-----------+-------+--------------+
-- | Mama Mia           |                        |  43.6809 |  -79.4302 |   4.0 |            8 |
-- | The Kosher Gourmet |                        |  43.7175 |  -79.4291 |   3.5 |            3 |
-- | Big Smoke Burger   | Downtown Core          |  43.6546 |  -79.3805 |   3.0 |           47 |
-- | 99 Cent Sushi      | Downtown Core          |  43.6614 |   -79.379 |   2.0 |            5 |
-- | Pizzaiolo          | Entertainment District |  43.6479 |  -79.3901 |   3.0 |           34 |
-- | Sushi Osaka        | Etobicoke              |  43.6452 |  -79.5324 |   4.5 |            8 |
-- | Cabin Fever        | High Park              |  43.6553 |  -79.4567 |   4.5 |           26 |
-- | Edulis             | Niagara                |  43.6419 |  -79.4066 |   4.0 |           89 |
-- | Royal Dumpling     | Willowdale             |  43.7752 |   -79.414 |   1.5 |            4 |
-- | Naniwa-Taro        | Willowdale             |  43.7766 |  -79.4142 |   4.0 |           75 |
-- +--------------------+------------------------+----------+-----------+-------+--------------+

-- This code is used to return location data for comparion of 2 to 3 star rated restuarants to address question 1iii
SELECT b.name
	,b.neighborhood
	,b.latitude
	,b.longitude
	,b.stars
	,b.review_count
FROM business b
INNER JOIN category c ON b.id = c.business_id
WHERE b.city = 'Toronto'
	AND c.category = 'Restaurants'
	AND stars BETWEEN 2
			AND 3
ORDER BY b.neighborhood

-- +------------------+------------------------+----------+-----------+-------+--------------+
-- | name             | neighborhood           | latitude | longitude | stars | review_count |
-- +------------------+------------------------+----------+-----------+-------+--------------+
-- | Big Smoke Burger | Downtown Core          |  43.6546 |  -79.3805 |   3.0 |           47 |
-- | 99 Cent Sushi    | Downtown Core          |  43.6614 |   -79.379 |   2.0 |            5 |
-- | Pizzaiolo        | Entertainment District |  43.6479 |  -79.3901 |   3.0 |           34 |
-- +------------------+------------------------+----------+-----------+-------+--------------+

-- This code is used to return location data for comparion of 2 to 3 star rated restuarants to address question 1iii
SELECT b.name
	,b.neighborhood
	,b.latitude
	,b.longitude
	,b.stars
	,b.review_count
FROM business b
INNER JOIN category c ON b.id = c.business_id
WHERE b.city = 'Toronto'
	AND c.category = 'Restaurants'
	AND stars BETWEEN 4
			AND 5
ORDER BY b.neighborhood

-- +-------------+--------------+----------+-----------+-------+--------------+
-- | name        | neighborhood | latitude | longitude | stars | review_count |
-- +-------------+--------------+----------+-----------+-------+--------------+
-- | Mama Mia    |              |  43.6809 |  -79.4302 |   4.0 |            8 |
-- | Sushi Osaka | Etobicoke    |  43.6452 |  -79.5324 |   4.5 |            8 |
-- | Cabin Fever | High Park    |  43.6553 |  -79.4567 |   4.5 |           26 |
-- | Edulis      | Niagara      |  43.6419 |  -79.4066 |   4.0 |           89 |
-- | Naniwa-Taro | Willowdale   |  43.7766 |  -79.4142 |   4.0 |           75 |
-- +-------------+--------------+----------+-----------+-------+--------------+

-- 2. Group business based on the ones that are open and the ones that are closed. What differences can you find between the ones that are still open and the ones that are closed? List at least two differences and the SQL code you used to arrive at your answer.

SELECT b.is_open
	,count(b.id) AS 'count of businesses'
	,AVG(b.stars) AS 'average rating'
	,SUM(b.review_count) AS 'total reviews'
FROM business b
GROUP BY b.is_open

-- +---------+---------------------+----------------+---------------+
-- | is_open | count of businesses | average rating | total reviews |
-- +---------+---------------------+----------------+---------------+
-- |       0 |                1520 |  3.52039473684 |         35261 |
-- |       1 |                8480 |  3.67900943396 |        269300 |
-- +---------+---------------------+----------------+---------------+
