-- USE DB ALREADY CREATED IN SETUP
USE nutrition_clinic;
GO

-- TRIGGERS FOR NUTRITION CLINIC DB

-- TRIGGER FOR COMPLETED PAYMENT TO UPDATE APPOINTMENT STATUS
CREATE TRIGGER trg_payment_completed_Appointment
ON Payment
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE a
    SET a.status = 'Completed'
    FROM Appointment a 
    JOIN inserted i ON a.appointmentID = i.appointmentID
    WHERE i.status = 'Completed';
END;
GO

-- TRIGGER TO PREVENT DUPLICATED 'COMPLETED' PAYMENTS 
CREATE TRIGGER trg_prevent_duplicate_completed_payment
ON Payment
AFTER INSERT, UPDATE
AS 
BEGIN 
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM Payment p
        JOIN inserted i ON p.appointmentID = i.appointmentID
        WHERE p.status = 'Completed'
        GROUP BY p.appointmentID
        HAVING COUNT(*) > 1
    )
    BEGIN 
        RAISERROR ('Only one completed payment is allowed per appointment.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO