```python
from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from models import db, Patient, Appointment, Provider, Invoice
from config import Config

app = Flask(__name__)
app.config.from_object(Config)
db.init_app(app)

@app.route('/patients', methods=['GET'])
def get_patients():
    patients = Patient.query.all()
    return jsonify([patient.name for patient in patients])

@app.route('/patients', methods=['POST'])
def create_patient():
    patient = Patient(
        name=request.json['name'],
        email=request.json['email'],
        phone_number=request.json['phone_number']
    )
    db.session.add(patient)
    db.session.commit()
    return jsonify({'message': 'Patient created successfully'})

@app.route('/patients/<int:patient_id>', methods=['GET'])
def get_patient(patient_id):
    patient = Patient.query.get(patient_id)
    if not patient:
        return jsonify({'message': 'Patient not found'}), 404
    return jsonify(patient.name)

@app.route('/patients/<int:patient_id>', methods=['PUT'])
def update_patient(patient_id):
    patient = Patient.query.get(patient_id)
    if not patient:
        return jsonify({'message': 'Patient not found'}), 404
    patient.name = request.json.get('name', patient.name)
    patient.email = request.json.get('email', patient.email)
    patient.phone_number = request.json.get('phone_number', patient.phone_number)
    db.session.commit()
    return jsonify({'message': 'Patient updated successfully'})

@app.route('/patients/<int:patient_id>', methods=['DELETE'])
def delete_patient(patient_id):
    patient = Patient.query.get(patient_id)
    if not patient:
        return jsonify({'message': 'Patient not found'}), 404
    db.session.delete(patient)
    db.session.commit()
    return jsonify({'message': 'Patient deleted successfully'})

if __name__ == '__main__':
    app.run(debug=True)
```