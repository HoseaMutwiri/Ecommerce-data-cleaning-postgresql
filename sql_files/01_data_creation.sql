create schema datapencil;
set search_path to datapencil;

create table ecom_orders_dirty(order_id varchar(10),
customer_name varchar(100),
email varchar(100),
phone varchar(50),
city varchar(50),
state varchar(100),
product_name varchar(100),
category varchar(50),
price varchar(50),
quantity varchar(50),
order_date varchar(50),
delivery_date varchar(50),
payment_method varchar(50),
order_status varchar(50),
rating varchar(50));

create table ecom_orders_clean as SELECT * FROM ecom_orders_dirty;




