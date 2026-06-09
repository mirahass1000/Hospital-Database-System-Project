/* 
 * Hospital Database Project
 * hospital-schema.sql
 */

DROP DATABASE IF EXISTS hospital;
CREATE DATABASE hospital;
USE hospital;

CREATE TABLE physician(
	physician_id INT,
    name VARCHAR(50),
    certificate_number INT,
    field_of_expertise VARCHAR(50),
    address VARCHAR(255),
    phone_number CHAR(15),
    PRIMARY KEY (physician_id)
);

CREATE TABLE nurse(
	nurse_id INT,
    name VARCHAR(50),
    certificate_number INT,
    phone_number CHAR(15),
    address VARCHAR(255),
    PRIMARY KEY (nurse_id)
);

CREATE TABLE rooms(
	room_no INT,
    capacity INT,
    fee_per_night DECIMAL(10,2),
    PRIMARY KEY (room_no)
);

CREATE TABLE health_record(
	health_record_id INT,
	status VARCHAR(25),
    date DATE,
    description VARCHAR(250),
    disease VARCHAR(50),
    PRIMARY KEY (health_record_id)
);

CREATE TABLE patient(
	patient_id INT,
    room_no INT,
    health_record_id INT,
    phone_number CHAR(15),
    address VARCHAR(255),
    name VARCHAR(50),
    PRIMARY KEY (patient_id),
    FOREIGN KEY (room_no) REFERENCES rooms(room_no),
    FOREIGN KEY (health_record_id) REFERENCES health_record(health_record_id)
);

CREATE TABLE instruction(
	instruction_code INT,
    fee DECIMAL(10,2),
    description VARCHAR(250),
    PRIMARY KEY (instruction_code)
);

CREATE TABLE orders_for(
	order_date DATE,
    instruction_code INT,
    physician_id INT,
    patient_id INT,
	FOREIGN KEY (instruction_code) REFERENCES instruction(instruction_code),
	FOREIGN KEY (physician_id) REFERENCES physician(physician_id),
	FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE executes_for(
	execute_date DATE,
    result_status VARCHAR(50),
    instruction_code INT, 
    nurse_id INT,
    patient_id INT,
    FOREIGN KEY (instruction_code) REFERENCES instruction(instruction_code),
    FOREIGN KEY (nurse_id) REFERENCES nurse(nurse_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE invoice(
	invoice_id INT,
    patient_id INT,
    room_no INT,
    room_fee DECIMAL(10,2),
    instruction_fee DECIMAL(10,2),
    PRIMARY KEY (invoice_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (room_no) REFERENCES rooms(room_no)
);


CREATE TABLE payment(
	payment_id INT,
	patient_id INT,
    invoice_id INT,
    payment_date DATE ,
    amount DECIMAL(10,2),
    PRIMARY KEY (payment_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id)
);

CREATE TABLE medications(
	medication_id INT,
	name VARCHAR(50),
	PRIMARY KEY (medication_id)
);

CREATE TABLE gives_med(
	medication_id INT,
    nurse_id INT,
	patient_id INT,
    amount INT,
	FOREIGN KEY (medication_id) REFERENCES medications(medication_id),
	FOREIGN KEY (nurse_id) REFERENCES nurse(nurse_id),
	FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE monitor_by(
	physician_id INT,
    patient_id INT,
    duration CHAR(20),
	FOREIGN KEY (physician_id) REFERENCES physician(physician_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

