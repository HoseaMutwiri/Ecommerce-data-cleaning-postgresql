set search_path to datapencil;


-- check duplicate

select order_id,count(*) from ecom_orders_clean
group by order_id
having count(*)>1;

-- check /null values

select * from ecom_orders_clean
where city is null or trim(city) = '';

-- full column audit

select
sum(case when order_id is null or trim(order_id)='' then 1 else 0 end) as order_id_missing,
sum(case when customer_name is null or trim(customer_name)='' then 1 else 0 end) as customer_name_missing,
sum(case when email is null or trim(email)='' then 1 else 0 end) as email_missing,
sum(case when phone is null or trim(phone)='' then 1 else 0 end) as phone_missing,
sum(case when city is null or trim(city)='' then 1 else 0 end) as city_missing,
sum(case when state is null or trim(state)='' then 1 else 0 end) as state_missing,
sum(case when product_name is null or trim(product_name)='' then 1 else 0 end) as product_name_missing,
sum(case when category is null or trim(category)='' then 1 else 0 end) as category_missing,
sum(case when price is null or trim(price)='' then 1 else 0 end) as price_missing,
sum(case when quantity is null or trim(quantity)='' then 1 else 0 end) as quantity_missing,
sum(case when order_date is null or trim(order_date)='' then 1 else 0 end) as order_date_missing,
sum(case when delivery_date is null or trim(delivery_date)='' then 1 else 0 end) as delivery_date_missing,
sum(case when payment_method is null or trim(payment_method)='' then 1 else 0 end) as payment_method_missing,
sum(case when order_status is null or trim(order_status)='' then 1 else 0 end) as order_status_missing,
sum(case when rating is null or trim(rating)='' then 1 else 0 end) as rating_missing
from ecom_orders_clean;


-- email issue

select * from ecom_orders_clean
where email not ilike '%@%.%';

-- phone issue
select *
from ecom_orders_clean
where phone~'[^0-9]';-- numbers with spaces,+,-


-- price issue
select distinct price
from ecom_orders_clean;

-- date isssue business logic





