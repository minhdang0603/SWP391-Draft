const currentPassword = document.getElementById('currentPassword');
const newPassword = document.getElementById('newPassword');
const renewPassword = document.getElementById('renewPassword');
const currentPassHelp = document.getElementById('currentPasswordHelp');
const newPassHelp = document.getElementById('newPasswordHelp');
const reNewPassHelp = document.getElementById('renewPasswordHelp');
const changePassBtn = document.getElementById('changePassbtn');
let isValid1 = false;
let isValid2 = false;
let isValid3 = false;

currentPassword.addEventListener('input', () => {
    const val = currentPassword.value;
    if(val.length === 0) {
        currentPassHelp.textContent = "Không được để trống!";
        isValid3 = false;
    } else {
        currentPassHelp.textContent = "";
        isValid3 = true;
    }
});

renewPassword.addEventListener('input', () => {
    const val1 = newPassword.value;
    const val2 = renewPassword.value;
    if (val1 !== val2) {
        reNewPassHelp.textContent = "Xác nhận mật khẩu không chính xác!";
        isValid2 = false;
    } else {
        reNewPassHelp.textContent = "";
        isValid2 = true;
    }
    checkIsValid();
});

newPassword.addEventListener('input', () => {
    const val1 = newPassword.value;
    const val2 = currentPassword.value;
    let regexPattern= '^(?=.*[A-Z])(?=.*\\d).{8,32}$';
    if (!verifyRegex(val1, regexPattern)) {
        newPassHelp.textContent = "* Mật khẩu phải từ 8 đến 32 ký tự. Bao gồm ít nhất một chữ cái viết hoa. Bao gồm ít nhất một ký tự số";
        isValid1 = false;
    } else if(val1 === val2){
        newPassHelp.textContent = "Mật khẩu mới không được trùng với mật khẩu cũ!";
        isValid1 = false;
    } else {
        newPassHelp.textContent = "";
        isValid1 = true;
    }
});

function checkIsValid() {
    if (isValid1 === true && isValid2 === true && isValid3 === true){
        changePassBtn.disabled = false;
        return;
    }
    changePassBtn.disabled = true;
}

function verifyRegex(inputString, regexPattern) {
    // Create a RegExp object from the provided pattern
    let regex = new RegExp(regexPattern);

    // Test the input string against the regex
    return regex.test(inputString);
}