const p1 = document.querySelector('.password-1');
const p2 = document.querySelector('.password-2');
const msg1 = document.querySelector('.msg1');
const msg2 = document.querySelector('.msg2');
const btn = document.querySelector('.btn');
let isValid1 = false;
let isValid2 = false;


p2.addEventListener('input', () => {
    const val1 = p1.value;
    const val2 = p2.value;
    if (val1 !== val2) {
        msg2.textContent = "Xác nhận mật khẩu không chính xác!";
        isValid2 = false;
    } else {
        msg2.textContent = "";
        isValid2 = true;
    }
    checkIsValid();
});

p1.addEventListener('input', () => {
    const val1 = p1.value;
    let regexPattern= '^(?=.*[A-Z])(?=.*\\d).{8,32}$';
    if (!verifyRegex(val1, regexPattern)) {
        msg1.textContent = "* Mật khẩu phải từ 8 đến 32 ký tự. Bao gồm ít nhất một chữ cái viết hoa. Bao gồm ít nhất một ký tự số";
        isValid1 = false;
    } else {
        msg1.textContent = "";
        isValid1 = true;
    }
});

function checkIsValid() {
    if (isValid1 === true && isValid2 === true){
        btn.disabled = false;
        return;
    }
    btn.disabled = true;
}

function verifyRegex(inputString, regexPattern) {
    // Create a RegExp object from the provided pattern
    let regex = new RegExp(regexPattern);

    // Test the input string against the regex
    return regex.test(inputString);
}


