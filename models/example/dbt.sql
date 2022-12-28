with test as (
     select 1 as id
     union all 
     select 1000 as id 
)

 select * from test