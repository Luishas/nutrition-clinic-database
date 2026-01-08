-- USE THE DB ALREADY CREATED IN SETUP
USE nutrition_clinic;
GO

-- INDEXES FOR NUTRITION CLINIC DB

-- APPOINTMENTS: BY PATIENT
CREATE INDEX idx_appointments_patientID
ON Appointment(patientID);

-- APPOINTMENTS: BY NUTRITIONIST 
CREATE INDEX idx_appointments_nutritionistID
ON Appointment(nutritionistID);

-- NUTRITION PLAN: BY PATIENT
CREATE INDEX idx_nutritionPlan_patientID
ON NutriPlan(patientID);

-- PAYMENT: BY APPOINTMENT
CREATE INDEX idx_payment_appointmentID
ON Payment(appointmentID);

-- PAYMENT: BY DATE
CREATE INDEX idx_payment_payDate
ON Payment(payDate);