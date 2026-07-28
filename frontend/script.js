```javascript
// Form Validation
const form = document.querySelector('form');

form.addEventListener('submit', (e) => {
    e.preventDefault();
    const name = document.querySelector('input[name="name"]').value;
    const email = document.querySelector('input[name="email"]').value;

    if (name.trim() === '' || email.trim() === '') {
        alert('Please fill out the form');
        return;
    }

    // Send API call to validate the form
    fetch('/validate-form', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            name,
            email
        })
    })
    .then((response) => {
        return response.json();
    })
    .then((data) => {
        if (data.status === 'success') {
            alert('Form submitted successfully!');
            form.reset();
        } else {
            alert('Error submitting the form');
        }
    })
    .catch((error) => {
        console.error(error);
    });
});

// API Calls using fetch()
function getPatients() {
    fetch('/patients')
        .then((response) => {
            return response.json();
        })
        .then((data) => {
            const patientsTable = document.querySelector('.patients-table');
            data.forEach((patient) => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${patient.id}</td>
                    <td>${patient.name}</td>
                    <td>${patient.phone}</td>
                    <td>${patient.address}</td>
                `;
                patientsTable.appendChild(row);
            });
        })
        .catch((error) => {
            console.error(error);
        });
}

function getAppointments() {
    fetch('/appointments')
        .then((response) => {
            return response.json();
        })
        .then((data) => {
            const appointmentsTable = document.querySelector('.appointments-table');
            data.forEach((appointment) => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${appointment.id}</td>
                    <td>${appointment.patientName}</td>
                    <td>${appointment.doctorName}</td>
                    <td>${appointment.appointmentDate}</td>
                    <td>${appointment.appointmentTime}</td>
                `;
                appointmentsTable.appendChild(row);
            });
        })
        .catch((error) => {
            console.error(error);
        });
}

// Loading Spinner
const loadingSpinner = document.querySelector('.loading-spinner');
function showLoadingSpinner() {
    loadingSpinner.classList.remove('hidden');
}

function hideLoadingSpinner() {
    loadingSpinner.classList.add('hidden');
}

// Dynamic Dashboard
getPatients();
getAppointments();

// Event Listeners
document.addEventListener('DOMContentLoaded', () => {
    const sendButton = document.querySelector('button');
    sendButton.addEventListener('click', () => {
        showLoadingSpinner();
        // API call to get data for dashboard
        fetch('/dashboard-data')
            .then((response) => {
                return response.json();
            })
            .then((data) => {
                const patientsTable = document.querySelector('.patients-table');
                const appointmentsTable = document.querySelector('.appointments-table');
                data.patients.forEach((patient) => {
                    const row = document.createElement('tr');
                    row.innerHTML = `
                        <td>${patient.id}</td>
                        <td>${patient.name}</td>
                        <td>${patient.phone}</td>
                        <td>${patient.address}</td>
                    `;
                    patientsTable.appendChild(row);
                });
                data.appointments.forEach((appointment) => {
                    const row = document.createElement('tr');
                    row.innerHTML = `
                        <td>${appointment.id}</td>
                        <td>${appointment.patientName}</td>
                        <td>${appointment.doctorName}</td>
                        <td>${appointment.appointmentDate}</td>
                        <td>${appointment.appointmentTime}</td>
                    `;
                    appointmentsTable.appendChild(row);
                });
                hideLoadingSpinner();
            })
            .catch((error) => {
                console.error(error);
                hideLoadingSpinner();
            });
    });
});
```