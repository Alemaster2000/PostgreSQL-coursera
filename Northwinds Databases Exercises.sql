-- (PostgreSQL)
-- Northwinds database at bit.io platform
    https://bit.io/alanparadise/nw

-- Basic Select EXERCISES 

    /* List all the products in the Northwinds database showing productid, productname, 
quantity per unit, unitprice, and unitsinstock.*/ 

select productid, productname, quantityperunit, unitprice, unitsinstock
    from "alanparadise/nw". "products";

    /* For all employees at Northwinds, list the first name and last name concatenated together with a blank space in-between, 
and the YEAR when they were hired.*/

select firstname || ' ' || lastname, 
    from "alanparadise/nw". "employees";

    /* For all products in the Northwinds database, list the productname, unitprice, unitsinstock,
and the total value of the inventory of that product as “Total Value”. (HINT: total value = unitsinstock * unitprice.) */

select productname, unitprice, unitsinstock, (unitsinstock * unitprice) as "Total Value"
    from "alanparadise/nw". "products";

    /* For all employees at Northwinds, list the first name and last name concatenated together 
with a blank space in-between with a column header “Name”, and the name of the month (spelled out) for each employee’s birthday. */

select firstname || ' ' || lastname as "Name", 
        to_char(birthdate, 'month') as "Birth Month"
    from "alanparadise/nw". "employees";

            -- OR

select concat(firstname, ' ', lastname) as "Name", 
        to_char(birthdate, 'month') as "Birth Month"
    from "alanparadise/nw". "employees";

    /* The following query list the Name, the Birth Date and their Age */

select firstname || ' ' || lastname as "Name", birthdate as "Birth Date", 
        ((current_date - birthdate) / 365) as "Age"
    from "alanparadise/nw". "employees";

-- Basic Where EXERCISES

    /* List the customerid, companyname, and country for all customers NOT in the U.S.A. */

select customerid, companyname, country
    from "alanparadise/nw". "customers"
    where country != 'USA' ;

    /* For all products in the Northwinds database, list the productname, unitprice, unitsinstock, and the total value of 
the inventory of that product as “Total Value” for all products with a Total Value greater than $1000. (HINT: total value = unitsinstock * unitprice) */

select productname, unitprice, unitsinstock, 
    (unitprice * unitsinstock) as "Total Value"
    from "alanparadise/nw". "products"
    where (unitprice * unitsinstock) > 1000 ;

    /* List the productid, productname, and quantityperunit for all products that come in bottles. Category ID for products in bottles is 1 */

select productid, productname, quantityperunit
    from "alanparadise/nw". "products"
    where categoryid = '1' ;

    /* List the productid, productname, and unitprice for all products whose categoryid is an ODD number. (HINT: categoryid is a one digit integer less than 9 …) */

select productid, productname, unitprice
    from "alanparadise/nw". "products"
    where categoryid in (1, 3, 5, 7) ;

    /* List the orderid, customerid, and shippeddate for orders that shipped to Canada in December 1996 through the end of January 1997. */

select orderid, customerid, shippeddate
    from "alanparadise/nw". "orders"
    where shipcountry = 'Canada' 
    AND shippeddate between '1996-12-01' and '1997-01-31' ;

-- Basic Date Functions and NULLs EXERCISES

    /* List the employeeid, firstname + lastname concatenated as ‘employee’, and the age of the employee when they were hired. */

SELECT EmployeeID, Firstname || ' ' || Lastname as "employee",
		age(HireDate, BirthDate)::text AS HIRE_AGE 
   	FROM "alanparadise/nw"."employees";

            -- OR

SELECT EmployeeID, Firstname || ' ' || Lastname as "employee",
		cast (age(HireDate, BirthDate)as text) AS HIRE_AGE 
   	FROM "alanparadise/nw"."employees";

    /* Run a query to calculate your age as of today. */

select to_date('19951219','YYYYMMDD') as "My Birthday", current_date as "Current Date",
    age(current_date,'19951219')::text as "My Age" ; -- we can substitute "current_date" with "now()" expression

    /* List the customerid, companyname and country for all customers whose region is NULL. */

select customerid, companyname, country
    from "alanparadise/nw"."customers"
    where region is NULL ;

-- How to set the zeros to NULLs ?

select productid, productname, discontinued
    FROM "alanparadise/nw"."products" 
    where discontinued = '0'; -- this shows the products which have value 'zero' in the "discontinued" column.

update "alanparadise/nw"."products"
    set discontinued = NULL
    where discontinued = '0'; -- this set the cells that have value 'zero' in the "discontinued" column as NULL.

select productid, productname, discontinued
    from "alanparadise/nw"."products"
    where discontinued is NULL; -- this shows the products which have the new value 'NULL' in the "discontinued" column.
    
select productid, productname, discontinued
    from "alanparadise/nw"."products"
    where discontinued is NOT NULL; -- this shows the products which have NOT the new value 'NULL' in the "discontinued" column.

-- Group By EXERCISES

    /* List the total (unitprice * quantity) as “Total Value”  by orderid for the top 5 orders.  
    (That is, the five orders with the highest Total Value.) */

select orderid, SUM(unitprice * quantity) as "Total Value" -- Function "SUM" is to do a summatory of the columns' total values, the columns must contain numeric values!
    from "alanparadise/nw"."orderdetails"
group by orderid -- this function groups our results by the given variable
order by 2 desc limit 5 ; -- this code orders our results by column "2" (in this case "Total Value") and limit the answer set to 5 results in a descendant order

        -- OR

select productid, to_char(SUM(unitprice * quantity), '999,999.0') as "Total Value" -- the "to_char" function along with the '999,999.0' limits the numeric results to six digits and a decimal
    from "alanparadise/nw"."orderdetails"
group by productid
order by SUM(unitprice * quantity) desc limit 5 ;

    /* How many products does Northwinds have in inventory? */

    /* How many products are out of stock? */

    /* From which supplier(s) does Northwinds carry the fewest products? */

    /* Which Northwinds employees (just show their employeeid) had over 100 orders ?  */