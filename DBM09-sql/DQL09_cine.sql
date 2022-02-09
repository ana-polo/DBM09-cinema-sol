/*/*
    File: DQL09_cine.sql 
    Purpose: DBM SQL DML Exercice 09- Queries that allow to obtain the following data from the cine database.
    Written: 09/02/2022
    Author: Ana Polo Arozamena
*/

USE cine;
/*
--  1.- List the name and surname of the customers who have rented the film 'La vida es bella'. Each customer must appear only once. (0.5 points)
 */

SELECT 
    owners.owner_name AS OWNER, owners.surname AS SURNAME
FROM
    owners
WHERE
    owners.number_of_cats > 0;


    2.- List the names of the clients and how many copies has rented each of them. Display the result sorted by the number of copies rented descending. (0.5 points)
    3.- Show the income that has been obtained from the rental of the film 'Los puentes de Madinson' per month and year. Use fecha_prestamo to calculate it. (0.5 points)
    4.- List the title of the films that have been rented in alphabetical order.  Each title must come out only once. Do it in three different ways (INNER JOIN, IN, EXISTS). (1 point)
    5.- List the title of the films that have been rented in 2021 and have not been rented in 2022. Each title should appear only once. Takes the field fecha_prestamo as the date. (0.75 points)
    6.- List, using a single query, the copies (cod_copia) and the title of the films that are deteriorated and those that are not. The fields will be separated by an arrow (==>). The result will have to look like this:
            ...
            The copy==>CINE/004==>of the film==>Aterriza como puedes==>it is deteriorated
            The copy==>CINE/007==>of the film==>Archivo==>it is deteriorated
            The copy==>CINE/001==>of the film==>La vida es bella==>it is not deteriorated.
            The copy==>CINE/002==>of the film==>Los puentes de Madison==>it is not deteriorated
            The copy==>CINE/003==>of the film==>Terror==>it is not deteriorated
            The copy==>CINE/005==>of the film==>Vivo==>it is not deteriorated
            ...
        Don't do it using IF or CASE (0.75 points)
    7.- For the movies  that has been delivered late by any customer, display the copy number, the deadline, the delivery date and the period between the two dates (in days). Use the TIMESTAMPDIFF(unit,fecha_fin, fecha_inicio) where unit means the unit of time that you want to subtract (YEAR, MONTH, DAY) (0.5 points) 
    8. Insert as a customer a cohabiting brother of Teresa Alvarez Perez who is called Pepe. The only data you can put literally are Pepe, Teresa and Alvarez Perez.  (0.75 points)
    9.- List the film's title, the copy code and the rental price of the non-deteriorated copies that are cheapest for renting it. Use only one query. Do it in two different ways (1 point)
    10. List, for each movie, the rental price of the cheapest copy. The result will show the title of the film and the rental price (0.5 points)
    11.- Display the film's title and the revenue generated for the films of the year 2002 that have generated more than € 5.5 in rentals. (0.75 points)
    12.-List all the titles and indicate wheter the rental price of their copies is equal or greater than 2.5 euros or less than 2.5 euros (two conditions). Don't do it using UNION. Use the structure most appropriate to the case. The output will be something like this:
            'La vida es bella', 'The price is equal or greater than2.5 euros'
            'Los puentes de Madison', 'The price is equal or greater than 2.5 euros'
            'Terror', 'the price is less than 2.5 euros'
            'Aterriza como puedas', 'The price is equal or greater than 2.5 euros'
        Repeated values should not be displayed (0.75 points)
    13. Displays the customer's name, the copy code that he has rented, and the state of disrepair of this copy. The indicators for the status of  disrepair are one of these cases: 
            If the condition is good is in a satisfactory state
            If the state is bad is in an unsatisfactory state
            If the state is regular is in an unsatisfactory state
            If the state is lousy  is in an unsatisfactory state
            In any other state  is in a not defined state.
        The output will be something like this:
            ...
            The COPY CINE/001 rented by Ana Perez Lopez is in a satisfactory condition
            The COPY CINE/002 rented by Ana Perez Lopez is in an unsatisfactory state
            The COPY CINE/001 rented by Pepe Lopez Pelayo is in a satisfactory state
            The COPY CINE/001 rented by Juan Pelayo Millan is in a satisfactory condition
            ....
        Don't use a UNION in this script. Use the structure most appropriate to the case Do not display duplicate values (0.75 points)
    14.- Updates the price of copies for the films from the year 2002, decreasing them a 10% (0.5 points)
    15.- Delete customers who have not rented any film in 2021 (0.5 points) 
