/* 
 * Hospital Database Project
 * hospital-data.sql
 */

-- Insert data into physician
INSERT INTO physician VALUES 
    (9874567, "Pamela Isley", 89702395, "Cardiology", "1415 W 22nd Tower Floor St, Oak Brook, IL, 60523", "3126128765"),
    (6374958, "Cory Thomas", 63284757, "Oncology", "4340 Woodglen Ln, Mount Vernon, IL, 62864", "7088734269"),
    (8273545, "Christian Smith", 72649572, "Surgery", "8239 Shipston St, Orland Park, IL, 60462", "7374569082"),
    (1793746, "Cory Finn", 82938475, "Pediatrics", "183 W Brandon Ct #H, Palatine, IL, 60067", "6302896374"),
    (7283946, "Skylar Miller", 91827365, "Cardiology", "1830 Park Ave, North Chicago, IL, 60064", "2789065412")
;

-- Insert data into nurse
INSERT INTO nurse VALUES
    (630621, "Kyle Martinez", 72839465, "7733178906", "183 W Brandon Ct, Palatine, IL, 60067"),
    (534091, "Barry Allen", 12793846, "7916532108", "2333 W Jackson Blvd, Chicago, IL, 60612"),
    (826351, "Lily Rose", 63128937, "2780896545", "899 S Plymouth Ct, Chicago, IL, 60605"),
    (908267, "Rory Cruz", 34796524, "8172634509", "1666 Rand Rd, Des Plaines, IL, 60016"),
    (827364, "Taylor Anderson", 72839465, "7733178906", "1666 Rand Rd, Des Plaines, IL, 60016")
;

-- Insert data into rooms
INSERT INTO rooms VALUES
    (104, 1, 100.00),
    (300, 2, 80.00),
    (310, 1, 100.00),
    (409, 1, 150.00),
    (400, 2, 80.00)
;

-- Insert data into health_record
INSERT INTO health_record VALUES
    (1945763, "treated", '2023-01-15', "Discharged. Follow-up appointment in one week,", "Flu"),
    (7283495, "not treated", '2023-07-15', "Post operation. ", "Kidney Failure"),
    (2374859, "treated", '2022-04-25', "Discharged. Given maintenance medication.", "High cholesterol"),
    (4679372, "treated", '2023-05-03', "Discharged. Given IV medication and hydration.", "High blood pressure"),
    (6354782, "not treated", '2023-07-09', "Inpatient. Needs more lab tests to confirm diagnosis.", "Unknown")
;

-- Insert data into patient
INSERT INTO patient VALUES
    (1945763, 409, 1945763, "4123876529","2775 Sanders Rd, Northbrook, IL, 60062", "Roman Rodriguez"),
    (7283495, 104, 7283495, "3187293745", "8037 88th Ave, Pleasant Prairie, WI, 53158", "David Moore"),
    (2374859, 310, 2374859, "7739845620", "3124 173rd St, Hazel Crest, IL, 60429", "Kylo Ren"),
    (4679372, 300, 4679372, "3089276532", "1529 College Ave, Rochester, IN, 46975", "Lois Lane"),
    (6354782, 300, 6354782, "7069036257", "724 E Carpenter Dr, Palatine, IL, 60074", "Clark Kent")
;

INSERT INTO medications VALUES
	(17283, "Medication 1"),
    (29384, "Medication 2"),
    (98735, "Medication 3"),
    (24566, "Medication 4"),
    (48937, "Medication 5")
;


-- Insert data into instruction
INSERT INTO instruction VALUES 
    (1902, 387.39, "Take medication at 9 PM."),
    (8456, 540.04, "Keep on bedrest. Take one pill everyday."),
    (2378, 860.35, "Take medication after every meal."),
    (5218, 250.00, "Avoid salty foods and hydrate. Take medication twice a day, one at morning and one at night."),
    (1982, 376.83, "Eat nothing from 12 midnight until lab test tomorrow morning. Take medication for pain as needed.")
;

-- Insert data into orders_for
INSERT INTO orders_for VALUES
    ('2023-01-01', 1902, 1793746, 1945763),
    ('2023-07-14', 8456, 8273545, 7283495),
    ('2022-04-22', 2378, 1793746, 2374859),
    ('2023-04-29', 5218, 9874567, 4679372),
    ('2023-07-06', 1982, 6374958, 6354782)
;

-- Insert data into executes_for
INSERT INTO executes_for VALUES
    ('2023-01-01', "complete", 1902, 630621, 1945763),
    ('2023-07-14', "complete", 8456, 534091, 7283495),
    ('2022-04-22', "complete", 2378, 826351, 2374859),
    ('2023-04-29', "complete", 5218, 908267, 4679372),
    ('2023-07-06', "complete", 1982, 908267, 6354782)
;

-- Insert data into invoice
INSERT INTO invoice VALUES 
    (8927364, 1945763, 409, 150.00, 387.39),
    (6273849, 7283495, 104, 100.00, 540.04),
    (2637495, 2374859, 310, 100.00, 860.35),
    (2738495, 4679372, 300, 80.00, 250.00),
    (1829765, 6354782, 300, 80.00, 376.83)
;
    -- Insert data into payment
INSERT INTO payment VALUES 
    (5372839, 1945763, 8927364, '2023-01-17', 537.39),
    (6273947, 7283495, 6273849, '2023-07-16', 640.04),
    (2637582, 2374859, 2637495, '2022-04-30', 960.35),
    (2738563, 4679372, 2738495, '2023-05-05', 330.00),
    (1829834, 6354782, 1829765, '2023-07-10', 456.83)
;

INSERT INTO gives_med VALUES
	(17283, 630621, 1945763, 14),
    (29384, 534091, 7283495, 30),
    (98735, 826351, 2374859, 30),
    (24566, 908267, 4679372, 14),
    (48937, 908267, 6354782, 7)
;

INSERT INTO monitor_by VALUES
	(1793746, 1945763, "2 weeks"),
    (8273545, 7283495, "5 days"),
    (1793746, 2374859, "3 days"),
    (9874567, 4679372, "5 days"),
    (6374958, 6354782, "1 week")
;
