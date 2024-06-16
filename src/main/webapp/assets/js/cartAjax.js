$(document).ready(function () {
    // Hàm định dạng số tiền VND
    function formatVND(n) {
        return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + ' đ';
    }

    function updateTotal() {
        var total = 0;
        $(".product").each(function () {
            var quantity = parseInt($(this).find('.input-number').val(), 10); // Parse quantity as an integer
            var price = parseFloat($(this).find('.price').text().replace(/\./g, '').replace(/,/g, '').replace(' đ', '')); // Parse price as a float
            total += quantity * price;
        });
        $("#total").text(formatVND(total)); // Format and update the total
    }

    function updateCheckCart() {
        const checkCart = document.querySelector('.check-cart');
        checkCart.textContent = parseInt(checkCart.textContent) - 1;
        if (parseInt(checkCart.textContent) === 0) {
            location.reload();
        }
    }

    $(".btn-number").on('click', function () {
        var $button = $(this);
        var oldValue = $button.closest('.input-group').find("input").val();
        var newVal = 0;
        var productId = $button.data('product-id');
        var servletUrl = $button.data('servlet-url');
        var action = $button.data('action');
        var productName = $button.closest('.product').find('.product-name-a').text();
        var maxUnit = $button.data('max');
        if(parseInt(oldValue) === maxUnit){
            window.alert('Số lượng sản phẩm không đủ!')
            return;
        }

        if ($button.data('type') === "minus") {
            newVal = parseInt(oldValue) - 1;
        } else if ($button.data('type') === "plus") {
            newVal = parseInt(oldValue) + 1;
        }

        if (newVal < 1) {
            var confirm = window.confirm("Bạn có muốn xóa sản phẩm '" + productName + "' không?");
            if (!confirm) {
                newVal += 1;
            }
        }

        if (confirm) {
            $.ajax({
                type: "POST",
                url: servletUrl,
                data: {productId: productId, action: 'delete'},
                success: function (data) {
                    // Remove the product element from the DOM
                    $button.closest('.product').remove();
                    updateTotal();
                    updateCheckCart();
                },
                error: function () {
                    // Handle error
                    alert("An error occurred while processing the request.");
                }
            });
            return;
        }
        // Make AJAX request to servlet
        $.ajax({
            type: "POST",
            url: servletUrl,
            data: {productId: productId, quantity: newVal, action: action},
            success: function (data) {
                $button.closest('.input-group').find("input").val(newVal);
                updateTotal();
            },
            error: function () {
                // Handle error
                alert("An error occurred while processing the request.");
            }
        });

    });

    $(".delete-item").click(function (event) {
        event.preventDefault();
        var $link = $(this);
        var productId = $link.data('product-id');
        var servletUrl = $link.data('servlet-url');
        var productName = $link.closest('.product').find('.product-name-a').text();
        var action = $link.data('action');

        // Display a confirmation dialog
        var confirmed = window.confirm("Bạn có muốn xóa sản phẩm '" + productName + "' không?");

        if (confirmed) {
            // Make AJAX request to delete item
            $.ajax({
                type: "POST",
                url: servletUrl,
                data: {productId: productId, action: action},
                success: function (data) {
                    // Remove the product element from the DOM
                    $link.closest('.product').remove();
                    updateTotal();
                    updateCheckCart();
                },
                error: function () {
                    // Handle error
                    alert("An error occurred while processing the request.");
                }
            });
        }
    });

    $(window).on('load', function() {
        const quantityError = document.querySelector('.quantity-error');
        if (quantityError && quantityError.textContent.trim() !== '') {
            window.alert(quantityError.textContent);
        }
    });
});