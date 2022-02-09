# DBM06-Greengrocer

![Logo de Team](https://github.com/ana-polo/DBM06-greengrocer-sol/blob/main/DBM.gif "Team logo")

## Table of Contents

1. [General Info.](#general-info)
2. [Technologies.](#technologies)
3. [Collaboration.](#collaboration)
4. [Problem definition.](#problem-definition)
    1. [Creation of the tables of the DB.](#create)
    2. [Recording data.](#insert)
    3. [Querying data.](#query)

### 1. General Info

Training exercise of design and management of databases carried out in the field of Database Management in the Higher Vocational training Degree in Management of Computer Network Systems*

&nbsp;

### 2. Technologies

***
*MySQL* Version 8.0

- SQL-DDL: Data Definition Language
- SQL-DDL: Data Definition Language
- SQL-DQL: Data Query Language*

### 3. Collaboration

***
Students:
*Haplo35.*
*ErnestoPGH.*
*IrvingVqz.*

### 4. Problem definition

***

#### i. Create a new database called greengrocer with the following tables

📝 **TO DO:**

        1. Decide the appropriate name for each field, the most appropriate data type and whether it is mandatory that the field be 
    informed or not.
    
        2. Think about the order in which you will create the tables, keep in mind the restrictions. Define ALL possible constraints 
    primary keys, foreign keys, etc.

⚠️ **WARNING:**

- All the operations must be done in the creation of the tables.

👀 **Remember not forget!**

- Properly format and document the code.

&nbsp;

<details>
    <summary>CLICK ME TO SEE THE TABLES DEFINITION</summary>

<br />

##### CLASSES

    - IDENTIFIER with 5 characteres.
    - Name: It is a string of 10 characteres that can not be NULL.
    - Season: It can only be *spring*, *winter*, *fall*, *summer*, *all the year* or a combination of these values. The default value is *all the year*.

##### UNITS

    - IDENTIFIER, which is a numeric field that identifies each product.
    - Name: It is a string that it can not be NULL.

##### PRODUCTS

    - IDENTIFIER, which is a numeric field that identifies the record.
    - fk_class.
    - fk_unity.
    - Price, can not be NULL.

</details>

&nbsp;
&nbsp;

#### ii. Recording data

***

📝 **TO DO:**

    - Load the next information into the tables.

⚠️ **WARNING:**

- The operations CAN NOT be done in the creation of the tables.

👀 **Remember to not forget!**

- Properly format and document the code.

&nbsp;
<details>
    <summary>CLICK ME TO SEE THE DATA</summary>

<br />

##### CLASSES

    FR001 ; fruit      ; spring ; summer 
    FR002 ; fruit      ; winter 
    FR003 ; fruit      ; summer 
    FR004 ; fruit      ; all the year 
    LE001 ; legumes    ; fall ; winter 
    HO001 ; vegetables ; all the year 
    FRT01 ; fruit      ; fall 
    FRT02 ; fruit      ; all the year

##### UNITS

    1 ; grammes
    2 ; kilos 
    3 ; units 
    4 ; pieces 
    5 ; packs
    6 ; mesh

##### PRODUCTS

    1  ; oranges      ; FR002 ; 2 ; 1.80 
    2  ; tangerines   ; FR002 ; 2 ; 1.90 
    3  ; lentils      ; LE001 ; 5 ; 1.20 
    4  ; chickpeas    ; LE001 ; 5 ; 2.20  
    5  ; chestnuts    ; FR001 ; 2 ; 2.20 
    6  ; apples       ; FR004 ; 2 ; 2.50 
    7  ; apples       ; FR004 ; 5 ; 2.90 
    8  ; strawberries ; FR002 ; 5 ; 1.50 
    9  ; melon        ; FR003 ; 3 ; 0.80 
    10 ; watermelon   ; FR003 ; 3 ; 0.90 
    11 ; tomatos      ; FRT01 ; 2 ; 1.90

</details>

&nbsp;
&nbsp;

#### iii. Querying data

***

📝 **TO DO:**
        - Create sql scripts that allow you to obtain the following data from the created DB.

👀 **Remember to not forget!**

- Precede each script with a comment that corresponds to its statement
- Properly format and document the code.

&nbsp;
<details>
    <summary>CLICK ME TO SEE THE QUERIES</summary>

<br />

     1. Units in which each fruit is sold (name and unit) 
     2. List of summer products sold by kilos 
     3. List of product classes worth less than €2 
     4. List of legumes that are sold in packages at less than € 1.5 (name and price). 
     5. The average price of summer products 
     6. The average price of products sold in units 
     7. Units in which chestnuts are sold and what season they are 
     8. List of autumn products 
     9. List of products that only occur in autumn 
     10. List of fruits sold 
     11. List of products the class to which they belong 
     12. List of autumn products that are not sold by the kilos. 
     13. Name (not repeated) of products that are fruits 
     14. List of legumes 
     15. How many different legumes are there? 
     16. What class do tomatoes belong to? 
     17. Displays product codes for fruits and vegetables 
     18. What is the largest product code for fruits? 
     19. In which units is each fruit sold (name and unit)? 
     20. List of summer products sold by kilos.

</details>
