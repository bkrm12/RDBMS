
SPOOL  output.txt REPLACE

DROP TABLE movies CASCADE CONSTRAINTS;
DROP TABLE movie_awards CASCADE CONSTRAINTS;
DROP TABLE awards CASCADE CONSTRAINTS;
DROP TABLE movie_actors CASCADE CONSTRAINTS;
DROP TABLE actors CASCADE CONSTRAINTS;
DROP TABLE companies CASCADE CONSTRAINTS;
DROP TABLE movie_producers CASCADE CONSTRAINTS;
DROP TABLE producers CASCADE CONSTRAINTS;
DROP TABLE movie_distributors CASCADE CONSTRAINTS;
DROP TABLE distributed_movie_list CASCADE CONSTRAINTS;
DROP TABLE orders CASCADE CONSTRAINTS;
DROP TABLE order_items CASCADE CONSTRAINTS;
DROP TABLE movie_rental_stores CASCADE CONSTRAINTS;
DROP TABLE customers CASCADE CONSTRAINTS;
DROP TABLE movie_renting_list CASCADE CONSTRAINTS;
DROP TABLE movie_rent_records CASCADE CONSTRAINTS;
DROP TABLE movie_copies CASCADE CONSTRAINTS;






remark Creates Tables

CREATE TABLE movie_copies
(
	copy_id number(5),
	title_id number(5),
	available char(1) NOT NULL,
	PRIMARY KEY (copy_id)
 
  );
      
CREATE TABLE movie_rent_records
(
rent_record_id	NUMBER(8),	
customer_id	NUMBER(5),
copy_id		NUMBER(5),
rented_date	DATE NOT NULL,
returned_date	DATE NOT NULL,
rent_fee	NUMBER(5,2) NOT NULL,	
overdue_fee	NUMBER(5,2) NOT NULL,			
overdue_days	NUMBER(5) NOT NULL,	
PRIMARY KEY(rent_record_id)

);

CREATE TABLE movie_renting_list(
title_id		NUMBER(5),	
movie_id		NUMBER(5),	
store_id		NUMBER(4),	
number_in_store		NUMBER(2) NOT NULL,
available_for_rent	CHAR(1) NOT NULL,
rent_unit_price		NUMBER(5,2) NOT NULL,	
type_distributed	VARCHAR2(10) NOT NULL,
overdue_unit_fee	NUMBER(5,2) NOT NULL,
CONSTRAINT movie_renting_list_pk PRIMARY KEY(title_id)

);

CREATE TABLE customers(
customer_id	NUMBER(5),
store_id		NUMBER(4),
first_name		VARCHAR2(20) NOT NULL,
last_name		VARCHAR2(20) NOT NULL,
gender			CHAR(1) NOT NULL,
street			VARCHAR2(20) NOT NULL,
city        VARCHAR2(20) NOT NULL,
state       VARCHAR2(2) NOT NULL,
zip         VARCHAR2(10) NOT NULL,
phone_number		VARCHAR2(10) UNIQUE NOT NULL,
card_number		NUMBER(16),
card_approved		CHAR(1),
approved_date		DATE,
overdue_notified	CHAR(1) NOT NULL,
rent_limit		NUMBER(2) NOT NULL,
CONSTRAINT customers_pk PRIMARY KEY(customer_id)


);

CREATE TABLE movie_rental_stores(
store_id	NUMBER(4),
location	VARCHAR2(50),
name		VARCHAR2(30) NOT NULL,
CONSTRAINT movie_rental_stores_pk PRIMARY KEY(store_id)

);

CREATE TABLE order_items(
item_id			NUMBER(10),	
order_id		NUMBER(8),
distribution_id		NUMBER(8),	
number_of_items		NUMBER(3) NOT NULL,	
item_unit_price		NUMBER(5) NOT NULL,	
item_sub_total		NUMBER(10) NOT NULL,		
CONSTRAINT order_items_pk PRIMARY KEY(item_id)

);

CREATE TABLE orders(
order_id		NUMBER(8),	
store_id		NUMBER(4),
total_items		NUMBER(3) NOT NULL,
total_payment		NUMBER(8,2) NOT NULL,	
tax			NUMBER(6,2) NOT NULL,	
order_status		VARCHAR2(22) NOT NULL,	
ordering_date		DATE NOT NULL,	
order_completed_date	DATE NOT NULL,
CONSTRAINT orders_pk PRIMARY KEY(order_id)


);

CREATE TABLE distributed_movie_list(
distribution_id		NUMBER(8),
movie_id		NUMBER(5),
distributor_id		NUMBER(3),
distribute_type		VARCHAR2(10) NOT NULL,
inventory_amount	NUMBER(3) NOT NULL,
unit_price		NUMBER(8,2) NOT NULL,
CONSTRAINT dist_mov_list_pk PRIMARY KEY(distribution_id)


);

CREATE TABLE movie_distributors(
distributor_id	NUMBER(3),
company_name		VARCHAR2(30) NOT NULL,
location		VARCHAR2(30),
contact			VARCHAR2(10) NOT NULL,
CONSTRAINT movie_distributors_pk PRIMARY KEY(distributor_id)

);

CREATE TABLE producers(
producer_id	NUMBER(5),
company_id		NUMBER(3),
name			VARCHAR2(30) NOT NULL,
CONSTRAINT producers_pk PRIMARY KEY(producer_id)


);

CREATE TABLE movie_producers(
movie_producer_id	NUMBER(5),		
movie_id		NUMBER(5),
producer_id	NUMBER(5),
CONSTRAINT movie_producers_pk PRIMARY KEY(movie_producer_id)

);

CREATE TABLE companies(
company_id		NUMBER(3),
name			VARCHAR2(30) NOT NULL,
description		VARCHAR2(100),
CONSTRAINT companies_pk PRIMARY KEY(company_id)

);

CREATE TABLE actors(
actor_id	NUMBER(5),
name		VARCHAR2(30) NOT NULL,
gender		CHAR(1),
contact		VARCHAR2(30),	
CONSTRAINT actors_pk PRIMARY KEY(actor_id)

);

CREATE TABLE movie_actors(
movie_actor_id	NUMBER(5),	
movie_id		NUMBER(5),
actor_id		NUMBER(5),
role			VARCHAR2(20) NOT NULL,
CONSTRAINT movie_actors_pk PRIMARY KEY(movie_actor_id)


);

CREATE TABLE awards(
award_id		NUMBER(3),
award			VARCHAR2(30) NOT NULL,
award_description	VARCHAR2(100),
CONSTRAINT awards_pk PRIMARY KEY(award_id)

);

CREATE TABLE movie_awards(
movie_award_id		NUMBER(5),
movie_id		NUMBER(5),
award_id		NUMBER(3),
award_to_date		NUMBER(2),
CONSTRAINT movie_awards_pk PRIMARY KEY(movie_award_id)

);

CREATE TABLE movies(
movie_id		NUMBER(5),
company_id		NUMBER(3),
title			VARCHAR2(30) NOT NULL,
category		VARCHAR2(18),	
description		VARCHAR2(100),	
released_on		DATE,
CONSTRAINT movies_pk PRIMARY KEY(movie_id)
 
);




remark Creates Foreign keys 

ALTER TABLE movie_copies
	ADD FOREIGN KEY (title_id)
	REFERENCES movie_renting_list (title_id)
;

ALTER TABLE movie_rent_records
	ADD FOREIGN KEY (customer_id)
	REFERENCES customers (customer_id)
  
	ADD FOREIGN KEY (copy_id)
	REFERENCES movie_copies (copy_id)

;

ALTER TABLE movie_renting_list
	ADD FOREIGN KEY (movie_id)
	REFERENCES movies (movie_id)

	ADD FOREIGN KEY (store_id)
	REFERENCES movie_rental_stores (store_id)
;

ALTER TABLE customers
	ADD FOREIGN KEY (store_id)
	REFERENCES movie_rental_stores (store_id)
;

ALTER TABLE order_items
	ADD FOREIGN KEY (order_id)
	REFERENCES orders (order_id)

	ADD FOREIGN KEY (distribution_id)
	REFERENCES distributed_movie_list (distribution_id)
;

ALTER TABLE orders
	ADD FOREIGN KEY (store_id)
	REFERENCES movie_rental_stores (store_id)
;

ALTER TABLE distributed_movie_list
	ADD FOREIGN KEY (movie_id)
	REFERENCES movies (movie_id)
  
	ADD FOREIGN KEY (distributor_id)
	REFERENCES movie_distributors (distributor_id)
;

ALTER TABLE producers
	ADD FOREIGN KEY (company_id)
	REFERENCES companies (company_id)
;

ALTER TABLE movie_producers
	ADD FOREIGN KEY (movie_id)
	REFERENCES movies (movie_id)

	ADD FOREIGN KEY (producer_id)
	REFERENCES producers (producer_id)

;

ALTER TABLE movie_actors
	ADD FOREIGN KEY (movie_id)
	REFERENCES movies (movie_id)

	ADD FOREIGN KEY (actor_id)
	REFERENCES actors (actor_id)
;

ALTER TABLE movie_awards
	ADD FOREIGN KEY (movie_id)
	REFERENCES movies (movie_id)
 
	ADD FOREIGN KEY (award_id)
	REFERENCES awards (award_id)

;
ALTER TABLE movies
	ADD FOREIGN KEY (company_id)
	REFERENCES companies (company_id)
;




remark inserts data into tables

INSERT INTO movies (movie_id, title, category, description, released_on) VALUES ('20325', 'The Terminator', 'action', 'A robot is sent into the past to protect a child', '08-MAR-1983');
INSERT INTO movies (movie_id, title, category, description, released_on) VALUES ('67676', 'Rocky', 'action', 'Is the will of one man enough to overcome great odds?', '12-MAR-1989');
INSERT INTO movies (movie_id, title, category, description, released_on) VALUES ('87355', 'The Wizard of Oz', 'adventure', 'A sheltered woman ventures through Oz to get help finding her way back to Kansas', '02-JAN-1939');
INSERT INTO movies (movie_id, title, category, description, released_on) VALUES ('53202', 'Christmas Vacation', 'adventure', 'A family decides to travel for Christmas and things go hilariously wrong', '04-FEB-1985');
INSERT INTO movies (movie_id, title, category, description, released_on) VALUES ('53235', 'A Christmas Story', 'drama', 'All a boy wants for Christmas is a Red Ryder BB gun', '04-SEP-1941');


INSERT INTO movie_awards (movie_award_id, award_to_date) VALUES ('45457', '2');
INSERT INTO movie_awards (movie_award_id, award_to_date) VALUES ('45212', '7');
INSERT INTO movie_awards (movie_award_id, award_to_date) VALUES ('45452', '1');
INSERT INTO movie_awards (movie_award_id, award_to_date) VALUES ('45555', '3');
INSERT INTO movie_awards (movie_award_id, award_to_date) VALUES ('45207', '2');

INSERT INTO awards (award_id, award, award_description) VALUES ('213', 'Outstanding Actor', 'Awarded to the best overall actor.');
INSERT INTO awards (award_id, award, award_description) VALUES ('252', 'Best Supporting Actor', 'Awarded to the best supporting actor.');
INSERT INTO awards (award_id, award, award_description) VALUES ('897', 'Cinemetography', 'Awarded to the best cinemetography.');
INSERT INTO awards (award_id, award, award_description) VALUES ('242', 'Best Lead', 'Awarded to the best lead.');
INSERT INTO awards (award_id, award, award_description) VALUES ('545', 'Best Screenplay', 'Awarded to the best original screenplay.');


INSERT INTO movie_actors (movie_actor_id, role) VALUES ('45641', 'Lead');
INSERT INTO movie_actors (movie_actor_id, role) VALUES ('54999', 'Extra');
INSERT INTO movie_actors (movie_actor_id, role) VALUES ('54653', 'Lead');
INSERT INTO movie_actors (movie_actor_id, role) VALUES ('58784', 'Supporting actor');
INSERT INTO movie_actors (movie_actor_id, role) VALUES ('54654', 'Special guest');

INSERT INTO actors (actor_id, name, gender, contact) VALUES ('54642', 'Brad Pitt', 'M', '8772365858');
INSERT INTO actors (actor_id, name, gender, contact) VALUES ('25320', 'Billy bob Thornton', 'M', '6953265885');
INSERT INTO actors (actor_id, name, gender, contact) VALUES ('12487', 'Angelina Jolie', 'F', '8547852012');
INSERT INTO actors (actor_id, name, gender, contact) VALUES ('65895', 'Jennier Aniston', 'F', '2021548569');
INSERT INTO actors (actor_id, name, gender, contact) VALUES ('02558', 'Colin Ferrell', 'M', '9658932644');

INSERT INTO companies (company_id, name, description) VALUES ('564', 'Hollywood Films', 'The oldest running film production company in the world.');
INSERT INTO companies (company_id, name, description) VALUES ('567', 'Film Mountain', 'Hard hitting newcomer with quality films.');
INSERT INTO companies (company_id, name, description) VALUES ('520', 'Hollywood Films', 'The oldest running film production company in the world.');
INSERT INTO companies (company_id, name, description) VALUES ('514', 'Big Motion Pictures', 'Responsible for some of the biggest films of the 20th century.');
INSERT INTO companies (company_id, name, description) VALUES ('560', 'Socal Productions', 'Low budget film makers');

INSERT INTO movie_producers (movie_producer_id) VALUES ('84845');
INSERT INTO movie_producers (movie_producer_id) VALUES ('85411');
INSERT INTO movie_producers (movie_producer_id) VALUES ('12133');
INSERT INTO movie_producers (movie_producer_id) VALUES ('33555');
INSERT INTO movie_producers (movie_producer_id) VALUES ('86897');

INSERT INTO producers (producer_id, name) VALUES ('02555', 'Big Motion Pictures');
INSERT INTO producers (producer_id, name) VALUES ('02185', 'Hollywood Films');
INSERT INTO producers (producer_id, name) VALUES ('12474', 'Worldwide Productions');
INSERT INTO producers (producer_id, name) VALUES ('36988', 'Film Mountain');
INSERT INTO producers (producer_id, name) VALUES ('69655', 'SoCal Productions');

INSERT INTO movie_distributors (distributor_id, company_name, location, contact) VALUES ('985', 'The Video Store', 'Orlando, FL', '4484434841');
INSERT INTO movie_distributors (distributor_id, company_name, location, contact) VALUES ('415', 'Video Rental World', 'Orlando, FL', '4484430236');
INSERT INTO movie_distributors (distributor_id, company_name, location, contact) VALUES ('205', 'Video Heaven', 'Tallahassee, FL', '9419514345');
INSERT INTO movie_distributors (distributor_id, company_name, location, contact) VALUES ('025', 'Grab the popcorn', 'Miami, FL', '4484433685');
INSERT INTO movie_distributors (distributor_id, company_name, location, contact) VALUES ('524', 'Mom and Pop Video Store', 'Pensacola ,FL', '5151561689');

INSERT INTO distributed_movie_list (distribution_id, distribute_type, inventory_amount, unit_price) VALUES ('45585285', 'Package', '225', '70.74');
INSERT INTO distributed_movie_list (distribution_id, distribute_type, inventory_amount, unit_price) VALUES ('45552874', 'Package', '138', '99.42');
INSERT INTO distributed_movie_list (distribution_id, distribute_type, inventory_amount, unit_price) VALUES ('45531021', 'Package', '42', '58.85');
INSERT INTO distributed_movie_list (distribution_id, distribute_type, inventory_amount, unit_price) VALUES ('45596124', 'Individual', '1', '12.38');
INSERT INTO distributed_movie_list (distribution_id, distribute_type, inventory_amount, unit_price) VALUES ('45541424', 'Package', '256', '70.12');

INSERT INTO orders (order_id, total_items, total_payment, tax, order_status, ordering_date, order_completed_date) VALUES ('45644513', '3', '06.24', '00.24', 'Complete', '01-OCT-2016', '02-OCT-2016');
INSERT INTO orders (order_id, total_items, total_payment, tax, order_status, ordering_date, order_completed_date) VALUES ('45643699', '2', '04.16', '00.16', 'Complete', '12-JUN-2016', '13-JUN-2016');
INSERT INTO orders (order_id, total_items, total_payment, tax, order_status, ordering_date, order_completed_date) VALUES ('45640202', '1', '02.08', '00.08', 'Complete', '23-AUG-2016', '25-AUG-2016');
INSERT INTO orders (order_id, total_items, total_payment, tax, order_status, ordering_date, order_completed_date) VALUES ('45643025', '3', '06.24', '00.24', 'Complete', '21-MAY-2016', '21-MAY-2016');
INSERT INTO orders (order_id, total_items, total_payment, tax, order_status, ordering_date, order_completed_date) VALUES ('45641505', '1', '02.08', '00.08', 'Complete', '18-JUN-2016', '19-JUN-2016');

INSERT INTO order_items (item_id, number_of_items, item_unit_price, item_sub_total) VALUES ('3265854587', '100', '2.00', '200.00');
INSERT INTO order_items (item_id, number_of_items, item_unit_price, item_sub_total) VALUES ('3265530258', '12', '2.00', '24.00');
INSERT INTO order_items (item_id, number_of_items, item_unit_price, item_sub_total) VALUES ('3265852620', '48', '2.00', '96.00');
INSERT INTO order_items (item_id, number_of_items, item_unit_price, item_sub_total) VALUES ('3265024515', '16', '2.00', '30.00');
INSERT INTO order_items (item_id, number_of_items, item_unit_price, item_sub_total) VALUES ('3265027466', '80', '2.00', '160.00');

INSERT INTO movie_rental_stores (store_id, location, name) VALUES ('9895', 'Orlando', 'Bob Video Store');
INSERT INTO movie_rental_stores (store_id, location, name) VALUES ('9364', 'Jacksonville', 'We Have It All Video Store');
INSERT INTO movie_rental_stores (store_id, location, name) VALUES ('9445', 'Orlando', 'Tom and Nancy Video Store');
INSERT INTO movie_rental_stores (store_id, location, name) VALUES ('9877', 'Miami', 'The Super Video Store');
INSERT INTO movie_rental_stores (store_id, location, name) VALUES ('9120', 'Tallahassee', 'The Big Video Store');

INSERT INTO customers (customer_id, first_name, last_name, gender, street, city, state, zip, phone_number, card_number, card_approved, approved_date, overdue_notified, rent_limit) VALUES ('45876', 'George', 'Edwards', 'M', '112 Elm st', 'Orlando', 'FL', '34554', '8439543855', '5441358468943165', 'Y', '01-JUN-2016', 'Y', '5');
INSERT INTO customers (customer_id, first_name, last_name, gender, street, city, state, zip, phone_number, card_number, card_approved, approved_date, overdue_notified, rent_limit) VALUES ('45216', 'Brittany', 'Ryan', 'F', '185 Dorchester rd', 'Orlando', 'FL', '34554', '8439536455', '5441358468323569', 'Y', '08-MAR-2016', 'Y', '3');
INSERT INTO customers (customer_id, first_name, last_name, gender, street, city, state, zip, phone_number, card_number, card_approved, approved_date, overdue_notified, rent_limit) VALUES ('43626', 'Rose', 'Smith', 'F', '1992 Round tree dr', 'Tallahassee', 'FL', '35785', '8439142355', '5441358468632144', 'Y', '07-AUG-2016', 'N', '5');
INSERT INTO customers (customer_id, first_name, last_name, gender, street, city, state, zip, phone_number, card_number, card_approved, approved_date, overdue_notified, rent_limit) VALUES ('48874', 'Ed', 'Washington', 'M', '655 Western drive', 'Tallahassee', 'FL', '35785', '8439585723', '5441358468215784', 'Y', '10-OCT-2016', 'Y', '3');
INSERT INTO customers (customer_id, first_name, last_name, gender, street, city, state, zip, phone_number, card_number, card_approved, approved_date, overdue_notified, rent_limit) VALUES ('45334', 'Adam', 'Knight', 'M', '323 Oak blvd', 'Orlando', 'FL', '34554', '8439865746', '5441358468936266', 'Y', '11-JAN-2016', 'Y', '5');

INSERT INTO movie_renting_list (title_id, number_in_store, available_for_rent, rent_unit_price, type_distributed, overdue_unit_fee) VALUES ('54646', '12', 'Y', '3.99', 'VIDEO/DVD', '3.00');
INSERT INTO movie_renting_list (title_id, number_in_store, available_for_rent, rent_unit_price, type_distributed, overdue_unit_fee) VALUES ('54252', '18', 'Y', '3.99', 'VIDEO/DVD', '3.00');
INSERT INTO movie_renting_list (title_id, number_in_store, available_for_rent, rent_unit_price, type_distributed, overdue_unit_fee) VALUES ('54725', '12', 'Y', '3.99', 'VIDEO/DVD', '3.00');
INSERT INTO movie_renting_list (title_id, number_in_store, available_for_rent, rent_unit_price, type_distributed, overdue_unit_fee) VALUES ('57527', '18', 'Y', '3.99', 'VIDEO/DVD', '3.00');
INSERT INTO movie_renting_list (title_id, number_in_store, available_for_rent, rent_unit_price, type_distributed, overdue_unit_fee) VALUES ('54485', '12', 'Y', '3.99', 'VIDEO/DVD', '3.00');

INSERT INTO movie_rent_records (rent_record_id, rented_date, returned_date, rent_fee, overdue_fee, overdue_days) VALUES ('94641858', '22-MAR-2015', '25-MAR-2015', '3.99', '0.00', '0');
INSERT INTO movie_rent_records (rent_record_id, rented_date, returned_date, rent_fee, overdue_fee, overdue_days) VALUES ('94645353', '14-MAY-2015', '19-MAY-2015', '1.99', '6.00', '2');
INSERT INTO movie_rent_records (rent_record_id, rented_date, returned_date, rent_fee, overdue_fee, overdue_days) VALUES ('94648686', '16-MAY-2015', '18-MAY-2015', '1.99', '0.00', '0');
INSERT INTO movie_rent_records (rent_record_id, rented_date, returned_date, rent_fee, overdue_fee, overdue_days) VALUES ('94644282', '05-SEP-2015', '12-SEP-2015', '3.99', '12.00', '4');
INSERT INTO movie_rent_records (rent_record_id, rented_date, returned_date, rent_fee, overdue_fee, overdue_days) VALUES ('94641424', '10-OCT-2015', '11-OCT-2015', '1.99', '0.00', '0');

INSERT INTO movie_copies (copy_id, available) VALUES ('42424', 'Y');
INSERT INTO movie_copies (copy_id, available) VALUES ('18464', 'Y');
INSERT INTO movie_copies (copy_id, available) VALUES ('17521', 'N');
INSERT INTO movie_copies (copy_id, available) VALUES ('14578', 'Y');
INSERT INTO movie_copies (copy_id, available) VALUES ('18735', 'N');

SPOOL OFF

