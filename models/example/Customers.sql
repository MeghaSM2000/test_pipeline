
--select all useful col in expression 
with cust as (
select
    CustomerID,
    Customer,
    ContactName,
    Address,
    City,	
    Country	,
    Region,
    Fax	,
    Phone,	
    PostalCode,	
    CountryCode	,
    Latitude,	
    Longitude 
from FIVETRAN_DATABASE.DBT_DBO.CUSTOMERS_
where _FIVETRAN_DELETED= 'FALSE' 
),

-- getting count of customers count
 cust1 as (
select region,count(CustomerID) as "Region WISE CUSTOMER COUNT"
from FIVETRAN_DATABASE.DBT_DBO.CUSTOMERS_
group by region
 ),
/*
-- join the two expresion for combine result 
 cust2 as ( 
    select a.*,b."COUNTRY WISE CUSTOMER COUNT"
    from cust as a left join cust1 as b
    on a.region=b.region
 ),
*/
-- the count of products in orders places by customers 

cmr as (
    select c.customerid,count(od.productid) as "CUSTOMER WISE PRODUCT COUNT"
from  FIVETRAN_DATABASE.DBT_DBO.CUSTOMERS_ as C
inner join FIVETRAN_DATABASE.DBT_DBO.ORDERHEADER_ as OH
on c.CUSTOMERID=oH.customerid
inner join FIVETRAN_DATABASE.DBT_DBO.ORDERDETAILS_ as OD
on OH.orderid=OD.ORDERID
group by c.customerid,c.customer
order by customerid
),

-- join the three expresion for combine result 
 cust2 as ( 
    select a.*,b."Region WISE CUSTOMER COUNT",C."CUSTOMER WISE PRODUCT COUNT"
    from cust as a left join cust1 as b
    on a.region=b.region
    LEFT JOIN cmr as C
    on a.customerid=c.customerid
 )

 select * from cust2

