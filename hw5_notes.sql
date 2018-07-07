/*
select id, group_concat(`Name` separator ',') as `Column`
from
(
  select id, concat(`Name`, ':',
  group_concat(`Value` separator ',')) as `Name`
  from mytbl
  group by id, `Name`
) tbl
group by id; 
--> 
SELECT pname FROM product as "

http://www.mysqltutorial.org/stored-procedures-loop.aspx
*/


-- question 4 : Addresses of the depots where the product "p1" is stocked.
-- (c) with exists/not exists
SELECT pname FROM product
WHERE EXISTS 
(SELECT stock.dep FROM stock WHERE stock.prod="p1"
AND depot.dep = stock.dep
AND stock.quantity > 0);

SELECT pname, COUNT(dep) AS dep_count FROM product
INNER JOIN 


SELECT pname, COUNT(dep) as dep_count FROM product 
INNER JOIN stock 
WHERE product.prod = stock.prod
AND dep > 2;


SELECT word, COUNT(*) AS cnt
FROM words
GROUP BY word
HAVING cnt > 1

SELECT name, price, photo
FROM drinks, drinks_photos
WHERE drinks.id = drinks_id 
GROUP BY drinks_id



create procedure count_procedure()
begin

declare v_counter int unsigned default 0;
SET @v_counter := 0;
SET @table_length := 0;


  while v_counter < v_max do
    
    set v_counter=v_counter+1;
  end while;
  commit;
end #

delimiter ;





call load_foo_test_data();

SELECT CASE 1 WHEN 1 THEN 'one'
WHEN 2 THEN 'two' ELSE 'more' END;
SELECT CASE WHEN 1>0 THEN 'true' ELSE 'false' END;
SELECT CASE BINARY 'B'
WHEN 'a' THEN 1 WHEN 'b' THEN 2 END;


delimiter $$
create procedure findClosestTimeStamp()
begin
    -- Variables to hold values from the communications table
    declare cFromId int;
    declare cTimeStamp datetime;
    -- Variables related to cursor:
    --    1. 'done' will be used to check if all the rows in the cursor 
    --       have been read
    --    2. 'curComm' will be the cursor: it will fetch each row
    --    3. The 'continue' handler will update the 'done' variable
    declare done int default false;
    declare curComm cursor for
        select fromId, timestamp from communication; -- This is the query used by the cursor.
    declare continue handler for not found -- This handler will be executed if no row is found in the cursor (for example, if all rows have been read).
        set done = true;

    -- Open the cursor: This will put the cursor on the first row of its
    -- rowset.
    open curComm;
    -- Begin the loop (that 'loop_comm' is a label for the loop)
    loop_comm: loop
        -- When you fetch a row from the cursor, the data from the current
        -- row is read into the variables, and the cursor advances to the
        -- next row. If there's no next row, the 'continue handler for not found'
        -- will set the 'done' variable to 'TRUE'
        fetch curComm into cFromId, cTimeStamp;
        -- Exit the loop if you're done
        if done then
            leave loop_comm;
        end if;
        -- Execute your desired query.
        -- As an example, I'm putting a SELECT statement, but it may be
        -- anything.
        select *
        from movement as m
        where m.vID = cFromId and m.timeStamp <= cTimeStamp
        order by timestampdiff(SECOND, cTimeStamp, m.timeStamp)
        limit 1;
    end loop;
    -- Don't forget to close the cursor when you finish
    close curComm;
end $$
delimiter ;


-- 10 10 10 10 10 10 10 10 
SELECT pname  
FROM product 
INNER JOIN
(SELECT COUNT(dep) 
FROM stock) AS dep_count 
WHERE stock.prod = product.prod
AND dep_count > 2;

SELECT pname  
FROM product 
WHERE (
	SELECT COUNT(dep) as dep_count
	FROM stock
	WHERE product.prod = stock.prod 
	AND dep_count
);


/* CURRENT CLOSEST ATTEMPT : */

create procedure find_at_least_3()
begin
SET @loop_counter := 0;
SET @table_length := 0;
	while @loop_counter < @table_length do
		
		set @loop_counter = @loop_counter+1;
	end while;
	commit;
end
delimiter;

call find_at_least_3();

create procedure find_prod_counts_equal_3()
begin
SET @loop_counter := 0;
SET @table_length := 0;
	while @loop_counter < @table_length do
		set @loop_counter = @loop_counter+1;
	end while;
	commit;
end
delimiter;

call find_prod_counts_equal_3();


ALTER TABLE stock ADD depot_count int default 0;
UPDATE stock 
LEFT JOIN (SELECT tag, COUNT(dep) AS dep_count 
FROM tag_objects GROUP BY tag) AS subq 
ON tags.id=subq.tag 
SET occurs=COALESCE(subq.cnt,0);