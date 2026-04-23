set search_path to datapencil;
create table ecom_orders as SELECT * FROM ecom_orders_dirty;


-- #1 cleaning the order_date column values
-- Rebuild clean column
alter table ecom_orders add column clean_order_date DATE;

UPDATE datapencil.ecom_orders
SET clean_order_date =
CASE
    -- March 5 2024
    WHEN order_date ~ '^[A-Za-z]+ [0-9]{1,2} [0-9]{4}$' THEN TO_DATE(order_date, 'Month DD YYYY')

    -- 12/03/2024
    WHEN order_date ~ '^[0-9]{2}/[0-9]{2}/[0-9]{4}$' THEN TO_DATE(order_date, 'DD/MM/YYYY')

    -- 12-03-24
    WHEN order_date ~ '^[0-9]{2}-[0-9]{2}-[0-9]{2}$' THEN TO_DATE(order_date, 'DD-MM-YY')

    -- 2024/03/15
    WHEN order_date ~ '^[0-9]{4}/[0-9]{2}/[0-9]{2}$' THEN TO_DATE(order_date, 'YYYY/MM/DD')
	ELSE NULL::DATE
END;

-- now drop the unwanted old order_date column

-- alter table ecom_orders drop column delivery_date;

-- #2 cleaning the delivery_date column values
-- Rebuild clean column
alter table ecom_orders
add column clean_delivery_date DATE;

UPDATE ecom_orders
SET clean_delivery_date =
CASE
    -- March 5 2024
    WHEN delivery_date ~ '^[A-Za-z]+ [0-9]{1,2} [0-9]{4}$'
        THEN TO_DATE(delivery_date, 'Month DD YYYY')

    -- 12/03/2024
    WHEN delivery_date ~ '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
        THEN TO_DATE(delivery_date, 'DD/MM/YYYY')

    -- 12-03-24
    WHEN delivery_date ~ '^[0-9]{2}-[0-9]{2}-[0-9]{2}$'
        THEN TO_DATE(delivery_date, 'DD-MM-YY')

    -- 2024/03/15
    WHEN delivery_date ~ '^[0-9]{4}/[0-9]{2}/[0-9]{2}$'
        THEN TO_DATE(delivery_date, 'YYYY/MM/DD')

    ELSE NULL::DATE
END;


--alter table ecom_orders drop column delivery_date;

-- #3 removing duplicates
DELETE FROM ecom_orders
WHERE ctid IN (
    SELECT ctid
    FROM (
        SELECT ctid,order_id,
               ROW_NUMBER() OVER (
                   PARTITION BY order_id
                   ORDER BY clean_order_date
               ) AS rn
        FROM ecom_orders
    ) t
    WHERE rn > 1
);

select * from ecom_orders;

-- 4# fixing the null values in delivary date 
alter table ecom_orders
add column new_delivery_date DATE;

select delivery_date from ecom_orders where clean_delivery_date is NULL;

update ecom_orders
set clean_delivery_date=clean_order_date + 5
where clean_delivery_date is NULL;

alter table ecom_orders drop new_delivery_date;

--#5 fix casing and spaces and hidden characters in all the columns

update datapencil.ecom_orders
set customer_name=trim(initcap(customer_name)),
	email=trim(lower(email)),
	city=trim(initcap(city)),
	state=trim(initcap(state)),
	product_name=trim(initcap(product_name)),
	category=trim(initcap(category)),
	payment_method=trim(initcap(payment_method)),
	order_status=trim(initcap(order_status)),
	phone=trim(phone),
	price=trim(price),
	quantity=trim(quantity),
	rating=trim(rating);


-- #6 delete columns with invalid emails(those that do not have @ or .)
Delete from ecom_orders where email not ilike '%@%.%';

-- #7 clean the phone column
-- added a column of phone numbers whose values will have country code
alter table ecom_orders
add column phone_e164 varchar(15);

-- updated phone column removed characters except those that lie btw 0-9

update ecom_orders
set phone=right(REGEXP_REPLACE(phone, '[^0-9]', '', 'g'),10);

-- updated by adding phone numbers with country code to the table

update ecom_orders
set phone_e164=concat('+91',phone);

-- 7 clean the price column
update ecom_orders
set price=regexp_replace(price,'[^0-9]','','g');


-- fix the quanity and rating column those values less than 1 or null replace with 1

alter table ecom_orders
alter column quantity type numeric
using quantity::numeric;

update ecom_orders
set quantity=round(1,1) where quantity is null or quantity<1;
update ecom_orders
set quantity=round(quantity,1);


alter table ecom_orders
alter column rating type numeric
using rating::numeric;

update ecom_orders
set rating=round(1,1) where rating is null or rating<1;


select * from ecom_orders;