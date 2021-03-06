USE dm;
DROP DATABASE dm;
SHOW TABLES;

-- all data
SELECT * FROM student_listings;
SELECT * FROM sl_phone;
SELECT * FROM sl_address;
SELECT * FROM faculty_and_staff;
SELECT * FROM fas_phone;
SELECT * FROM fas_address;
SELECT * FROM jail LIMIT 20;
SELECT * FROM jailx LIMIT 20;
SELECT * FROM jailx_address LIMIT 20;
SELECT * FROM jailx_charge LIMIT 20;
SELECT * FROM booking LIMIT 20;
SELECT id FROM booking WHERE mid_number=4411;
SELECT * FROM booking_address LIMIT 20;
SELECT * FROM booking_charge LIMIT 20;
SELECT * FROM booking_charge WHERE last_update IS NOT NULL;
SELECT * FROM booking_charge WHERE id=5;
SELECT * FROM booking_charge WHERE grade_of_charge="F";
SELECT * FROM jailx_charge where grade_of_charge='';

SELECT id FROM booking_charge WHERE booking_idx=4 AND booking_date='2014-03-06 05:19:00' AND charge_description='LOITERING/PROWLING';

-- partial sub-string match
SELECT * FROM booking_charge WHERE charge_description LIKE '%dog%';

-- remove data & reset auto increment id
TRUNCATE TABLE student_listings;
TRUNCATE TABLE sl_phone;
TRUNCATE TABLE sl_address;
TRUNCATE TABLE faculty_and_staff;
TRUNCATE TABLE fas_phone;
TRUNCATE TABLE fas_address;
TRUNCATE TABLE jail;
TRUNCATE TABLE jailx;
TRUNCATE TABLE jailx_address;
TRUNCATE TABLE jailx_charge;
TRUNCATE TABLE booking;
TRUNCATE TABLE booking_address;
TRUNCATE TABLE booking_charge;

-- allows truncate of a table with a foreign key
SET FOREIGN_KEY_CHECKS = 0;

SELECT * FROM student_listings PROCEDURE ANALYSE();
SELECT * FROM sl_phone PROCEDURE ANALYSE();
SELECT * FROM sl_address PROCEDURE ANALYSE();
SELECT * FROM faculty_and_staff PROCEDURE ANALYSE();
SELECT * FROM fas_phone PROCEDURE ANALYSE();
SELECT * FROM fas_address PROCEDURE ANALYSE();
SELECT * FROM jail PROCEDURE ANALYSE();
SELECT * FROM jailx PROCEDURE ANALYSE();
SELECT * FROM jailx_address PROCEDURE ANALYSE();
SELECT * FROM jailx_charge PROCEDURE ANALYSE();
SELECT * FROM booking PROCEDURE ANALYSE();
SELECT * FROM booking_address PROCEDURE ANALYSE();
SELECT * FROM booking_charge PROCEDURE ANALYSE();

SELECT COUNT(*) FROM student_listings;
SELECT COUNT(*) FROM faculty_and_staff;
SELECT COUNT(*) FROM booking;

-- Jail Extended Join
SELECT jailx.*, 
	jailx_address.street, jailx_address.city, jailx_address.state, jailx_address.zip, 
	jailx_charge.arresting_agency, jailx_charge.grade_of_charge, jailx_charge.charge_description, jailx_charge.disposition
FROM jailx
    JOIN jailx_address
        ON jailx.id = jailx_address.jailx_id
    JOIN jailx_charge
        ON jailx.id = jailx_charge.jailx_id_1
LIMIT 20;

-- Booking Join
SELECT booking.*,
	booking_charge.*
FROM booking
	JOIN booking_charge
		ON booking.id = booking_charge.booking_idx
LIMIT 20;

-- add 'charge_category'
ALTER TABLE `booking_charge` ADD charge_category VARCHAR(255) NULL AFTER `grade_of_charge`;
ALTER TABLE booking_charge DROP charge_category;
DESCRIBE booking_charge;

-- swap lastname and firstname
Alter table booking CHANGE lastnamee lastname VARCHAR(255);

-- delete height weight and photo
ALTER TABLE booking DROP photo;

-- add foreigh keys to
ALTER TABLE booking ADD sl_id  INT(10) unsigned DEFAULT NULL AFTER sex;
ALTER TABLE booking ADD fas_id  INT(10) unsigned DEFAULT NULL AFTER sl_id;

ALTER TABLE booking
ADD FOREIGN KEY (fas_id)
REFERENCES faculty_and_staff(id);