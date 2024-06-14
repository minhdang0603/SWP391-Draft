document.getElementById('userAddForm').addEventListener('submit', function(event) {
    var password = document.getElementById('password').value;
    var repassword = document.getElementById('repassword').value;
    var phoneNumber = document.getElementById('phoneNumber').value;
    var isValid = true;

    // Kiểm tra Password không giống rePassword
    if (password !== repassword) {
        document.getElementById('passwordHelp').style.display = 'block';
        isValid = false;
    } else {
        document.getElementById('passwordHelp').style.display = 'none';
    }

    var passwordValidation = /^(?=.*[A-Z])(?=.*\d).{8,}$/;
    if (!passwordValidation.test(password)) {
        document.getElementById('passwordValidation').style.display = 'block';
        isValid = false;
    } else {
        document.getElementById('passwordValidation').style.display = 'none';
    }

    // Kiểm tra số điện thoại có 9 hoặc 10 chữ số
    if (phoneNumber.length !== 9 && phoneNumber.length !== 10) {
        document.getElementById('phoneNumberError').innerHTML = "Số điện thoại phải có 9 hoặc 10 chữ số!";
        isValid = false;
    } else {
        document.getElementById('phoneNumberError').innerHTML = ""; // Xóa thông báo lỗi nếu hợp lệ
    }

    // Ngăn chặn việc gửi biểu mẫu nếu có lỗi
    if (!isValid) {
        event.preventDefault();
    }

});
