$(document).ready(function () {
    function updateCheckCart(cartCount) {
        let checkCart = document.querySelector('.check-cart');
        if (!checkCart) {
            // Create the check-cart element if it does not exist
            checkCart = document.createElement('div');
            checkCart.className = 'qty check-cart';
            // Find the container where it should be appended, e.g., a parent div
            let parentElement = document.querySelector('.cart-container'); // Adjust this selector as needed
            parentElement.appendChild(checkCart);
        }
        checkCart.textContent = cartCount;
    }

    function showToast(message) {
        const toastContainer = document.getElementById('toast-container');
        const toast = document.createElement('div');
        toast.className = 'toast';
        toast.textContent = message;

        toastContainer.appendChild(toast);

        // Show the toast
        setTimeout(() => {
            toast.classList.add('show');
        }, 100); // Delay to trigger the CSS transition

        // Hide the toast after 3 seconds
        setTimeout(() => {
            toast.classList.remove('show');
            toast.classList.add('hide');

            // Remove the toast from DOM after the hide animation
            setTimeout(() => {
                toastContainer.removeChild(toast);
            }, 500);
        }, 3000);
    }

    $(".add-to-cart-btn").click(function (event) {
        event.preventDefault();
        var $button = $(this);
        var productId = $button.data('product-id');
        var servletUrl = $button.data('servlet-url');
        var action= $button.data('action');

        $.ajax({
            type: "POST",
            url: servletUrl,
            data: {id: productId, action: action},
            success: function (data) {
                showToast(data.successMsg);
                updateCheckCart(data.checkCart);
            },
            error: function () {
                // Handle error
                alert("An error occurred while processing the request.");
            }
        });
    });
});