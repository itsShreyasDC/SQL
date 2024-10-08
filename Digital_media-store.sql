 Show full name, customer ID, and country for all customers who are not in the USA
SELECT 
    firstname,
    lastname,
    customerid, 
    country
FROM customers
WHERE country <> 'USA'
ORDER BY country;

Show only the customers from Brazil
SELECT
    customerid,
    firstname,
    lastname,
    country
FROM customers
WHERE country = 'Brazil';

Find the invoices of customers who are from Brazil and display the customer's full name, invoice ID, date of invoice, and billing country
SELECT 
    c.firstname,
    c.lastname,
    i.invoiceid,
    i.invoicedate,
    i.billingcountry
FROM customers AS c
LEFT JOIN invoices AS i
ON c.customerid = i.customerid
WHERE i.billingcountry = 'Brazil';

 Show the employees who are sales agents
SELECT
    employeeid,
    firstname,
    lastname,
    title
FROM employees
WHERE title = 'Sales Support Agent'
ORDER BY lastname;

 Find a unique list of billing countries from the invoices table
SELECT
    DISTINCT billingcountry
FROM invoices
ORDER BY billingcountry;

 Show the invoice IDs associated with each sales agent, including the sales agent's full name
SELECT
    e.firstname,
    e.lastname,
    i.invoiceid
FROM customers AS c
JOIN employees AS e
ON c.supportrepid = e.employeeid
JOIN invoices AS i
ON c.customerid = i.customerid
ORDER BY e.lastname;

 Show the invoice total, customer name, country, and sales agent for all invoices and customers
SELECT
    i.invoiceid,
    i.total AS invoice_total,
    c.firstname AS customer_first_name,
    c.lastname AS customer_last_name,
    c.country AS customer_country,
    e.firstname AS employee_first_name,
    e.lastname AS employee_last_name
FROM customers AS c
FULL JOIN invoices AS i
ON c.customerid = i.customerid
LEFT JOIN employees AS e
ON c.supportrepid = e.employeeid
ORDER BY i.invoiceid;

How many invoices were there in 2009?
SELECT 
    COUNT(invoiceid) AS '2009_sales' 
FROM invoices
WHERE invoicedate LIKE '%2009%';

What are the total sales for 2009?
SELECT
    ROUND(SUM(total), 2) AS total_sales
FROM invoices
WHERE invoicedate LIKE '%2009%';

 Show the purchased track name with each invoice line ID
SELECT
    i.invoicelineid,
    t.name AS track_name
FROM invoice_items AS i
JOIN tracks AS t
ON i.trackid = t.trackid
ORDER BY i.invoicelineid;  

 Show the purchased track name and artist name with each invoice line ID
SELECT
    inv.invoicelineid,
    tra.name AS track_name,
    art.name AS artist
FROM invoice_items AS inv
LEFT JOIN tracks AS tra
ON inv.trackid = tra.trackid
INNER JOIN albums AS alb
ON tra.albumid = alb.albumid
LEFT JOIN artists AS art   
ON alb.artistid = art.artistid
ORDER BY inv.invoicelineid;

 Show all the tracks and include the album name, media type, and genre
SELECT 
    t.trackid,
    t.name AS track_name,
    a.title AS album,
    m.name AS media_type,
    g.name AS genre
FROM tracks as t
JOIN albums AS a
ON t.albumid = a.albumid
JOIN media_types AS m
ON t.mediatypeid = m.mediatypeid
JOIN genres AS g
ON t.genreid = g.genreid;

Show the total sales made by each sales agent
SELECT
    e.firstname,
    e.lastname,
    ROUND(SUM(i.total), 2) AS total_sales
FROM customers AS c
JOIN employees AS e
ON c.supportrepid = e.employeeid
JOIN invoices AS i
ON c.customerid = i.customerid
GROUP BY c.supportrepid
ORDER BY total_sales DESC;

Which sales agent made the most dollars in sales in 2009?
SELECT
    e.firstname,
    e.lastname,
    ROUND(SUM(i.total), 2) AS dollars_made
FROM customers AS c
JOIN employees AS e
ON c.supportrepid = e.employeeid
JOIN invoices AS i
ON c.customerid = i.customerid
WHERE i.invoicedate LIKE '%2009%'
GROUP BY c.supportrepid
ORDER BY dollars_made DESC
LIMIT 1;