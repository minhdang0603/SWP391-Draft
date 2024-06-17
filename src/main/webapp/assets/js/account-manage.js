$(document).ready(function () {
    $('#myTable').DataTable();
})
function editUser(id, userName, email, address, phoneNumber, roleValue, status) {
    // Set the values in the modal form
    document.getElementById('editUserId').value = id;
    document.getElementById('editUserName').value = userName;
    document.getElementById('editEmail').value = email;
    document.getElementById('editAddress').value = address;
    document.getElementById('editPhoneNumber').value = phoneNumber;

    // Set the selected value for role
    var roleSelect = document.getElementById('editRole');
    for (var i = 0; i < roleSelect.options.length; i++) {
        if (roleSelect.options[i].value == roleValue) {
            roleSelect.options[i].selected = true;
        } else {
            roleSelect.options[i].selected = false;
        }
    }

    // Set the selected value for status
    var statusSelect = document.getElementById('editStatus');
    for (var i = 0; i < statusSelect.options.length; i++) {
        if (statusSelect.options[i].value === status) {
            statusSelect.options[i].selected = true;
        } else {
            statusSelect.options[i].selected = false;
        }
    }

    // Show the modal
    var myModal = new bootstrap.Modal(document.getElementById('editUserModal'), {
        keyboard: false
    });
    myModal.show();
}

function validateEmail(email) {
    // Simple email validation regex
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
}

function validatePhoneNumber(phoneNumber) {
    // Phone number validation regex: starts with 0, followed by 8 or 9 digits
    const re = /^0\d{8,9}$/;
    return re.test(phoneNumber);
}

function confirmDelete() {
    return confirm('Bạn có chắc chắn muốn xóa tài khoản này?');
}

function searchByEmail() {
    // Get the input value
    var input = document.getElementById('searchEmail');
    var filter = input.value.toLowerCase();
    var table = document.getElementById('myTable');
    var tr = table.getElementsByTagName('tr');

    // Loop through all rows, and hide those who don't match the search query
    for (var i = 1; i < tr.length; i++) {
        var td = tr[i].getElementsByTagName('td')[2]; // Column with email
        if (td) {
            var txtValue = td.textContent || td.innerText;
            if (txtValue.toLowerCase().indexOf(filter) > -1) {
                tr[i].style.display = '';
            } else {
                tr[i].style.display = 'none';
            }
        }
    }
}

function validateForm() {
    let valid = true;

    // Validate phone number
    const phoneNumber = document.getElementById('phoneNumber').value;
    const phoneNumberError = document.getElementById('phoneNumberError');
    const phonePattern = /^0\d{8,9}$/;
    if (!phonePattern.test(phoneNumber)) {
        phoneNumberError.textContent = 'Số điện thoại phải bắt đầu bằng số 0 và có 9 hoặc 10 chữ số.';
        valid = false;
    } else {
        phoneNumberError.textContent = '';
    }

    // Validate passwords
    const password = document.getElementById('password').value;
    const repassword = document.getElementById('repassword').value;
    const passwordError = document.getElementById('passwordError');
    const repasswordError = document.getElementById('repasswordError');
    const passwordHelp = document.getElementById('passwordHelp');
    const passwordValidation = document.getElementById('passwordValidation');

    const passwordPattern = /^(?=.*\d)(?=.*[A-Z]).{8,}$/;
    if (!passwordPattern.test(password)) {
        passwordValidation.style.display = 'block';
        valid = false;
    } else {
        passwordValidation.style.display = 'none';
    }

    if (password !== repassword) {
        passwordHelp.style.display = 'block';
        valid = false;
    } else {
        passwordHelp.style.display = 'none';
    }

    return valid;
}