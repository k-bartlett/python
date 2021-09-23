Create Table customers(
	customer_id		BIGINT	PRIMARY KEY,
	name			VARCHAR,
	address			VARCHAR,
	city			VARCHAR,
	state			VARCHAR,
	zip_code			INT
);

-- drop table orders;
Create Table orders(
	order_id		BIGINT PRIMARY KEY,
	customer_id		BIGINT,
	type			VARCHAR,
	quantity		INT,
	retail_price	REAL,
	order_date		DATE
);





INSERT INTO customers (customer_id, name, address, city, state, zip_code) Values('1', 'John Doe', '123 Main St', 'Pittsburgh', 'PA', 15234);
INSERT INTO customers (customer_id, name, address, city, state, zip_code) Values('2', 'Jane Doe', '123 Main St', 'New York', 'NY', 15234);
INSERT INTO customers (customer_id, name, address, city, state, zip_code) Values('3', 'Bob Smith', '123 Main St', 'San Francisco', 'CA', 15234);
INSERT INTO customers (customer_id, name, address, city, state, zip_code) Values('4', 'Joe Johnson', '123 Main St', 'Miami', 'FL', 15234);
INSERT INTO customers (customer_id, name, address, city, state, zip_code) Values('5', 'Mary Smith', '123 Main St', 'San Diego', 'CA', 15234);
INSERT INTO customers (customer_id, name, address, city, state, zip_code) Values('6', 'Mary Doe', '123 Main St', 'Dallas', 'TX', 15234);
INSERT INTO customers (customer_id, name, address, city, state, zip_code) Values('7', 'Frank Doe', '123 Main St', 'San Jose', 'CA', 15234);
INSERT INTO customers (customer_id, name, address, city, state, zip_code) Values('8', 'Shelly Doe', '123 Main St', 'Miami', 'FL', 15234);
INSERT INTO customers (customer_id, name, address, city, state, zip_code) Values('9', 'Jan Doe', '123 Main St', 'Philadelphia', 'PA', 15234);
INSERT INTO customers (customer_id, name, address, city, state, zip_code) Values('10', 'Linda Doe', '123 Main St', 'San Antonio', 'TX', 15234);
INSERT INTO customers (customer_id, name, address, city, state, zip_code) Values('11', 'Mike Doe', '123 Main St', 'New York', 'NY', 15234);
INSERT INTO customers (customer_id, name, address, city, state, zip_code) Values('12', 'Carl Doe', '123 Main St', 'Sacramento', 'CA', 15234);



CREATE OR REPLACE FUNCTION dashboard_view (
	_state	VARCHAR DEFAULT NULL
)
RETURNS TABLE(
	type						VARCHAR,
	rank						INT,
	total_sold_in_last_year		INT,
	gross_sales					REAL,
	per_capita_sales			REAL,
	unique_customer_count		INT
)
AS
$BODY$
SELECT type, rank, total_sold_in_last_year, gross_sales, per_capita_sales, unique_customer_count from (
SELECT
o.type
, rank() OVER (ORDER BY sum(quantity) DESC)::INT as rank
, sum(quantity)::int AS total_sold_in_last_year
, sum(retail_price*quantity)::REAL as gross_sales
, (sum(retail_price*quantity) / count(distinct o.customer_id))::REAL as per_capita_sales
, count(distinct o.customer_id)::INT AS unique_customer_count
FROM ORDERS o
inner join customers c on c.customer_id = o.customer_id
where order_date >= current_date - INTERVAL '1 Year'
AND  c.state = _state
group by o.type) subquery
WHERE rank <= 3
$BODY$
Language SQL;

select * from orders;
select * from customers;
select * from dashboard_view();
select * from dashboard_view(_state:='CA');
select * from dashboard_view(_state:='PA');