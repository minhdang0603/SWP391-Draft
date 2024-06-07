document.getElementById('changePasswordForm').addEventListener('input', function() {
    var currentPassword = document.getElementById('currentPassword').value;
    var newPassword = document.getElementById('newPassword').value;
    var renewPassword = document.getElementById('renewPassword').value;
    var isValid = true;

    // Kiểm tra currentPassword không được để trống
    if (currentPassword.trim() === '') {
        document.getElementById('currentPasswordHelp').style.display = 'block';
        isValid = false;
    } else {
        document.getElementById('currentPasswordHelp').style.display = 'none';
    }

    // Kiểm tra newPassword không giống currentPassword
    if (newPassword === currentPassword) {
        document.getElementById('newPasswordHelp').style.display = 'block';
        isValid = false;
    } else {
        document.getElementById('newPasswordHelp').style.display = 'none';
    }

    // Kiểm tra độ dài mật khẩu và chứa ít nhất 1 chữ hoa và 1 số
    var passwordValidation = /^(?=.*[A-Z])(?=.*\d).{8,}$/;
    if (!passwordValidation.test(newPassword)) {
        document.getElementById('newPasswordValidation').style.display = 'block';
        isValid = false;
    } else {
        document.getElementById('newPasswordValidation').style.display = 'none';
    }

    // Kiểm tra xem newPassword và renewPassword có giống nhau không
    // if (newPassword !== renewPassword) {
    //     document.getElementById('renewPasswordHelp').style.display = 'block';
    //     isValid = false;
    // } else {
    //     document.getElementById('renewPasswordHelp').style.display = 'none';
    // }

    // Vô hiệu hóa nút "Change Password" nếu không hợp lệ
    document.getElementById('changePassbtn').disabled = !isValid;
});

document.getElementById('changePasswordForm').addEventListener('submit', function(event) {
    var currentPassword = document.getElementById('currentPassword').value;
    var newPassword = document.getElementById('newPassword').value;
    var isValid = true;

    // Kiểm tra currentPassword không được để trống
    if (currentPassword.trim() === '') {
        document.getElementById('currentPasswordHelp').style.display = 'block';
        isValid = false;
    } else {
        document.getElementById('currentPasswordHelp').style.display = 'none';
    }

    // Kiểm tra newPassword không giống currentPassword
    if (newPassword === currentPassword) {
        document.getElementById('newPasswordHelp').style.display = 'block';
        isValid = false;
    } else {
        document.getElementById('newPasswordHelp').style.display = 'none';
    }

    // Kiểm tra độ dài mật khẩu và chứa ít nhất 1 chữ hoa và 1 số
    var passwordValidation = /^(?=.*[A-Z])(?=.*\d).{8,}$/;
    if (!passwordValidation.test(newPassword)) {
        document.getElementById('newPasswordValidation').style.display = 'block';
        isValid = false;
    } else {
        document.getElementById('newPasswordValidation').style.display = 'none';
    }


    // Nếu không hợp lệ, ngăn chặn form gửi đi
    if (!isValid) {
        event.preventDefault();
    }
});

document.addEventListener('DOMContentLoaded', function () {
    const currentPassword = document.getElementById('currentPassword');
    const newPassword = document.getElementById('newPassword');
    const renewPassword = document.getElementById('renewPassword');
    const changePassbtn = document.getElementById('changePassbtn');

    const currentPasswordHelp = document.getElementById('currentPasswordHelp');
    const newPasswordHelp = document.getElementById('newPasswordHelp');
    const newPasswordValidation = document.getElementById('newPasswordValidation');
    const renewPasswordHelp = document.getElementById('renewPasswordHelp');

    function validateForm() {
        let isValid = true;

        // Reset all help messages
        currentPasswordHelp.style.display = 'none';
        newPasswordHelp.style.display = 'none';
        newPasswordValidation.style.display = 'none';
        renewPasswordHelp.style.display = 'none';

        if (!currentPassword.value) {
            currentPasswordHelp.style.display = 'block';
            isValid = false;
        }

        if (!newPassword.value) {
            isValid = false;
        } else if (newPassword.value === currentPassword.value) {
            newPasswordHelp.style.display = 'block';
            isValid = false;
        } else if (!/^(?=.*[A-Z])(?=.*\d).{8,}$/.test(newPassword.value)) {
            newPasswordValidation.style.display = 'block';
            isValid = false;
        }

        if (!renewPassword.value) {
            isValid = false;
        } else if (renewPassword.value !== newPassword.value) {
            renewPasswordHelp.style.display = 'block';
            isValid = false;
        }

        changePassbtn.disabled = !isValid;
    }

    currentPassword.addEventListener('input', validateForm);
    newPassword.addEventListener('input', validateForm);
    renewPassword.addEventListener('input', validateForm);
});