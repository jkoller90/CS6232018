/*
http://www.mysqltutorial.org/stored-procedures-loop.aspx

using count: https://stackoverflow.com/questions/3937283/mysql-count-occurrences-greater-than-2#3937298

question 10 : Products names stocked in at least 3 depots.
(a) using count 
(b) without using count
*/
--- a --- 

SELECT pname as name FROM product;


SELECT pname  
FROM product 
INNER JOIN
(SELECT COUNT(dep) 
	FROM stock) AS dep_count 
	WHERE 
	NOT IN (0,1,2);
--- b --- 

			/* Collect CONCAT_ of some kind and then WHERE or HAVING for the resultant  
				 string. 
				 		SELECT CONCAT_(",", x,y) */ 	

/*
SELECT pname  
FROM product 
INNER JOIN 
stock 
(SELECT COUNT(dep) FROM stock ) as dep_count 


Note the use of the LEFT JOIN to ensure all tags are counted, 
even the unused ones. The coalesce-function will convert 
NULL to 0.
*/

/*
question 11 : #prod stocked in all depots.
(a) using count
(b) using exists/not exists
*/

--- a --- 
			/* COUNT(n) = 3 or IN (3)  */ 	
--- b --- 
			/* Collect CONCAT_ of some kind and then WHERE or HAVING for the resultant  
				 string - this one would ask for a full string  
				 				 		SELECT CONCAT_(",", x,y) */ 



/*
GROUP_CONCAT(DISTINCT expression
    ORDER BY expression
    SEPARATOR sep);

separator is a comma by default but it's best to know what it is

*/