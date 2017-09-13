DROP TABLE IF EXISTS learn_about;
DROP TABLE IF EXISTS purchase_feature;
DROP TABLE IF EXISTS feature;
DROP TABLE IF EXISTS purchase;
DROP TABLE IF EXISTS owner;
DROP TABLE IF EXISTS line_schedule;
DROP TABLE IF EXISTS manufacturing_line;
DROP TABLE IF EXISTS material_order_line;
DROP TABLE IF EXISTS material_order;
DROP TABLE IF EXISTS supplier;
DROP TABLE IF EXISTS material_needed;
DROP TABLE IF EXISTS raw_material;
DROP TABLE IF EXISTS problem_report;
DROP TABLE IF EXISTS problem_type;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS product_status;
DROP TABLE IF EXISTS shipment;
DROP TABLE IF EXISTS order_line;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS test;
DROP TABLE IF EXISTS test_type;
DROP TABLE IF EXISTS model;


CREATE TABLE model (
 model_numb int,
 model_desciption varchar(40),
suggested_retail_price DECIMAL(6,2),
shipping_weight DECIMAL (6,2),
time_to_manufacture TIME,
constraint model_pkey PRIMARY key (model_numb)
);

CREATE TABLE test_type(
test_code int,
test_description varchar(40),

constraint test_type_pkey primary key(test_code)
);

create table test(
model_numb int,
test_date date,
test_location varchar(40),
test_code int,
test_results varchar(40),

constraint test_pkey primary key(model_numb, test_date),
constraint test_fkey1 foreign key(model_numb)
	   references model(model_numb),
constraint test_fkey2 foreign key(test_code)
	   references test_type(test_code)
);

create table customer(
customer_numb int,
customer_name varchar(40),
customer_street varchar(40),
customer_city varchar(30),
customer_state char(2),
customer_zip char(5),
contact_person char(40),
contact_phone char(12),
conctact_fax varchar(12),

constraint customer_pkey primary key(customer_numb)
);

CREATE TABLE orders(
order_numb int,
customer_numb int,
order_date date,
order_total decimal(8,2),
order_filled char(1),

constraint orders_pkey primary key(order_numb),
constraint order_fkey foreign key(customer_numb)
	   references customer(customer_numb)
);

CREATE TABLE order_line(
order_numb int,
model_numb int,
quantity_ordered int,
unit_price decimal(6,2),
line_total decimal(8,2),
all_shipped char(1),

constraint order_line_pkey primary key(order_numb, model_numb),
constraint order_line_fkey1 foreign key(order_numb)
	   references orders(order_numb),
constraint order_line_fkey2 foreign key(model_numb)
	   references model(model_numb)
);

create table shipment (
order_numb int,
model_numb int,
shipping_date date,
quantity_shipped int,

constraint shipment_pkey primary key(order_numb, model_numb, shipping_date),
constraint shipment_fkey_1 foreign key(order_numb)
	   references orders(order_numb),
constraint shipment_fkey2_2 foreign key(model_numb)
	   references model (model_numb)
);

create table product_status(
status_code int,
status_description varchar(40),

constraint product_status_pkey primary key(status_code)
);

create table product(
serial_numb int,
model_numb int,
date_manufactured date,
status_code int,
date_shipped int,
order_numb int,

constraint product_pkey primary key(serial_numb),
-- constraint product_fkey foreign key(serial_numb)
-- 	   references purchase(serial_numb),
constraint product_fkey1 foreign key(model_numb)
	   references model(model_numb),
constraint product_fkey2 foreign key(status_code)
	   references product_status(status_code),
constraint product_fkey3 foreign key(order_numb)
	   references orders(order_numb)
);
	   

create table raw_material(
material_id_numb int,
material_name varchar(30),
unit_of_measurement varchar(12),
quantity_in_stock int,
reorder_point int,

constraint raw_material_pkey primary key(material_id_numb)
);

create table material_needed(
model_numb int,
material_id_numb int,
quantity_needed int,

constraint material_needed_pkey primary key(model_numb, material_id_numb),
constraint material_needed_fkey1 foreign key(model_numb)
	   references model(model_numb),
constraint material_needed_fkey2 foreign key(material_id_numb)
	   references raw_material(material_id_numb)
);

create table supplier(
supplier_numb int,
supplier_name varchar(40),
supplier_street varchar(30),
supplier_city varchar(15),
supplier_state char(2),
supplier_zip char(5),
supplier_contact varchar(40),
supplier_phone char(12),

constraint supplier_pkey primary key(supplier_numb)
);


create table material_order(
po_numb int,
supplier_numb int,
material_order_date date,
material_order_total decimal(6,2),

constraint material_order_pkey primary key(po_numb),
constraint material_order_fkey foreign key(supplier_numb)
	   references supplier(supplier_numb)
);

create table material_order_line(
po_numb int,
material_id_numb int,
material_quantity int,
material_cost_each decimal(6,2),
material_line_cost decimal(8,2),

constraint material_order_line_pkey primary key(po_numb, material_id_numb),
constraint material_order_line_fkey1 foreign key(po_numb)
	   references material_order(po_numb),
constraint material_order_line_fkey2 foreign key(material_id_numb)
	   references raw_material(material_id_numb)
);

create table manufacturing_line(
line_numb int,
line_status varchar(12),

constraint manufacturing_line_pkey primary key(line_numb)
);

create table line_schedule(
line_numb int,
production_date decimal(6,2),
model_numb int,
quantity_to_produce int,

constraint line_schedule_pkey primary key(line_numb, production_date),
constraint line_schedule_fkey1 foreign key(line_numb)
	   references manufacturing_line(line_numb),
constraint line_schedule_fkey2 foreign key(model_numb)
	   references model(model_numb)
);

create table owner(
owner_numb int,
owner_first_name varchar(15),
owner_last_name varchar(15),
owner_street varchar(30),
owner_city varchar(15),
owner_state char(2),
owner_zip char(5),
owner_phone varchar(12),

constraint owner_pkey primary key(owner_numb)
);

create table purchase(
serial_numb int,
owner_numb int,
age int,
gender char(1),
purchase_date date,
purchase_place varchar(40),
learn_code int,
relationship varchar(15),

constraint purchase_pkey primary key(serial_numb),
constraint purchase_fkey1 foreign key(serial_numb)
	   references product(serial_numb),
constraint purchase_fkey2 foreign key(owner_numb)
	   references owner(owner_numb)
);

create table feature(
feature_code int,
feature_description varchar(40),

constraint feature_pkey primary key(feature_code)
);

create table purchase_feature(
serial_numb int,
feature_code int,

constraint purchase_feature_pkey primary key(serial_numb),
constraint purchase_feature_fkey1 foreign key(serial_numb)
	   references purchase(serial_numb),
constraint purchase_feature_fkey2 foreign key(feature_code)
	   references feature(feature_code)
);

create table learn_about(
learn_code int,
learn_description varchar(40),
serial_numb int,

constraint learn_about_pkey primary key(learn_code),
constraint learn_about_fkey foreign key(serial_numb)
	   references purchase(serial_numb)
);

create table problem_type(
problem_type_code int,
problem_type_description varchar(30),

constraint problem_type_pkey primary key(problem_type_code)
);

create table problem_report(
serial_numb int,
problem_date date,
problem_time time,
problem_type_code int,
problem_description varchar(40),

constraint problem_report_pkey primary key(serial_numb, problem_date),
constraint problem_report_fkey1 foreign key(serial_numb)
	   references product(serial_numb),
constraint problem_report_fkey2 foreign key(problem_type_code)
	  references problem_type(problem_type_code)
);
