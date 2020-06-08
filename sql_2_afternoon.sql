--Syntax Hint

SELECT [Column names] 
FROM [table] [abbv]
JOIN [table2] [abbv2] ON abbv.prop = abbv2.prop WHERE [Conditions];

SELECT a.name, b.name FROM some_table a JOIN another_table b ON a.some_id = b.some_id;
SELECT a.name, b.name FROM some_table a JOIN another_table b ON a.some_id = b.some_id WHERE b.email = 'e@mail.com';


--Practice joins

-- #1 Get all invoices where the unit_price on the invoice_line is greater than $0.99.
SELECT *
FROM invoice AS i
JOIN invoice_line AS il ON il.invoice_id = i.invoice_id
WHERE il.unit_price > 0.99;

-- #2 Get the invoice_date, customer first_name and last_name, and total from all invoices.
SELECT i.invoice_date, c.first_name, c.last_name, i.total
FROM invoice AS i
JOIN customer AS c ON i.customer_id = c.customer_id;

-- #3 Get the customer first_name and last_name and the support rep's first_name and last_name from all customers.
SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer AS c
JOIN employee AS e ON c.support_rep_id = e.employee_id;

-- #4 Get the album title and the artist name from all albums.
SELECT al.title, ar.name
FROM album AS al
JOIN artist AS ar ON al.artist_id = ar.artis_id;

-- #5 Get all playlist_track track_ids where the playlist name is Music
SELECT pt.track_id
FROM playlist_track AS pt
JOIN playlist AS p ON p.playlist_id = pt.playlist_id
WHERE p.name = 'Music';

--#6 Get all track names for playlist_id 5.
SELECT t.name
FROM track AS t
JOIN playlist_track AS pt ON pt.track_id = t.track_id
WHERE pt.playlist_id = 5;

--#7 Get all track names and the playlist name that they're on ( 2 joins ).
SELECT t.name, p.name
FROM track AS t
JOIN playlist_track AS pt ON t.track_id = pt.track_id
JOIN playlist AS p ON pt.playlist_id = p.playlist_id;

--#8 Get all track names and album titles that are the genre Alternative & Punk ( 2 joins ).
SELECT t.name, a.title
FROM track AS t
JOIN album AS a ON t.album_id = a.album_id
JOIN genre AS g ON g.genre_id = t.genre_id
WHERE g.name = 'Alternative & Punk';


--Practice nested queries

--Syntax Hint
SELECT [column names] 
FROM [table] 
WHERE column_id IN ( SELECT column_id FROM [table2] WHERE [Condition] );

SELECT name, Email FROM Athlete WHERE AthleteId IN ( SELECT PersonId FROM PieEaters WHERE Flavor='Apple' );

-- #1 Get all invoices where the unit_price on the invoice_line is greater than $0.99.
SELECT *
FROM invoice
WHERE invoice_id IN ( 
  SELECT invoice_id 
  FROM invoice_line 
  WHERE unit_price > .99
);

-- #2 Get all playlist tracks where the playlist name is Music.
SELECT *
FROM playlist_track
WHERE playlist_id IN ( 
  SELECT playlist_id
  FROM playlist 
  WHERE name = 'Music'
  );

-- #3 Get all track names for playlist_id 5.
SELECT name
FROM track
WHERE track_id IN ( 
  SELECT track_id
  FROM playlist_track
  WHERE playlist_id = 5
  );

-- #4 Get all tracks where the genre is Comedy.
SELECT *
FROM track
WHERE genre_id IN ( 
  SELECT genre_id
  FROM genre
  WHERE name = 'Comedy'
  );

-- #5 Get all tracks where the album is Fireball.
SELECT *
FROM track
WHERE album_id IN ( 
  SELECT album_id
  FROM album
  WHERE title = 'Fireball'
  );


-- #6 Get all tracks for the artist Queen ( 2 nested subqueries ).
SELECT *
FROM track
WHERE album_id IN ( 
  SELECT album_id FROM album WHERE artist_id IN ( 
    SELECT artist_id FROM artist WHERE name = 'Queen'
  )
);

--Practice updating Rows

--Syntax Hint
UPDATE [table] 
SET [column1] = [value1], [column2] = [value2] 
WHERE [Condition];

UPDATE athletes SET sport = 'Picklball' WHERE sport = 'pockleball';

-- #1 Find all customers with fax numbers and set those numbers to null.
UPDATE customer
SET fax = null
WHERE fax IS NOT null;

-- #2 Find all customers with no company (null) and set their company to "Self".
UPDATE customer
SET company = 'Self'
WHERE company IS null;

-- #3 Find the customer Julia Barnett and change her last name to Thompson.
UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett';

-- #4 Find the customer with this email luisrojas@yahoo.cl and change his support rep to 4.
UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

-- #5 Find all tracks that are the genre Metal and have no composer. Set the composer to "The darkness around us".
UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id = ( SELECT genre_id FROM genre WHERE name = 'Metal' )
AND composer IS null;

--Refresh your page to remove all database changes.
--REFRESHED!!


--Group by

--Syntax Hing
SELECT [column1], [column2]
FROM [table] [abbr]
GROUP BY [column];


-- #1 Find a count of how many tracks there are per genre. Display the genre name with the count.
SELECT COUNT (*), g.name
FROM track AS t
JOIN genre AS g ON t.genre_id = g.genre_id
GROUP BY g.name;

-- #2 Find a count of how many tracks are the "Pop" genre and how many tracks are the "Rock" genre.
SELECT COUNT(*), g.name
FROM track AS t
JOIN genre AS g ON g.genre_id = t.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY g.name;

-- #3 Find a list of all artists and how many albums they have.
SELECT ar.name, COUNT(*)
FROM album AS al
JOIN artist AS ar ON ar.artist_id = al.artist_id
GROUP BY ar.name;


--Use Distinct

--Syntax Hint
SELECT DISTINCT [column]
FROM [table];

--From the track table find a unique list of all composers.
SELECT DISTINCT composer
FROM track;

--From the invoice table find a unique list of all billing_postal_codes.
SELECT DISTINCT billing_postal_code
FROM invoice;

--From the customer table find a unique list of all companys.
SELECT DISTINCT company
FROM customer;

--Delete Rows

--Syntax Hint
DELETE FROM [table] WHERE [condition]


--Copy, paste, and run the SQL code from the summary.
--DONE!

--Delete all 'bronze' entries from the table.
DELETE FROM practice_delete
WHERE type = 'bronze'

--Delete all 'silver' entries from the table.
DELETE FROM practice_delete
WHERE type = 'silver'

--Delete all entries whose value is equal to 150.
DELETE FROM practice_delete
WHERE value = 150

--eCommerce Sim

--Summary

--Let's simulate an e-commerce site. We're going to need users, products, and orders.

--users need a name and an email.
--products need a name and a price
--orders need a ref to product.
--All 3 need primary keys.


--Create 3 Tables following the criteria in the summary. 
CREATE TABLE users(
  user_id SERIAL PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  email VARCHAR(200)
);

CREATE TABLE products(
  product_id SERIAL PRIMARY KEY,
  name VARCHAR(200),
  price DECIMAL(10,2)
);

CREATE TABLE orders(
  order_id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(user_id),
 	order_date DATE
);

INSERT INTO users (user_name, user_email)
VALUES
('Murr', 'murr@email.com'),
('Tuck', 'tuck@email.com'),
('Kletus', 'kletus@email.com');

INSERT INTO products (name, price)
VALUES
('Yee Yee Shirt', 25),
('Baseball Gove', 55.50),
('DevMtn Shirt', 500);

INSERT INTO orders (product_id)
VALUES
(1, 10),
(2 12),
(3, 2);

SELECT * FROM product
JOIN orders ON product.product_id = orders.product_id;

SELECT * FROM orders;

SELECT sum(price)
FROM product
JOIN orders ON product.product_id = orders.product_id
GROUP BY orders.order_id;

ALTER TABLE orders
ADD user_id INT REFERENCES users(user_id);

UPDATE orders
SET user_id = 1
WHERE order_id = 2;
UPDATE orders
SET user_id = 2
WHERE order_id = 3;
UPDATE orders
SET user_id = 3
WHERE order_id = 1;

SELECT * FROM orders
WHERE user_id = 1;

SELECT count(order_id), user_id
FROM orders
GROUP BY user_id;
