// Hàm định dạng số tiền VND
function formatVND(n) {
    return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + ' đ';
}

// Iterate over each product price element and format it to VND
function formatAllPrices() {
    document.querySelectorAll('.product-price').forEach(function (element) {
        var price = parseFloat(element.textContent.replace(/[^\d.-]/g, '')); // Extract the numerical value from the price element
        element.textContent = formatVND(price); // Format the price and set it back to the element
    });
}

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

function submitForm(){
    var form = document.querySelector(".category-form");
    form.submit();
}

$(document).ready(function () {
    formatAllPrices();
    // Event delegation for "Add to Cart" button
    $('.product-list').on('click', '.add-to-cart-btn', function (event) {
        event.preventDefault();
        var $button = $(this);
        var productId = $button.data('product-id');
        var servletUrl = $button.data('servlet-url');
        var action = $button.data('action');

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

    $('#load-more-btn').click(function (event) {
        event.preventDefault();

        var ammout = document.getElementsByClassName('product').length;
        var cateId = $(this).data('cate-id');
        var cateName = $(this).data('cate-name');

        // Add your AJAX request or other logic here to load more products
        $.ajax({
            url: 'load', // Replace with your URL
            method: 'GET',
            data: {
                existedProduct: ammout,
                cateId: cateId
            },
            success: function (data) {
                var productList = $('.product-list');

                if (data.trim() === '') {
                    // Hide the Load More button and notify the user
                    $('#load-more-btn').hide();
                    showToast('LaptopTG đã hết sản phẩm ' + cateName);
                } else {
                    productList.append(data); // Append new products to the product list
                    formatAllPrices();
                }
            },
            error: function (error) {
                console.log(error);
            }
        });
    });

    $('.brand-checkbox').on('change', function() {
        let selectedBrands = [];

        // Collect all checked brand IDs
        $('.brand-checkbox:checked').each(function() {
            selectedBrands.push($(this).attr('id').split('-')[1]); // Extract the ID part
        });

        // Make AJAX request to get products by selected brands
        $.ajax({
            url: 'store', // Your servlet URL
            method: 'POST',
            data: {
                brands: selectedBrands
            },
            success: function(response) {
                // Assuming response contains the HTML to display products
                $('#product-container').html(response);
            },
            error: function(error) {
                console.error('Error fetching products:', error);
            }
        });
    });
});