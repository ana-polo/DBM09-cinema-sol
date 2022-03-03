/*/*
    File: DQL09_cine.sql 
    Purpose: DBM SQL DML Exercice 09- Queries that allow to obtain the following data from the cine database.
    Written: 09/02/2022
    Author: Ana Polo Arozamena
*/

USE cinema;

/*
--  1.- List the name and surname of the customers who have rented the film 'La vida es bella'. Each customer must appear only once. (0.5 points)
*/

    -- OPC 1: WITHOUT INNER JOIN 
    
SELECT DISTINCT 
    customer.customer_name AS CUSTOMER,
    customer.customer_surname AS SURNAME
FROM
    customer,
    film,
    copy,
    renting
WHERE
    customer.id_customer = renting.fk_id_customer
        AND renting.fk_id_copy = copy.id_copy
        AND copy.fk_id_film = film.id_film
        AND UPPER(film.title) LIKE 'LA VIDA ES BELLA';


    -- OPC 2: WITH INNER JOIN AND CONCAT
    
SELECT DISTINCT
    CONCAT( customer.customer_name,
            ' ',
            customer.customer_surname ) AS 'Customer'
FROM
    ( ( customer
        INNER JOIN
    renting ON customer.id_customer = renting.fk_id_customer )
        INNER JOIN
    copy ON renting.fk_id_copy = copy.id_copy )
        INNER JOIN
    film ON copy.fk_id_film = film.id_film
WHERE
    UPPER(film.title) LIKE 'LA VIDA ES BELLA';


    -- OPC 3: WITH INNER JOIN AND CONCAT_WS
    
SELECT DISTINCT
    CONCAT_WS( ' ', customer.customer_name,
            customer.customer_surname ) AS 'Customer'
FROM
    ( ( customer
        INNER JOIN
    renting ON customer.id_customer = renting.fk_id_customer )
        INNER JOIN
    copy ON renting.fk_id_copy = copy.id_copy )
        INNER JOIN
    film ON copy.fk_id_film = film.id_film
WHERE
    UPPER(film.title) LIKE 'LA VIDA ES BELLA';


/*
-- 2.- List the names of the clients and how many copies has rented each of them. Display the result sorted by the number of copies rented descending. (0.5 points)
*/

    -- OPC 1: WITHOUT INNER JOIN AND CONCAT

SELECT 
    CONCAT( customer.customer_name, ' ', customer.customer_surname ) AS 'Customer name',
    COUNT( * ) AS 'Number of rents'
FROM
    customer,
    renting
WHERE
    renting.fk_id_customer = customer.id_customer
GROUP BY renting.fk_id_customer
ORDER BY 'Number of rents' DESC;


    -- OPC 2: WITH INNER JOIN AND CONCAT_WS

SELECT 
    CONCAT_WS( ' ',
            customer.customer_name,
            customer.customer_surname ) AS 'Customer name',
    COUNT( * ) AS 'Number of rents'
FROM
    customer
        INNER JOIN
    renting ON renting.fk_id_customer = customer.id_customer
GROUP BY renting.fk_id_customer
ORDER BY 'Number of rents' DESC;

    
/*
-- 3.- Show the income that has been obtained from the rental of the film 'Los puentes de Madinson' per month and year. Use the field renting_date to calculate it. (0.5 points)
*/

    -- OPC 1: WITHOUT INNER JOIN

SELECT 
    YEAR( renting.renting_date ),
    MONTH( renting.renting_date ),
    SUM( copy.price_rent )
FROM
    renting,
    copy,
    film
WHERE
    renting.fk_id_copy = copy.id_copy
        AND copy.fk_id_film = film.id_film
        AND film.title = 'Los puentes de Madison'
GROUP BY YEAR( renting_date ) , MONTH( renting_date );


    -- OPC 2: WITH INNER JOIN

SELECT 
    YEAR( renting.renting_date ),
    MONTH( renting.renting_date ),
    SUM( copy.price_rent )
FROM
    ( renting
        INNER JOIN
    copy ON renting.fk_id_copy = copy.id_copy )
        INNER JOIN
    film ON copy.fk_id_film = film.id_film
WHERE
    film.title = 'Los puentes de Madison'
GROUP BY YEAR(renting_date) , MONTH(renting_date);


/*
-- 4.- List the title of the films that have been rented in alphabetical order.  Each title must come out only once. Do it in three different ways (INNER JOIN, IN, EXISTS). (1 point)
*/

    -- OPC 0: WITHOUT JOIN, IN OR EXISTS

SELECT DISTINCT
    film.title
FROM
    film,
    copy,
    renting
WHERE
    renting.fk_id_film = copy.fk_id_film
        AND copy.id_copy = renting.fk_id_copy
ORDER BY film.title;


    -- OPC 1: WITH JOIN

SELECT DISTINCT
    film.title
FROM
    ( film
    INNER JOIN copy ON renting.fk_id_film = copy.fk_id_film )
        INNER JOIN
    renting ON copy.id_copy = renting.fk_id_copy
ORDER BY film.title;


    -- OPC 2: WITH IN WITHOUT JOIN

SELECT DISTINCT
    film.title
FROM
    film,
    copy
WHERE
    film.id_film = copy.fk_id_film
        AND copy.id_copy IN ( SELECT 
            renting.fk_id_copy
        FROM
            renting )
ORDER BY film.title;


    -- OPC 3: WITH IN WITH JOIN 

SELECT DISTINCT
    film.title
FROM
    film
        INNER JOIN
    copy ON film.id_film = copy.fk_id_film
        AND copy.id_copy IN ( SELECT 
            renting.fk_id_copy
        FROM
            renting )
ORDER BY film.title;


    -- OPC 4: WITH EXISTS WITHOUT JOIN 

SELECT DISTINCT
    film.title
FROM
    film,
    copy
WHERE
    film.id_film = copy.fk_id_film
        AND EXISTS ( SELECT 
            renting.fk_id_copy
        FROM
            renting,
            copy
        WHERE
            renting.fk_id_copy = copy.id_copy )
ORDER BY film.title;


    -- OPC 5: WITH EXISTS WITH JOIN 

SELECT DISTINCT
    film.title
FROM
    film,
    copy
WHERE
    film.id_film = copy.fk_id_film
        AND EXISTS ( SELECT 
            renting.fk_id_copy
        FROM
            renting
                INNER JOIN
            copy ON renting.fk_id_copy = copy.id_copy )
ORDER BY film.title;



/*
-- 5.- List the title of the films that have been rented in 2021 and have not been rented in 2022. Each title should appear only once. Takes the field renting_date as the date. (0.75 points)
*/

    -- OPC 1: WITHOUT JOIN
    
SELECT DISTINCT
    copy.id_copy, film.title
FROM
    film,
    copy,
    renting
WHERE
    renting.fk_id_copy = copy.id_copy
        AND copy.fk_id_film = film.id_film
        AND YEAR( renting.renting_date ) = '2021'
        AND copy.id_copy NOT IN ( SELECT 
            renting.fk_id_copy
        FROM
            renting
        WHERE
            YEAR( renting.renting_date ) = '2022' );


    -- OPC 2: WITH JOIN
    
SELECT DISTINCT
    copy.id_copy, film.title
FROM
    ( film
        INNER JOIN
    copy ON copy.fk_id_film = film.id_film )
        INNER JOIN
    renting ON renting.fk_id_copy = copy.id_copy
WHERE
    YEAR( renting.renting_date ) = '2021'
        AND copy.id_copy NOT IN (SELECT 
            renting.fk_id_copy
        FROM
            renting
        WHERE
            YEAR(renting.renting_date) = '2022');


/*
-- 6.- List, using a single query, the copies (cod_copia) and the title of the films that are deteriorated and those that are not. The fields will be separated by an arrow (==>). The result will have to look like this:
        ...
        The copy==>CINE/004==>of the film==>Aterriza como puedes==>is deteriorated
        The copy==>CINE/007==>of the film==>Archivo==>is deteriorated
        The copy==>CINE/001==>of the film==>La vida es bella==>is not deteriorated.
        The copy==>CINE/002==>of the film==>Los puentes de Madison==>is not deteriorated
        The copy==>CINE/003==>of the film==>Terror==>is not deteriorated
        The copy==>CINE/005==>of the film==>Vivo==>is not deteriorated
        ...
--  Don't do it using IF or CASE (0.75 points)
*/        

    -- OPC 1: CONCAT_WS WITHOT JOIN

SELECT 
    CONCAT_WS( ' ',
            'The copy==>',
            copy.id_copy,
            '==>of the film==>',
            film.title,
            '==>',
            'is deteriorated' )
FROM
    copy,
    film
WHERE
    copy.fk_id_film = film.id_film
        AND copy.deteriorated = TRUE 
UNION SELECT 
    CONCAT_WS( ' ',
            'The copy==>',
            copy.id_copy,
            '==>of the film==>',
            film.title,
            '==>',
            'is not deteriorated' )
FROM
    copy,
    film
WHERE
    copy.fk_id_film = film.id_film
        AND copy.deteriorated = FALSE; 


    -- OPC 2: CONCAT WITH JOIN

SELECT 
    CONCAT('The copy==> ',
            copy.id_copy,
            ' ==>of the film==> ',
            film.title,
            ' ==> ',
            'is deteriorated')
FROM
    copy
        INNER JOIN
    film ON copy.fk_id_film = film.id_film
WHERE
    copy.deteriorated = TRUE 
UNION SELECT 
    CONCAT('The copy==> ',
            copy.id_copy,
            ' ==>of the film==> ',
            film.title,
            ' ==> ',
            'is not deteriorated')
FROM
    copy
        INNER JOIN
    film ON copy.fk_id_film = film.id_film
WHERE
    copy.deteriorated = FALSE; 



/*
-- 7.- For the movies  that has been delivered late by any customer, display the copy number, the deadline, the delivery date and the period between the two dates (in days). Use the TIMESTAMPDIFF(unit,fecha_fin, fecha_inicio) where unit means the unit of time that you want to subtract (YEAR, MONTH, DAY) (0.5 points) 
*/

    -- OPC 1: WITHOUT INNER JOIN
    
SELECT 
    renting.fk_id_copy AS Copy,
    renting.deathline AS 'Death line',
    renting.delivering_date AS 'Deliver date',
    TIMESTAMPDIFF( DAY,
        renting.deathline,
        renting.delivering_date ) AS 'Delay'
FROM
    copy,
    renting
WHERE
 copy.id_copy = renting.fk_id_copy
        AND renting.deathline < renting.delivering_date;


    -- OPC 2: WITH INNER JOIN

SELECT 
    renting.fk_id_copy AS Copy,
    renting.deathline AS 'Death line',
    renting.delivering_date AS 'Deliver date',
    TIMESTAMPDIFF(DAY,
        renting.deathline,
        renting.delivering_date) AS 'Delay'
FROM
    copy
        INNER JOIN
    renting ON copy.id_copy = renting.fk_id_copy
WHERE
    renting.deathline < renting.delivering_date;


/*
-- 8. Insert as a customer a cohabiting brother of Teresa Alvarez Perez who is called Pepe. The only data you can put literally are Pepe, Teresa and Alvarez Perez.  (0.75 points)
*/
   
    -- OPC 1: WITH MAX()
    
INSERT INTO customer
SELECT ( 
    SELECT 
        MAX( customer.id_customer ) + 1 
    FROM 
        customer), 'Pepe', customer.customer_surname, customer.town
FROM 
    customer
WHERE customer.customer_name = 'Teresa' 
   AND customer.customer_surname = 'Alvarez Perez';


    -- OPC 2: WITH LIMIT
    
INSERT INTO customer
SELECT ( 
    SELECT 
<<<<<<< HEAD
        customer.id_customer 
=======
        customer.id_customer )
>>>>>>> a79fae6d996223e8a8ee8bcd080fcade02f6f752
    FROM 
        customer ORDER BY customer.id_customer LIMIT 1 ) + 1, 'Pepe', customer.customer_surname, customer.town
FROM 
    customer
WHERE customer.customer_name = 'Teresa' 
   AND customer.customer_surname = 'Alvarez Perez';



/*
-- 9.- List the film's title, the copy code and the rental price of the non-deteriorated copies that are cheapest for renting it. Use only one query. Do it in two different ways (1 point)
*/

    -- OPC 1: WITHOUT INNER JOIN AND =
    
SELECT 
    film.title, copy.id_copy, copy.price_rent
FROM
    film,
    copy
WHERE
    film.id_film = copy.fk_id_film
        AND copy.deteriorated = FALSE
        AND copy.price_rent = ( SELECT 
            MIN( copy.price_rent )
        FROM
            copy );


    -- OPC 2: WITHOUT INNER JOIN AND WITH ALL

SELECT 
    film.title, copy.id_copy, copy.price_rent
FROM
    film,
    copy
WHERE
    film.id_film = copy.fk_id_film
        AND copy.deteriorated = FALSE
        AND copy.price_rent <= ALL (SELECT 
            copy.price_rent
        FROM
            copy);


    -- OPC 3: WITH INNER JOIN AND =
    
SELECT 
    film.title, copy.id_copy, copy.price_rent
FROM
    film
        INNER JOIN
    copy ON film.id_film = copy.fk_id_film
WHERE
    copy.deteriorated = FALSE
        AND copy.price_rent = ( SELECT 
            MIN( copy.price_rent )
        FROM
            copy );


    -- OPC 4: WITH INNER JOIN AND WITH ALL

SELECT 
    film.title, copy.id_copy, copy.price_rent
FROM
    film
        INNER JOIN
    copy ON film.id_film = copy.fk_id_film
WHERE
    copy.deteriorated = FALSE
        AND copy.price_rent <= ALL ( SELECT 
            copy.price_rent
        FROM
            copy );



/*
-- 10. List, for each movie, the rental price of the cheapest copy. The result will show the title of the film and the rental price (0.5 points) 
*/

    -- OPC 1: WITHOUT INNER JOIN
    
SELECT 
    film.title, MIN( copy.price_rent )
FROM
    film,
    copy
WHERE
    film.id_film = copy.fk_id_film
GROUP BY film.title;


    -- OPC 2: WITH INNER JOIN
    
SELECT 
    film.title, MIN(copy.price_rent)
FROM
    film
        INNER JOIN
    copy ON film.id_film = copy.fk_id_film
GROUP BY film.title;



/*
--  11.- Display the film's title and the revenue generated for the films of the year 2002 that have generated more than € 5.5 in rentals. (0.75 points) 
*/

    -- OPC 1: WITHOUT INNER JOIN

SELECT 
    film.title, SUM( copy.price_rent )
FROM
    film,
    copy,
    renting
WHERE
    film.id_film = copy.fk_id_film
        AND copy.id_copy = renting.fk_id_copy
        AND film.year_film = '2002'
GROUP BY film.title
HAVING SUM( copy.price_rent ) > 5.5;


    -- OPC 2: WITH INNER JOIN

SELECT 
    film.title, SUM(copy.price_rent)
FROM
    ( film
        INNER JOIN
    copy ON film.id_film = copy.fk_id_film )
        INNER JOIN
    renting ON copy.id_copy = renting.fk_id_copy
WHERE
    film.year_film = '2002'
GROUP BY film.title
HAVING SUM( copy.price_rent ) > 5.5;


/*
-- 12.-List all the titles and indicate wheter the rental price of their copies is equal or greater than 2.5 euros or less than 2.5 euros (two conditions). Don't do it using UNION. Use the structure most appropriate to the case. The output will be something like this:
        'La vida es bella', 'The price is equal or greater than 2.5 euros'
        'Los puentes de Madison', 'The price is equal or greater than 2.5 euros'
        'Terror', 'The price is less than 2.5 euros'
        'Aterriza como puedas', 'The price is equal or greater than 2.5 euros'
    
    Repeated values should not be displayed (0.75 points)
*/

    -- OPC 1: WITHOUT JOIN AND USING IF
    
SELECT DISTINCT
    film.title,
    IF( copy.price_rent >= 2.5,
        'The price is equal or greater than 2.5 euros',
        'The price is less than 2.5 euros') AS price
FROM
    film,
    copy
WHERE
    film.id_film = copy.fk_id_film;


    -- OPC 2: WITH JOIN AND USING IF
    
SELECT DISTINCT
    film.title,
    IF( copy.price_rent >= 2.5,
        'The price is equal or greater than 2.5 euros',
        'The price is less than 2.5 euros') AS price
FROM
    film INNER JOIN 
    copy
ON
    film.id_film = copy.fk_id_film;


    -- OPC 3: WITHOUT JOIN AND USING CASE  (WHEN WE ONLY HAVE TWO OPTIONS IT IS BETTER TO USE THE IF )
    
SELECT DISTINCT
    film.title,
    CASE
        WHEN copy.price_rent >= 2.5 THEN 'The price is equal or greater than 2.5 euros'
        ELSE 'The price is less than 2.5 euros'
    END AS price
FROM
    film,
    copy
WHERE
    film.id_film = copy.fk_id_film;


    -- OPC 4: WITH JOIN AND USING CASE (WHEN WE ONLY HAVE TWO OPTIONS IT IS BETTER TO USE THE IF )
    
SELECT DISTINCT
    film.title,
    CASE
        WHEN copy.price_rent >= 2.5 THEN 'The price is equal or greater than 2.5 euros'
        ELSE 'The price is less than 2.5 euros'
    END AS price
FROM
    film
        INNER JOIN
    copy ON film.id_film = copy.fk_id_film;


    -- OPC 5: WITHOUT JOIN AND USING UNION (NOT ALLOWED IN THE EXAM)
    
SELECT DISTINCT
    film.title,
    'The price is equal or greater than 2.5 euros' AS price
FROM
    film,
    copy
WHERE
    film.id_film = copy.fk_id_film
        AND copy.price_rent >= 2.5 
UNION SELECT DISTINCT
    film.title, 'The price is less than 2.5 euros' AS price
FROM
    film,
    copy
WHERE
    film.id_film = copy.fk_id_film
        AND copy.price_rent < 2.5; 


    -- OPC 6: WITH JOIN AND USING UNION (NOT ALLOWED IN THE EXAM)
    
SELECT DISTINCT
    film.title,
    'The price is equal or greater than 2.5 euros' AS price
FROM
    film
        INNER JOIN
    copy ON film.id_film = copy.fk_id_film
WHERE
    copy.price_rent >= 2.5 
UNION SELECT DISTINCT
    film.title, 'The price is less than 2.5 euros' AS price
FROM
    film
        INNER JOIN
    copy ON film.id_film = copy.fk_id_film
WHERE
    copy.price_rent < 2.5; 



/*
-- 13. Displays the customer's name, the copy code that he has rented, and the state of disrepair of this copy. The indicators for the status of  disrepair are one of these cases: 
            If the condition is good: is in a satisfactory state
            If the state is bad: is in an unsatisfactory state
            If the state is regular: is in an unsatisfactory state
            If the state is 'very bad': is in an unsatisfactory state
            In any other state: is in a not defined state.
        The output will be something like this:
            ...
            The COPY CINE/001 rented by Ana Perez Lopez is in a satisfactory condition
            The COPY CINE/002 rented by Ana Perez Lopez is in an unsatisfactory state
            The COPY CINE/001 rented by Pepe Lopez Pelayo is in a satisfactory state
            The COPY CINE/001 rented by Juan Pelayo Millan is in a satisfactory condition
            ....
        Don't use a UNION in this script. Use the structure most appropriate to the case Do not display duplicate values (0.75 points) 
*/

    -- OPC 1: CLEAN CASE WITHOUT INNER JOIN
    
SELECT DISTINCT
    'The copy ',
    copy.id_copy,
    ' rented by',
    customer.customer_name,
    ' ',
    customer.customer_surname,
    CASE
        WHEN copy.state = 'good' THEN ' is in a satisfactory condition '
        WHEN copy.state = 'bad' THEN ' is in an unsatisfactory condition '
        WHEN copy.state = 'regular' THEN ' is in an unsatisfactory condition '
        WHEN copy.state = 'very bad' THEN ' is in an unsatisfactory condition '
        ELSE ' is in a not defined state '
    END AS Estate
FROM
    customer,
    renting,
    copy
WHERE
    customer.id_customer = renting.fk_id_customer
        AND renting.fk_id_copy = copy.id_copy;


    -- OPC 2: CASE WITH CONCAT_WS WITHOUT INNER JOIN

SELECT CASE 
WHEN copy.state = "good" THEN CONCAT_WS( " ", "The copy", copy.id_copy, "rented by", customer.customer_name, "is in an unsatisfactory condition." )
WHEN copy.state = "regular" THEN CONCAT_WS( " ", "The copy", copy.id_copy, "rented by", customer.customer_name, "is in an unsatisfactory condition.")
WHEN copy.state = "bad" THEN CONCAT_WS( " ", "The copy", copy.id_copy, "rented by", customer.customer_name, "is in an unsatisfactory condition.")
WHEN copy.state = "'very bad'" THEN CONCAT_WS( " ", "The copy", copy.id_copy, "rented by",  customer.customer_name,"is in an unsatisfactory condition.")
ELSE CONCAT_WS( " ", "The copy", copy.id_copy, "rented by", customer.customer_name, "is in an undefined state")
END  AS situation
FROM copy, customer,renting
WHERE customer.id_customer = renting.fk_id_customer
   AND renting.fk_id_copy = copy.id_copy;


    -- OPC 3: CLEAN CASE WITH INNER JOIN
    
SELECT DISTINCT
    'The copy ',
    copy.id_copy,
    ' rented by',
    customer.customer_name,
    ' ',
    customer.customer_surname,
    CASE
        WHEN copy.state = 'good' THEN ' is in a satisfactory condition '
        WHEN copy.state = 'bad' THEN ' is in an unsatisfactory condition '
        WHEN copy.state = 'regular' THEN ' is in an unsatisfactory condition '
        WHEN copy.state = 'very bad' THEN ' is in an unsatisfactory condition '
        ELSE ' is in a not defined state '
    END AS Estate
FROM
    customer
        INNER JOIN
    renting ON customer.id_customer = renting.fk_id_customer
        INNER JOIN
    copy ON renting.fk_id_copy = copy.id_copy;


    -- OPC 4: CASE WITH CONCAT AND INNER JOIN

SELECT CASE 
WHEN copy.state = "good" THEN CONCAT( "The copy ", copy.id_copy, " rented by ", customer.customer_name, " is in an unsatisfactory condition." )
WHEN copy.state = "regular" THEN CONCAT( "The copy ", copy.id_copy, " rented by ", customer.customer_name, " is in an unsatisfactory condition." )
WHEN copy.state = "bad" THEN CONCAT( "The copy ", copy.id_copy, " rented by ", customer.customer_name, " is in an unsatisfactory condition." )
WHEN copy.state = "'very bad'" THEN CONCAT( "The copy ", copy.id_copy, " rented by ",  customer.customer_name," is in an unsatisfactory condition." )
ELSE CONCAT( "The copy ", copy.id_copy, " rented by ", customer.customer_name, " is in an undefined state" )
END  AS situation
FROM
    customer
        INNER JOIN
    renting ON customer.id_customer = renting.fk_id_customer
        INNER JOIN
    copy ON renting.fk_id_copy = copy.id_copy;
    
    
    
/*
-- 14.- Updates the price of copies for the films from the year 2002, decreasing them a 10% (0.5 points) 
*/

    -- OPC 1: ONLY ONE ARITMETICAL OPERATION

UPDATE copy
SET copy.price_rent = ROUND( copy.price_rent * 0.9, 2 )
WHERE film.id_film IN ( SELECT film.id_film
                                     FROM film
                                     WHERE film.year_film = '2002' );


    -- OPC 2: ONLY ONE ARITMETICAL OPERATION

UPDATE copy
SET copy.price_rent = ROUND( copy.price_rent - copy.price_rent * 0.1, 2 )
WHERE film.id_film IN ( SELECT film.id_film
                                     FROM film
                                     WHERE film.year_film = '2002' );



/*
-- 15.- Delete customers who have not rented any film in 2021 (0.5 points) 
*/

DELETE FROM customer
WHERE customer.id_customer NOT IN (SELECT id_customer
                                            FROM renting
                                            WHERE YEAR( renting.renting_date ) = '2021' );



/* 
-- 16.- Films without copies
*/

    -- OPC 1: LEFT EXCLUDING JOIN
    
SELECT DISTINCT
    film.title
FROM
    film
        LEFT JOIN
    copy ON film.id_film = copy.fk_id_film
WHERE
    copy.id_copy IS NULL;


    -- OPC 2: RIGHT EXCLUDING JOIN

SELECT DISTINCT
    film.title
FROM
    copy
        RIGHT JOIN
    film ON film.id_film = copy.fk_id_film
WHERE
    copy.id_copy IS NULL;



/* 
-- 17.- Customers that have no rented any film 
*/

    -- OPC 1: LEFT EXCLUDING JOIN AND CONCAT

SELECT DISTINCT
    CONCAT(customer.customer_name,
            ' ',
            customer.customer_surname) AS 'Customer'
FROM
    customer
        LEFT JOIN
    renting ON customer.id_customer = renting.fk_id_customer
WHERE
    renting.fk_id_customer IS NULL; 
    

    -- OPC 2: LEFT EXCLUDING JOIN AND CONCAT_WS

SELECT DISTINCT
    CONCAT_WS( ' ',
            customer.customer_name,
            customer.customer_surname ) AS 'Customer'
FROM
    renting
        RIGHT JOIN
    customer ON customer.id_customer = renting.fk_id_customer
WHERE
    renting.fk_id_customer IS NULL;     
