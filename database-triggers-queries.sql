select * from customers
order by customer_id;

select * from customers_log;

create trigger update_customer_name
  before update on customers
  for each row
  when(OLD.first_name != NEW.first_name or OLD.last_name != NEW.last_name)
  execute procedure log_customers_change();


update customers
set first_name = 'John'
where last_name = 'Lewis';

update customers
set last_name = 'Gregory'
where first_name = 'Frances';

select * from customers
order by customer_id;

select * from customers_log;

update customers
set years_old = 45
where last_name = 'Hall';

select * from customers
order by customer_id;

select * from customers_log;

create trigger customer_insert
  after insert on customers
  for each statement
  execute procedure log_customers_change();

insert into customers(first_name, last_name, email_address, home_phone, city, state_name, years_old)
values('Jeffrey', 'Cook', 'Jeffrey.Cook@example.com', '202-555-0398', 'Jersey City', 'New Jersey', 66),
      ('Lisa', 'Truss', 'LTruss@example.com', '305-555-0635','Miami', 'Florida', 36),
      ('Viram', 'Kandesh', 'VK@example.com', '234-555-7643', 'Atlanta', 'Georgia', 47);

select * from customers
order by customer_id;

select * from customers_log;

create trigger customer_min_age
  before update on customers
  for each row
  when(NEW.years_old < 13)
  execute procedure override_with_min_age();

update customers
set years_old = 24
where last_name = 'Gregory';

update customers
set years_old = 11
where last_name = 'Lewis';

select * from customers
order by customer_id;

select * from customers_log;


update customers
set first_name = 'Harry', years_old = 32
where last_name = 'Hall';

select * from customers
order by customer_id;

select * from customers_log;

drop trigger customer_min_age on customers;

select * from information_schema.triggers;