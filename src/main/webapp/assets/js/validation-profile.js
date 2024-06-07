window.onload = function() {
    var fullNameInput = document.getElementById('fullName');
    var addressInput = document.getElementById('Address');
    var phoneInput = document.getElementById('Phone');
    var emailInput = document.getElementById('Email');
    var fullNameHelp = document.getElementById('fullNameHelp');
    var phoneHelp = document.getElementById('phoneHelp');
    var saveChangesBtn = document.getElementById('saveChangesBtn');

    function validateForm() {
        var isValid = true;

        // Check if fullName contains numbers
        if (/\d/.test(fullNameInput.value)) {
            fullNameHelp.textContent = 'Tên không được chứa số!';
            isValid = false;
        } else {
            fullNameHelp.textContent = '';
        }

        // Check if phone number is 9 or 10 digits long
        var phoneValue = phoneInput.value.replace(/\D/g, ''); // Remove all non-digit characters
        if (phoneValue.length !== 0 && (phoneValue.length !== 9 && phoneValue.length !== 10)) {
            phoneHelp.textContent = 'Số điện thoại phải có 9 hoặc 10 chữ số!';
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

    fullNameInput.addEventListener('input', validateForm);
    addressInput.addEventListener('input', validateForm);
    phoneInput.addEventListener('input', validateForm);
    emailInput.addEventListener('input', validateForm);

    // Call validateForm initially to set the initial state of the save button
    validateForm();
};
