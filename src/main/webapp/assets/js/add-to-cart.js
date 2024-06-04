$(document).ready(function () {
    function updateCheckCart() {
        const checkCart = document.querySelector('.check-cart');
        checkCart.textContent = parseInt(checkCart.textContent) + 1;
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
                alert('Thêm sản phẩm vào giỏ hàng thành công!');
                location.reload();
                updateCheckCart();
            },
            error: function () {
                // Handle error
                alert("An error occurred while processing the request.");
            }
        });
    });
});