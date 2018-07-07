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
