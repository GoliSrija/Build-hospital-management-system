```sql
-- Insert sample data into the patients table
INSERT INTO patients (name, email, phone_number, appointment_history)
VALUES
('John Doe', 'john.doe@example.com', '123-456-7890', '{}'),
('Jane Smith', 'jane.smith@example.com', '987-654-3210', '{}');

-- Insert sample data into the providers table
INSERT INTO providers (name, email, phone_number, schedule)
VALUES
('Dr. John Doe', 'john.doe@example.com', '123-456-7890', '{}'),
('Dr. Jane Smith', 'jane.smith@example.com', '987-654-3210', '{}');

-- Insert sample data into the appointments table
INSERT INTO appointments (patient_id, date, time, provider_id)
VALUES
(1, '2022-01-01', '09:00:00', 1),
(2, '2022-01-02', '10:00:00', 2);

-- Insert sample data into the invoices table
INSERT INTO invoices (patient_id, amount, status)
VALUES
(1, 100.00, 'pending'),
(2, 200.00, 'pending');

-- Insert sample data into the payments table
INSERT INTO payments (invoice_id, payment_method, amount, payment_date)
VALUES
(1, 'credit card', 100.00, '2022-01-01'),
(2, 'credit card', 200.00, '2022-01-02');

-- Insert sample data into the reports table
INSERT INTO reports (date, type, value)
VALUES
('2022-01-01', 'patient_count', 10),
('2022-01-02', 'appointment_count', 20);

-- Insert sample data into the report_types table
INSERT INTO report_types (type, description)
VALUES
('patient_count', 'The number of patients'),
('appointment_count', 'The number of appointments');
```