const form = document.getElementById('myform');
const msg3 = document.querySelector('.msg3');

form.addEventListener('submit', (event) => {
    event.preventDefault();
    const isValid = validateRecaptcha();
    if (isValid) {
        form.submit();
    } else {
        msg3.textContent = 'Vui lòng chọn captcha';
    }
});

function validateRecaptcha() {
    const response = grecaptcha.getResponse();
    if (response.length === 0) {
        return false;
    }
    return true;
}