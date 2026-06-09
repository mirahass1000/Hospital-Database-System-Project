-- 3 Views
-- View 1
CREATE VIEW room_status_view AS
SELECT r.room_no, r.capacity, COUNT(p.patient_id) AS current_occupancy
FROM rooms r
LEFT JOIN patient p ON r.room_no = p.room_no
GROUP BY r.room_no;

-- View 2
CREATE VIEW nurse_patient_view AS
SELECT n.name AS nurse_name, COUNT(gm.patient_id) AS number_of_patients
FROM nurse n
LEFT JOIN gives_med gm ON n.nurse_id = gm.nurse_id
GROUP BY n.nurse_id;


-- View 3
CREATE VIEW patient_medication_view AS
SELECT pt.name AS patient_name, COUNT(gm.medication_id) AS number_of_medications
FROM patient pt
JOIN gives_med gm ON pt.patient_id = gm.patient_id
GROUP BY pt.patient_id;

-- 3 Triggers

-- Trigger 1

DELIMITER //
CREATE TRIGGER new_patient_room_assignment
AFTER INSERT ON patient
FOR EACH ROW
BEGIN
    UPDATE rooms SET capacity = capacity - 1 WHERE room_no = NEW.room_no;
end //
DELIMITER ;

-- Trigger 2
DELIMITER //
CREATE TRIGGER new_payment_trigger
AFTER INSERT ON payment
FOR EACH ROW
BEGIN
    UPDATE invoice SET total_amount = total_amount - NEW.amount WHERE invoice_id = NEW.invoice_id;
END //
DELIMITER ;

-- Trigger 3
DELIMITER //
CREATE TRIGGER room_fee_update
AFTER UPDATE ON rooms
FOR EACH ROW
BEGIN
    UPDATE invoice SET room_fee = NEW.fee_per_night WHERE room_no = NEW.room_no;
END //
DELIMITER ;

-- 15 queries

-- Query  1
SELECT physician.name, COUNT(*) AS Number_of_Patients
FROM physician
INNER JOIN orders_for
ON physician.physician_id = orders_for.physician_id
GROUP BY physician.name
ORDER BY Number_of_Patients DESC;

-- Query  2
SELECT patient.name, rooms.fee_per_night 
FROM patient
INNER JOIN rooms
ON patient.room_no = rooms.room_no
WHERE rooms.fee_per_night > 100;

-- Query  3
SELECT physician.name, SUM(instruction.fee) AS total_fee
FROM physician
JOIN orders_for ON physician.physician_id = orders_for.physician_id
JOIN instruction ON orders_for.instruction_code = instruction.instruction_code
GROUP BY physician.name
HAVING total_fee > 1000;

-- Query  4
SELECT p.name, n.name AS "nurse_name", i.fee AS "instruction_fee"
FROM patient p 
INNER JOIN executes_for ef ON p.patient_id = ef.patient_id
INNER JOIN nurse n ON ef.nurse_id = n.nurse_id
INNER JOIN instruction i ON ef.instruction_code = i.instruction_code
WHERE p.room_no IN (
    SELECT r.room_no 
    FROM rooms r 
    WHERE r.fee_per_night > (
        SELECT AVG(r2.fee_per_night) 
        FROM rooms r2
    )
);


-- Query  5
SELECT name 
FROM physician
WHERE physician_id IN (
    SELECT physician_id 
    FROM orders_for 
    WHERE instruction_code IN (
        SELECT instruction_code 
        FROM instruction
        WHERE fee > (SELECT AVG(fee) FROM instruction)
    )
);


-- Query  6
SELECT p.name
FROM patient p
WHERE p.patient_id IN (
    SELECT o.patient_id
    FROM orders_for o
    WHERE o.physician_id IN (
        SELECT ph.physician_id
        FROM physician ph
        WHERE ph.field_of_expertise = 'Cardiology'
    )
);

-- Query  7
SELECT rooms.room_no, COUNT(patient.patient_id) as num_patients
FROM rooms
LEFT JOIN patient ON rooms.room_no = patient.room_no
GROUP BY rooms.room_no;

-- Query  8
SELECT physician.field_of_expertise, COUNT(*) AS total_patients_treated
FROM physician
JOIN orders_for ON physician.physician_id = orders_for.physician_id
GROUP BY physician.field_of_expertise;

-- Query  9
SELECT nurse.name, COUNT(*) as NumberOfInstructions
FROM nurse
JOIN executes_for ON nurse.nurse_id = executes_for.nurse_id
GROUP BY nurse.name
HAVING COUNT(*) > 1;

-- Query  10
SELECT patient.name, SUM(invoice.instruction_fee + invoice.room_fee) as TotalInvoiceAmount
FROM patient
JOIN invoice ON patient.patient_id = invoice.patient_id
GROUP BY patient.name
ORDER BY TotalInvoiceAmount DESC
LIMIT 3;

-- Query  11
SELECT p.name AS Patient_Name, phy.name AS Physician_Name, SUM(ins.fee) AS Total_Fees
FROM patient p
JOIN orders_for o ON p.patient_id = o.patient_id
JOIN physician phy ON o.physician_id = phy.physician_id
JOIN instruction ins ON o.instruction_code = ins.instruction_code
GROUP BY p.patient_id, phy.physician_id
ORDER BY Total_Fees DESC
LIMIT 3;

-- Query  12
SELECT p.name, h.disease
FROM patient p
JOIN health_record h ON p.health_record_id = h.health_record_id
WHERE h.disease = 'Kidney Failure';

-- Query  13
SELECT p.name, i.description
FROM patient p
JOIN orders_for o ON p.patient_id = o.patient_id
JOIN instruction i ON o.instruction_code = i.instruction_code
WHERE o.order_date = (SELECT MAX(order_date) FROM orders_for WHERE patient_id = p.patient_id);


-- Query  14
SELECT 
    health_record.status AS health_status,
    AVG(instruction.fee) AS avg_instruction_fee
FROM health_record
INNER JOIN patient ON health_record.health_record_id = patient.health_record_id
INNER JOIN orders_for ON patient.patient_id = orders_for.patient_id
INNER JOIN instruction ON orders_for.instruction_code = instruction.instruction_code
GROUP BY health_record.status;


-- Query  15
SELECT physician_id, name
FROM physician
WHERE physician_id NOT IN (
    SELECT DISTINCT physician_id 
    FROM orders_for 
    WHERE order_date BETWEEN '2023-01-01' AND '2023-12-31'
);


-- Transaction 1
BEGIN;

UPDATE patient
SET room_no = 400
WHERE patient_id = 7283495;

UPDATE invoice
SET room_no = 400, room_fee = 80.00
where patient_id = 7283495;

COMMIT;


-- Transaction 2
BEGIN;

SELECT health_record_id INTO @hr_id 
FROM patient
WHERE patient_name = "Clark Kent";

UPDATE health_record 
SET status = "treated"
WHERE health_record_id = @hr_id;

COMMIT;
