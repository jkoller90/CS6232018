/* 
question 1 : What are the #prods whose name begins with a 'p' and are less than $300.00? ---
*/

SELECT prod FROM Product WHERE LEFT(pname,1) = "p" AND price < 300; 


/*
question 2 : Names of the products stocked in "d2".
(a) without in/not in
(b) with in/not in
*/

--- a ---
SELECT DISTINCT pname FROM product 
INNER JOIN stock 
WHERE stock.prod = product.prod 
AND stock.dep = "d2";

--- b ---
SELECT DISTINCT pname FROM product 
INNER JOIN stock 
WHERE stock.prod = product.prod 
AND stock.dep IN ("d2");


/*
question 3 : #prod and names of the products that are out of stock.
(a) without in/not in
(b) with in/not in
*/

--- a ---
SELECT DISTINCT pname FROM product 
INNER JOIN stock 
WHERE stock.prod = product.prod 
AND stock.dep = "d2";

--- b ---
SELECT DISTINCT pname FROM product 
INNER JOIN stock 
WHERE stock.prod = product.prod 
AND stock.dep IN ("d2");


/*
question 4 : Addresses of the depots where the product "p1" is stocked.
(a) without exists/not exists and without in/not in
(b) with in/not in
(c) with exists/not exists
*/

--- a --- 
SELECT addr FROM depot 
INNER JOIN stock
WHERE depot.dep = stock.dep AND stock.prod="p1"
AND stock.quantity > 0; 

--- b --- 
SELECT addr FROM depot 
INNER JOIN stock
WHERE depot.dep = stock.dep AND stock.prod="p1"
AND stock.quantity > 0
AND addr IN("New York","Syracuse", "Chicago"); 

--- c --- 
SELECT addr FROM depot
WHERE EXISTS 
(SELECT stock.dep FROM stock WHERE stock.prod="p1"
AND depot.dep = stock.dep
AND stock.quantity > 0);


/*
question 5 :  #prods whose price is between $250.00 and $400.00.
*/
SELECT prod FROM stock
INTERSECT 
SELECT prod FROM product
WHERE product.price > 250 AND product.price < 400;   


/*
question 6 : How many products are out of stock?
*/

SELECT COUNT(*) FROM stock WHERE quantity < 1;


/*
question 7 : Average of the prices of the products stocked in the "d2" depot.
*/
SELECT AVG(price) FROM product 
INNER JOIN stock 
WHERE stock.dep = "d2" AND product.prod = stock.prod; 


/*
question 8 : #deps of the depot(s) with the largest capacity (volume).
*/
SELECT dep FROM depot ORDER BY volume DESC LIMIT 0, 1;

/*
question 9 : Sum of the stocked quantity of each product.
*/
SELECT prod, SUM(quantity) FROM stock GROUP BY prod;

/*10. Products names stocked in at least 3 depots.
(a) using count*/

SELECT pname FROM Product
WHERE prod IN 
(SELECT prod FROM Stock GROUP BY prod HAVING COUNT(dep)>=3);

/*(b) without using count*/

SELECT pname FROM Product WHERE prod IN
(SELECT S1.prod FROM Stock S1, Stock S2, Stock S3 WHERE
S1.dep <> S2.dep AND S1.dep <> S3.dep AND S2.dep <> S3.dep AND S1.prod = S2.prod AND S2.prod = S3.prod);


/*11. #prod stocked in all depots.
(a) using count*/

SELECT prod FROM Stock GROUP BY prod HAVING COUNT(dep)= (SELECT COUNT(*) FROM Depot);

/*(b) using exists/not exists*/
SELECT prod FROM Product P WHERE EXISTS 
(SELECT prod FROM Stock S WHERE P.prod = S.prod GROUP BY prod 
HAVING COUNT(dep) = (SELECT COUNT(*) FROM Depot ));
