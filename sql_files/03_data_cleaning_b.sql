-- converting to correct datatypes and droping unwanted columns

set search_path to datapencil;

-- deleting unwanted columns
alter table ecom_orders
drop column order_date,
drop column delivery_date;

-- renaming columns to shorter and meaningful names
alter table ecom_orders
rename column clean_order_date to order_date;

alter table ecom_orders
rename column clean_delivery_date to delivery_date;

-- coverting to correct datatypes

alter table ecom_orders alter order_id type INT using round(order_id::numeric)::INT; 

-- copied and arranged table to a new one (arranged column names and ordered ids )

drop table if exists clean_ecommerce_orders_data;
create table clean_ecommerce_orders_data as
(select order_id,customer_name,email,phone,phone_e164,order_date,delivery_date,category,product_name,price,quantity,payment_method,city,state,order_status,rating from ecom_orders order by order_id asc);

select * from clean_ecommerce_orders_data;



