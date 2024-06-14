window.onload = function() {
    const fullNameInput = document.getElementById('fullName');
    const addressInput = document.getElementById('Address');
    const phoneInput = document.getElementById('Phone');
    const emailInput = document.getElementById('Email');
    const fullNameHelp = document.getElementById('fullNameHelp');
    const phoneHelp = document.getElementById('phoneHelp');
    const saveChangesBtn = document.getElementById('saveChangesBtn');

    function validateForm() {
        var isValid = true;

        // Check if fullName contains numbers
        if (/\d/.test(fullNameInput.value)) {
            fullNameHelp.textContent = 'Tên không được chứa số!';
            isValid = false;
        } else {
            fullNameHelp.textContent = '';
        }

        // Check if phone number starts with 0 and is 9 or 10 digits long, and contains only digits
        var phoneValue = phoneInput.value.replace(/\D/g, ''); // Remove all non-digit characters
        if (phoneValue.length !== 0 && (!/^0\d{8,9}$/.test(phoneValue))) {
            phoneHelp.textContent = 'Số điện thoại phải bắt đầu bằng số 0 và có 9 hoặc 10 chữ số!';
            isValid = false;
        } else {
            phoneHelp.textContent = '';
        }

        // Check if all fields are not empty
        if (!fullNameInput.value.trim() || !addressInput.value.trim() || !phoneInput.value.trim() || !emailInput.value.trim()) {
            isValid = false;
        }

        // Update the disabled state of the save button
        saveChangesBtn.disabled = !isValid;
    }

    // Ensure phoneInput allows only digits
    phoneInput.addEventListener('input', function() {
        this.value = this.value.replace(/[^\d]/g, ''); // Remove non-digit characters
        validateForm();
    });

    fullNameInput.addEventListener('input', validateForm);
    addressInput.addEventListener('input', validateForm);
    emailInput.addEventListener('input', validateForm);

    // Call validateForm initially to set the initial state of the save button
    validateForm();
};
