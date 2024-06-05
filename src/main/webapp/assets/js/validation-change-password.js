document.getElementById('changePasswordForm').addEventListener('submit', function(event) {
    event.preventDefault(); // Ngăn chặn form gửi đi mặc định

    var newPassword = document.getElementById('newPassword').value;
    var renewPassword = document.getElementById('renewPassword').value;
    var isValid = true;

    // Kiểm tra độ dài mật khẩu và chứa ít nhất 1 chữ hoa và 1 số
    var passwordValidation = /^(?=.*[A-Z])(?=.*\d).{8,}$/;
    if (!passwordValidation.test(newPassword)) {
        document.getElementById('newPasswordValidation').style.display = 'block';
        isValid = false;
    } else {
        document.getElementById('newPasswordValidation').style.display = 'none';
    }

    // Kiểm tra xem newPassword và renewPassword có giống nhau không
    if (newPassword !== renewPassword) {
        document.getElementById('renewPasswordHelp').style.display = 'block';
        isValid = false;
    } else {
        document.getElementById('renewPasswordHelp').style.display = 'none';
    }

    // Nếu tất cả đều hợp lệ, submit form
    if (isValid) {
        this.submit();
    }
});