-- Easy Level Questions
Q1: who is the senior most employee based on job title?

select * from employee
ORDER BY levels desc
limit 1

Q2: Which country have the most invoices?

select COUNT(*) as c,billing_country
from invoice
GROUP BY billing_country
ORDER BY c desc

Q3: what are top three values of total invoices?

select total from invoice
order by total desc
limit 3

Q4:  which city has the best coustmers? we would like to throw a promotional music
festival in the city we made the most money. Write  a query that returns one city 
that has highest sum of invoice total . return both the city name and sum of all 
invoice totals

select SUM(total) as invoice_ttl, billing_city
from invoice
group by billing_city
order by invoice_ttl desc

Q5: who is the best coustmer? the coustmer who has spent the most money will be 
declared the best coustmer. write the query that returns the person who has spent 
the most mony

select customer.customer_id, customer.first_name, customer.last_name, SUM(invoice.total) as total
from customer
JOIN invoice on customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id
ORDER BY total DESC 
limit 1

-- Moderate level questions
Q1. Write query to return the email, first_name, last_name and genre of all rock music 
listners. return your list order alphbetivll by email starting with A

SELECT DISTINCT email, first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
SELECT track_id FROM track
JOIN genre ON track.genre_id = genre.genre_id
WHERE genre.name LIKE 'Rock')

ORDER BY email;

Q2: lets invite the artists who have written the most rock music in our dataset. Write the 
query that returns the artist name and total track count of the top 10 rock bands

SELECT artist.artist_id, artist.name, COUNT (artist.artist_id) AS number_of_songs
FROM track 
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id =album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs DESC
LIMIT 10;

Q3: Return all the track names that have a song length longer than the average song length. Return the name 
and millisecond for each track . Order by the song length with the longest song listed first

SELECT name, milliseconds FROM track
Where milliseconds >(
	SELECT AVG(milliseconds) AS avg_track_length
	FROM track)
ORDER BY milliseconds DESC;