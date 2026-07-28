```python
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash

db = SQLAlchemy()

class Patient(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(64))
    email = db.Column(db.String(120), unique=True)
    phone_number = db.Column(db.String(20))
    appointment_history = db.relationship('Appointment', backref='patient', lazy=True)

    def __init__(self, name, email, phone_number):
        self.name = name
        self.email = email
        self.phone_number = phone_number

    def set_password(self, password):
        self.password = generate_password_hash(password)

class Appointment(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    patient_id = db.Column(db.Integer, db.ForeignKey('patient.id'))
    date = db.Column(db.DateTime)
    time = db.Column(db.String(20))
    provider_id = db.Column(db.Integer, db.ForeignKey('provider.id'))

    def __init__(self, patient_id, date, time, provider_id):
        self.patient_id = patient_id
        self.date = date
        self.time = time
        self.provider_id = provider_id

class Provider(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(64))

    def __init__(self, name):
        self.name = name

class Invoice(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    patient_id = db.Column(db.Integer, db.ForeignKey('patient.id'))
    date = db.Column(db.DateTime)
    amount = db.Column(db.Float)

    def __init__(self, patient_id, date, amount):
        self.patient_id = patient_id
        self.date = date
        self.amount = amount
```