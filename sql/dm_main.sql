USE dm;
SHOW TABLES;

-- all data
SELECT * FROM student_listings LIMIT 20;
SELECT * FROM faculty_and_staff LIMIT 20;
SELECT * FROM booking LIMIT 20;
SELECT * FROM booking_charge LIMIT 20;

-- Row Counter
SELECT COUNT(*) FROM student_listings;
SELECT COUNT(*) FROM faculty_and_staff;
SELECT COUNT(*) FROM booking;
SELECT COUNT(*) FROM booking_charge;

-- Select latest row updates
SELECT * FROM booking_charge ORDER BY last_update DESC LIMIT 50;


-- Booking & Charge Join
SELECT booking.mid_number, booking.lastname, booking.firstname, booking.year_of_birth, booking.race, booking.sex,
	booking_charge.booking_date, booking_charge.released_date, booking_charge.arresting_agency, booking_charge.grade_of_charge,
	booking_charge.charge_description, booking_charge.court_jurisdiction, booking_charge.bonding_company, booking_charge.bond_amount,
	booking_charge.warrant_number, booking_charge.police_case_number
FROM booking
JOIN booking_charge
	ON booking.id = booking_charge.booking_idx
;

select * from booking where firstname like '%ariel%' limit 20;

select * from booking_charge where charge_description like '%terr%' limit 20;
select * from booking_charge where booking_idx = 5176;



-- ------------------------------
-- WARNING -- WARNING -- WARNING
-- ------------------------------
DROP DATABASE dm;
-- remove data & reset auto increment id
/*
TRUNCATE TABLE student_listings;
TRUNCATE TABLE faculty_and_staff;
TRUNCATE TABLE booking;
TRUNCATE TABLE booking_charge;
*/
-- ------------------------------
-- WARNING -- WARNING -- WARNING
-- ------------------------------

-- allows truncate of a table with a foreign key
SET FOREIGN_KEY_CHECKS = 0;

-- Analyze Data Allocations
SELECT * FROM student_listings PROCEDURE ANALYSE();
SELECT * FROM faculty_and_staff PROCEDURE ANALYSE();
SELECT * FROM booking PROCEDURE ANALYSE();
SELECT * FROM booking_charge PROCEDURE ANALYSE();
