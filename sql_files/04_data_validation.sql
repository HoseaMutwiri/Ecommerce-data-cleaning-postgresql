set search_path to datapencil;

--validate if there are duplicates

select order_id,count(*) from ecom_orders
group by order_id
having count(*)>1;

-- validation of invalid emails

select * from ecom_orders
where email not ilike '%@%.%';

-- validation of price

select distinct price
from ecom_orders;
