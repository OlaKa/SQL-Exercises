Use Sakila;


-- Skapa trigger för ny kund
DELIMITER //

create trigger NewCustomerFreeFilm after insert on customer
	for each row
    begin
    
		insert into rental (rental_date, inventory_id, customer_id,staff_id)
			values(Current_date(),1, new.customer_id,1);
    
    end //

DELIMITER ;


-- testa ovan

insert into customer (store_id,first_name,last_name, email,address_id,active) 
	VALUES (1, 'John','Doe','john@doe.com',5,1);
    
SELECT * FROM rental where customer_id = (select max(customer_id) FROM customer);


-- ///////////// EVENT
SHOW processlist;

set global event_scheduler = ON;

create event AutoReturn 
	on schedule at current_timestamp + interval 10 minute
    DO
		update rental set return_date = current_date() where customer_id = 600;
        
show events;

select * from rental where customer_id = 600;
