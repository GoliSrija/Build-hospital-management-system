```sql
-- Create the hospital management system database
CREATE DATABASE hospital_management_system;

-- Use the hospital management system database
\c hospital_management_system

-- Create the patients table
CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    appointment_history JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the appointments table
CREATE TABLE appointments (
    id SERIAL PRIMARY KEY,
    patient_id INTEGER NOT NULL REFERENCES patients(id),
    date DATE NOT NULL,
    time TIME NOT NULL,
    provider_id INTEGER NOT NULL REFERENCES providers(id),
    scheduler_id INTEGER NOT NULL REFERENCES schedulers(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the providers table
CREATE TABLE providers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    schedule JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the invoices table
CREATE TABLE invoices (
    id SERIAL PRIMARY KEY,
    patient_id INTEGER NOT NULL REFERENCES patients(id),
    amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(100) NOT NULL DEFAULT 'pending',
    paid_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the payments table
CREATE TABLE payments (
    id SERIAL PRIMARY KEY,
    invoice_id INTEGER NOT NULL REFERENCES invoices(id),
    payment_method VARCHAR(100) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the reports table
CREATE TABLE reports (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    type VARCHAR(100) NOT NULL,
    value INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the report_types table
CREATE TABLE report_types (
    id SERIAL PRIMARY KEY,
    type VARCHAR(100) NOT NULL,
    description VARCHAR(255)
);

-- Create the schedules table
CREATE TABLE schedules (
    id SERIAL PRIMARY KEY,
    provider_id INTEGER NOT NULL REFERENCES providers(id),
    date DATE NOT NULL,
    time TIME NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the patient_appointments table
CREATE TABLE patient_appointments (
    id SERIAL PRIMARY KEY,
    patient_id INTEGER NOT NULL REFERENCES patients(id),
    appointment_id INTEGER NOT NULL REFERENCES appointments(id)
);

-- Create an index on the appointment date and time
CREATE INDEX idx_appointments_date_time ON appointments (date, time);

-- Create a foreign key constraint for patient_appointments to appointments
ALTER TABLE patient_appointments
ADD CONSTRAINT fk_patient_id FOREIGN KEY (appointment_id)
REFERENCES appointments(id);

-- Create an index on the invoices paid status
CREATE INDEX idx_invoices_paid_status ON invoices (status);

-- Create a foreign key constraint for payments to invoices
ALTER TABLE payments
ADD CONSTRAINT fk_invoice_id FOREIGN KEY (invoice_id)
REFERENCES invoices(id);
```