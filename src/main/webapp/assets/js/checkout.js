$(document).ready(function () {
    // Select all elements with class 'price'
    const priceElements = document.querySelectorAll('.price');

    // Function to format number to Vietnamese Dong (VND) format
    function formatVND(n) {
        return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + ' đ';
    }

    // Function to toggle the submit button state
    function toggleSubmitButton() {
        if ($('#terms').is(':checked')) {
            $('.order-submit').prop('disabled', false).removeClass('disabled-btn');
        } else {
            $('.order-submit').prop('disabled', true).addClass('disabled-btn');
        }
    }

    // Format each price element
    priceElements.forEach(function (element) {
        let price = parseFloat(element.textContent.trim()); // Assuming the price is in numeric format

        if (!isNaN(price)) {
            // Format the price using the formatVND function
            element.textContent = formatVND(price);
        }
    });

    // Initial check to set the correct state on page load
    toggleSubmitButton();

    // Event listener for changes to the checkbox
    $('#terms').change(function () {
        toggleSubmitButton();
    });

    $('.phone-number').on('input', function () {
        var phoneValue = $(this).val().replace(/[^0-9]/g, ''); // Remove all non-digit characters
        $(this).val(phoneValue);
        var msg = $(this).next('.msg');
        if (phoneValue.length !== 0 && (!/^0\d{8,9}$/.test(phoneValue))) {
            msg.text('Số điện thoại phải bắt đầu bằng số 0 và có 9 hoặc 10 chữ số!');
        } else {
            msg.text('');
        }
    });
});