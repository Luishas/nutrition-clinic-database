-- AFTER FINISHING CREATING ALL SCRIPTS, RUN THIS TO SEE IF
-- EVERYTHING IS WORKING AS INTENDED

-- SHOW PATIENTS
SELECT * FROM Patient;

-- SHOW NUTRITIONISTS
SELECT * FROM Nutritionist;

-- SHOW APPOINTMENTS
SELECT * FROM Appointment;

-- SHOW PAYMENTS
SELECT * FROM Payment;

-- SHOW NUTRITION PLANS
SELECT * FROM NutriPlan;


-- TRIGGER: CANT ACCEPT APPOINTMENTS IN THE PAST
INSERT INTO Appointment (patientID, nutritionistID, appointmentDate, reason, status)
VALUES (1,1, DATEADD(day,-1,GETDATE()), 'Past test', 'Scheduled'); -- Debe fallar


-- TRIGGER: JUST ONE COMPLETED PAYMENT PER APPOINTMENT
INSERT INTO Payment (appointmentID, amount, payDate, payMethod, status)
VALUES (11, 100, GETDATE(), 'Cash', 'Completed'); -- SHOULD WORK

INSERT INTO Payment (appointmentID, amount, payDate, payMethod, status)
VALUES (1, 50, GETDATE(), 'Cash', 'Completed'); -- SHOULD FAIL


-- INSERT A NEW APPOINTMENT AND CHECK IT ON THE AUDIT LOG
INSERT INTO Appointment (patientID, nutritionistID, appointmentDate, reason, status)
VALUES (5,1, DATEADD(day,2,GETDATE()), 'Audit test', 'Scheduled');
--CHECK AUDIT LOG NOW
SELECT * FROM AuditLog
WHERE tableName = 'Appointment'
ORDER BY auditID DESC;


-- CHECK IF VIEWS ARE WORKING PROPERLY
-- UPCOMING APPOINTMENTS VIEW
SELECT * FROM vw_upcomingAppointments;

-- PENDING PAYMENTS VIEW
SELECT * FROM vw_pendingPayments;


-- UPDATE AN APPOINTMENT STATUS
UPDATE Appointment
SET status = 'Completed'
WHERE appointmentID = 1;

-- SOFT DELETE OF AN APPOINTMENT
UPDATE Appointment
SET status = 'Cancelled'
WHERE appointmentID = 2;

-- CHECK AUDIT LOG FOR CHANGES
SELECT * FROM AuditLog
WHERE tableName = 'Appointment'
ORDER BY auditID DESC;


