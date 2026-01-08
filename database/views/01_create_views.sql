-- USE EXISTING DB IN SETUP
USE nutrition_clinic;
GO

-- VIEWS FOR NUTRITION CLINIC

-- CREATE THIS AFTER TESTING QUERIES (THAT WAS THE PURPOSE OF CREATING
-- THEM FIRST)

-- UPCOMING APPOINTMENTS VIEW
CREATE VIEW vw_upcomingAppointments AS
SELECT
    a.appointmentID,
    a.appointmentDate,
    p.name + ' ' + p.lastName AS Patient,
    n.name + ' ' + n.lastName AS Nutritionist,
    a.reason,
    a.status
FROM Appointment a
JOIN Patient p ON a.patientID = p.patientID
JOIN Nutritionist n ON a.nutritionistID = n.nutritionistID
WHERE a.appointmentDate >= GETDATE();
GO

-- PENDING PAYMENTS VIEW
CREATE VIEW vw_pendingPayments AS
SELECT 
    paymentID,
    appointmentID,
    amount,
    payMethod,
    payDate
FROM Payment
WHERE status = 'Pending';
GO

-- MONTHLY REVENUE VIEW
CREATE VIEW vw_monthlyRevenue AS
SELECT
    YEAR(payDate) AS YEAR,
    MONTH(payDate) AS MONTH,
    SUM(amount) AS totalRevenue
FROM Payment
WHERE status = 'Completed'
GROUP BY YEAR(payDate), MONTH(payDate);
GO

-- APPOINTMENT HISTORY VIEW
CREATE VIEW vw_appointmentHistory AS
SELECT
    a.appointmentID,
    a.appointmentDate,
    p.name + ' ' + p.lastName AS Patient,
    n.name + ' ' + n.lastName AS Nutritionist,
    a.status
FROM Appointment a 
JOIN Patient p ON a.patientID = p.patientID
JOIN Nutritionist n ON a.nutritionistID = n.nutritionistID
GO

-- ACTIVE PATIENTS VIEW
CREATE VIEW vw_activePatients AS
SELECT
    p.patientID,
    p.name,
    p.lastName,
    p.email
FROM Patient p
JOIN Appointment a ON p.patientID = a.patientID
WHERE a.status IN ('Scheduled','Completed')
GO
