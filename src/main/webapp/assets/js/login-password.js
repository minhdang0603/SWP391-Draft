const pass = document.querySelector('.password');
const msg = document.querySelector('.msg');
const btn = document.querySelector('.btn');

pass.addEventListener('input', () => {
    const val1 = pass.value;
    let regexPattern= '^(?=.*[A-Z])(?=.*\\d).{8,32}$';
    if (!verifyRegex(val1, regexPattern)) {
        msg.textContent = "* Mật khẩu phải từ 8 đến 32 ký tự. Bao gồm ít nhất một chữ cái viết hoa. Bao gồm ít nhất một ký tự số";
        btn.disabled = true;
    } else {
        msg.textContent = "";
        btn.disabled = false;
    }
});

function verifyRegex(inputString, regexPattern) {
    // Create a RegExp object from the provided pattern
    let regex = new RegExp(regexPattern);

    // Test the input string against the regex
    return regex.test(inputString);
}

