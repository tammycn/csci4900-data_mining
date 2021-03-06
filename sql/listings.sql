SELECT * FROM faculty_and_staff WHERE lastname LIKE '%Donnell%';
SELECT * FROM student_listings WHERE lastname LIKE '%lazar%';

-- EXACT MATCHES
-- ---------------------------
-- Exact Match Students
SELECT student_listings.firstname, student_listings.lastname, booking.firstname, booking.lastname
FROM booking,student_listings WHERE booking.lastname=student_listings.lastname AND booking.firstname=student_listings.firstname;
-- Set foreign key if it matches Students
UPDATE booking, student_listings SET booking.sl_id=student_listings.id 
WHERE booking.lastname=student_listings.lastname AND booking.firstname=student_listings.firstname;

-- Exact Match Faculty
SELECT faculty_and_staff.firstname, faculty_and_staff.lastname, booking.firstname, booking.lastname
FROM booking,faculty_and_staff WHERE booking.lastname=faculty_and_staff.lastname AND faculty_and_staff.firstname=booking.firstname;
-- Set foreign key if it matches Faculty
UPDATE booking, faculty_and_staff SET booking.fas_id=faculty_and_staff.id 
WHERE booking.lastname=faculty_and_staff.lastname AND booking.firstname=faculty_and_staff.firstname;




-- PARTIAL MATCHES (same first name, manual filtering)
-- ---------------------------
-- Non-Exact Match Students
SELECT booking.id, booking.firstname, student_listings.firstname, booking.lastname, student_listings.id, student_listings.lastname
FROM booking,student_listings
WHERE booking.lastname=student_listings.lastname AND student_listings.firstname LIKE CONCAT(SUBSTRING_INDEX(booking.firstname, ' ', 1), '%')
AND booking.sl_id IS NULL AND booking.fas_id IS NULL
AND booking.id NOT IN(1096,290,7,64,44,9,132,234,182,203,211,303,334,365,432,470,516,514,455,548,542,547,550,608,625,773,731,754,730,752,873,844,883,831,804,906,916,911,982,1054,983,1105,1141,1160,1200,1211,1318,1326,1419,1418,1398,1403,1431,1487,1505,1469,1550,1576,1534,1717,1671,1795,1750,1753,1733,1809,1774,1801,1885)
AND student_listings.id NOT IN(8269,3842);

-- Set foreign key if it matches Students
UPDATE booking, student_listings SET booking.sl_id=student_listings.id 
WHERE booking.lastname=student_listings.lastname AND student_listings.firstname LIKE CONCAT(SUBSTRING_INDEX(booking.firstname, ' ', 1), '%')
AND booking.sl_id IS NULL AND booking.fas_id IS NULL
AND booking.id NOT IN(1096,290,7,64,44,9,132,234,182,203,211,303,334,365,432,470,516,514,455,548,542,547,550,608,625,773,731,754,730,752,873,844,883,831,804,906,916,911,982,1054,983,1105,1141,1160,1200,1211,1318,1326,1419,1418,1398,1403,1431,1487,1505,1469,1550,1576,1534,1717,1671,1795,1750,1753,1733,1809,1774,1801,1885)
AND student_listings.id NOT IN(8269,3842);

-- Non-Exact Match Faculty
SELECT booking.id, booking.firstname, booking.lastname, faculty_and_staff.id, faculty_and_staff.firstname, faculty_and_staff.lastname
FROM booking,faculty_and_staff
WHERE booking.lastname=faculty_and_staff.lastname AND faculty_and_staff.firstname LIKE CONCAT(SUBSTRING_INDEX(booking.firstname, ' ', 1), '%')
AND booking.sl_id IS NULL AND booking.fas_id IS NULL
AND booking.id NOT IN(84, 64, 168, 250, 436, 600, 542, 533, 773, 752, 819, 906, 916, 1671, 1505, 1165, 1141, 1058, 984, 982, 905, 1885, 7, 682)
AND faculty_and_staff.id NOT IN(295, 374);
-- Set foreign key if it matches Faculty
UPDATE booking, faculty_and_staff SET booking.fas_id=faculty_and_staff.id 
WHERE booking.lastname=faculty_and_staff.lastname AND faculty_and_staff.firstname LIKE CONCAT(SUBSTRING_INDEX(booking.firstname, ' ', 1), '%')
AND booking.sl_id IS NULL AND booking.fas_id IS NULL
AND booking.id NOT IN(84, 64, 168, 250, 436, 600, 542, 533, 773, 752, 819, 906, 916, 1671, 1505, 1165, 1141, 1058, 984, 982, 905, 1885, 7, 682)
AND faculty_and_staff.id NOT IN(295, 374);

-- ALL UGA charges
SELECT * FROM booking_charge WHERE booking_idx IN ( 
	SELECT id FROM booking WHERE sl_id IS NOT NULL OR fas_id IS NOT NULL);
-- All Student charges
SELECT * FROM booking_charge WHERE booking_idx IN ( 
	SELECT id FROM booking WHERE sl_id IS NOT NULL);
-- All Faculty charges
SELECT * FROM booking_charge WHERE booking_idx IN ( 
	SELECT id FROM booking WHERE fas_id IS NOT NULL);

-- Arresting Agency Student
SELECT arresting_agency, COUNT(*) FROM booking_charge WHERE booking_idx IN ( 
	SELECT id FROM booking WHERE sl_id IS NOT NULL) GROUP BY arresting_agency;
-- Arresting Faculty Faculty
SELECT arresting_agency, COUNT(*) FROM booking_charge WHERE booking_idx IN ( 
	SELECT id FROM booking WHERE fas_id IS NOT NULL) GROUP BY arresting_agency;
-- Arresting Agency NOT Student or Faculty
SELECT arresting_agency, COUNT(*) FROM booking_charge WHERE booking_idx IN ( 
	SELECT id FROM booking WHERE sl_id IS NULL AND fas_id IS NULL) GROUP BY arresting_agency;
-- Arresting Agency UGA
SELECT arresting_agency, COUNT(*) FROM booking_charge WHERE booking_idx IN ( 
	SELECT id FROM booking WHERE sl_id IS NOT NULL OR fas_id IS NOT NULL) GROUP BY arresting_agency;
-- Arresting Agency ALL
SELECT arresting_agency, COUNT(*) FROM booking_charge GROUP BY arresting_agency;

-- Number of Charges
-- Student
SELECT arresting_agency, COUNT(*) FROM (
	SELECT * FROM booking_charge WHERE booking_idx IN ( 
		SELECT id FROM booking WHERE sl_id IS NOT NULL)
	-- change count to vary # of charges   +
	GROUP BY booking_idx HAVING COUNT(*) = 1) alias
GROUP BY arresting_agency;
-- Faculty
SELECT arresting_agency, COUNT(*) FROM (
	SELECT * FROM booking_charge WHERE booking_idx IN ( 
		SELECT id FROM booking WHERE fas_id IS NOT NULL)
	-- change count to vary # of charges   +
	GROUP BY booking_idx HAVING COUNT(*) = 1) alias
GROUP BY arresting_agency;

-- this a bad nigga
SELECT * FROM booking_charge WHERE booking_idx = 1629;
-- this provides his birf name and info
SELECT booking.*, booking_charge.*
FROM booking
	JOIN booking_charge
		ON booking.id = booking_charge.booking_idx
WHERE booking_idx= 1629;

-- all charges most popular
SELECT charge_description, COUNT(*) FROM booking_charge GROUP BY charge_description;

-- charges per date
SELECT CHAR(SUBSTRING_INDEX(CHAR(booking_date), ' ', 1)), COUNT(*) FROM booking_charge GROUP BY SUBSTRING_INDEX(booking_date, ' ', 1);

-- people arrested per day
SELECT DATE(booking_date) AS ForDate, COUNT(*) AS NumArrests
FROM (SELECT * FROM booking_charge GROUP BY booking_idx HAVING COUNT(*) < 100) as a
GROUP BY DATE(booking_date)
ORDER BY ForDate;

-- time in jail
SELECT TIMESTAMPDIFF(MINUTE, booking_date, released_date) as alias, COUNT(*)  FROM booking_charge WHERE released_date IS NOT NULL group by alias;

SELECT * FROM booking_charge where booking_date LIKE '2014-01-30%';

-- Students
SELECT booking.*,
	student_listings.*
FROM booking
	JOIN student_listings
		ON booking.sl_id = student_listings.id
LIMIT 20;

-- Faculty
SELECT booking.*,
	faculty_and_staff.*
FROM booking
	JOIN faculty_and_staff
		ON booking.fas_id = faculty_and_staff.id
LIMIT 20;

-- non student or faculty arrested
SELECT count(*) FROM booking WHERE fas_id IS NULL AND sl_id IS NULL;
--  or faculty arrested
SELECT count(*) FROM booking WHERE fas_id IS NOT NULL OR sl_id IS NOT NULL;


SELECT SUBSTRING_INDEX(firstname , ' ', 1) AS alias
FROM  booking;


-- EXPORT
SELECT * FROM booking WHERE fas_id IS NOT NULL;