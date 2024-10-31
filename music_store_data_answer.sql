-- QUESTION SET 1: Easy

-- Q1: Who is the senior most employee based on job title?
SELECT * FROM employee
ORDER BY levels DESC
LIMIT 1;

-- Q2: Which country has the most invoices?
SELECT
	billing_country,
	COUNT(*) AS no_of_invoices
FROM invoice
GROUP BY billing_country
ORDER BY COUNT(*) DESC;

-- Q3: What are the top 3 values of total invoice
SELECT total
FROM invoice
ORDER BY total DESC
LIMIT 3;

/*
-- Q4: Which city has the best customers? We would like to throw a
promotional Music Festival in the city we made the most money. Write a
query that returns one city that has the highest sum of invoice totals.
Return both the city name & sum of all invoice totals.
*/
SELECT
	billing_city,
	SUM(total) AS invoice_total
FROM invoice
GROUP BY billing_city
ORDER BY SUM(total) DESC
LIMIT 1;

/*
-- Q5: Q5: Who is the best customer? The customer who has spent the most
money will be declared the best customer. Write a query that returns
the person who has spent the most money.
*/
SELECT
    i.customer_id,
    c.first_name || ' ' || c.last_name AS full_name,
    SUM(i.total) AS total_spent
FROM customer c
INNER JOIN invoice i
    ON c.customer_id = i.customer_id
GROUP BY i.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 1;

-- QUESTION SET 2: Moderate
/*
Q1: Write query to return the email, first name, last name, & Genre of
all Rock Music listeners. Return your list ordered alphabetically
 email starting with A.
*/
SELECT
	 DISTINCT email, first_name, last_name
FROM customer c
INNER JOIN invoice i
ON c.customer_id=i.customer_id
INNER JOIN invoice_line il
ON i.invoice_id=il.invoice_id
WHERE il.track_id IN (
	SELECT track_id
	FROM track
	WHERE track_id IN (SELECT track_id FROM genre
WHERE name LIKE 'Rock')
)
ORDER BY email;

SELECT track_id FROM genre
WHERE name LIKE 'Rock'

/*
Q2: Let's invite the artists who have written the most rock music in
our dataset. Write a query that returns the Artist name and total 
track count of the top 10 rock bands
*/
SELECT
	a.artist_id,
	a.name,
	COUNT(t.track_id) AS total_track
FROM artist a
INNER JOIN album ab
ON a.artist_id=ab.artist_id
INNER JOIN track t
ON ab.album_id=t.album_id
WHERE t.genre_id IN (
	SELECT genre_id FROM genre
	WHERE name LIKE 'Rock'
	)
GROUP BY a.artist_id
ORDER BY COUNT(t.track_id) DESC
LIMIT 10;

/*
-- Q3: Return all the track names that have a song length longer than
the average song length. Return the Name and Milliseconds for
each track. Order by the song length with the longest songs listed
first.
*/
SELECT
	track_id,
	name,
	milliseconds
FROM track
WHERE milliseconds >
(SELECT 
	AVG(milliseconds) AS avg_length
FROM track)
ORDER BY milliseconds DESC;

-- QUESTION SET 3: Advance
/*
Q1: Find how much amount spent by each customer on artist with maximum earning?
Write a query to return customer name, artist name and total spent.
*/

/* Steps to Solve: First, find which artist has earned the most according to the InvoiceLines.
Now use this artist to find which customer spent the most on this artist. For this query, you
will need to use the Invoice, InvoiceLine, Track, Customer, Album, and Artist tables.
Note, this one is tricky because the Total spent in the Invoice table might not be on a
single product, so you need to use the InvoiceLine table to find out how many of each
product was purchased, and then multiply this by the price for each artist. */

WITH best_selling_artist AS (
SELECT
	a.artist_id,
	a.name AS artist_name,
	SUM(il.unit_price*il.quantity) AS total_sales
FROM track t
INNER JOIN invoice_line il
ON t.track_id=il.track_id
INNER JOIN album ab
ON t.album_id=ab.album_id
INNER JOIN artist a
ON a.artist_id=ab.artist_id
GROUP BY a.artist_id
ORDER BY 3 DESC
LIMIT 1
)
SELECT
	c.customer_id,
	c.first_name,
	c.last_name,
	bsa.artist_name,
	COUNT(*) AS no_of_purchases,
	SUM(il.unit_price*il.quantity) AS total_spent
FROM customer c
INNER JOIN invoice i
ON c.customer_id=i.customer_id
INNER JOIN invoice_line il
ON i.invoice_id=il.invoice_id
INNER JOIN track t
ON il.track_id=t.track_id
INNER JOIN album ab
ON t.album_id=ab.album_id
INNER JOIN best_selling_artist bsa
ON bsa.artist_id=ab.artist_id
GROUP BY c.customer_id, c.first_name, c.last_name, bsa.artist_name
ORDER BY total_spent DESC;

/*
Q2: We want to find out the most popular music Genre for each country.
We determine the most popular genre as the genre with the highest
amount of purchases. Write a query that returns each country along with
the top Genre. For countries where the maximum number of purchases
is shared return all Genres
*/

WITH popular_genre AS (
SELECT
	g.genre_id,
	g.name,
	i.billing_country,
	COUNT(il.quantity) AS purchases,
	ROW_NUMBER() OVER(PARTITION BY i.billing_country ORDER BY COUNT(il.quantity) DESC) AS rnk
FROM genre g
INNER JOIN track t
ON g.genre_id=t.genre_id
INNER JOIN invoice_line il
ON t.track_id=il.track_id
INNER JOIN invoice i
ON i.invoice_id=il.invoice_id
GROUP BY g.genre_id, i.billing_country
ORDER BY i.billing_country ASC, COUNT(il.quantity) DESC)

SELECT * FROM popular_genre WHERE rnk=1;

/*
Q3: Write a query that determines the customer that has spent the most
on music for each country. Write a query that returns the country along
with the top customer and how much they spent. For countries where
the top amount spent is shared, provide all customers who spent this
amount.
*/
WITH rank_per_country_purchase AS (
SELECT
	i.customer_id,
	c.first_name,
	c.last_name,
	c.country,
	SUM(total) AS total_spent,
	RANK() OVER(PARTITION BY c.country ORDER BY SUM(total) DESC) AS rnk
FROM customer c
INNER JOIN invoice i
ON c.customer_id=i.customer_id
GROUP BY i.customer_id, c.first_name, c.last_name, c.country)

SELECT * FROM rank_per_country_purchase WHERE rnk=1
ORDER BY country;