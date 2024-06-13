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

function submitForm() {
    var form = document.querySelector(".category-form");
    form.submit();
}

function getSelectedBrands() {
    let selectedBrands = [];
    $('.brand-checkbox:checked').each(function () {
        selectedBrands.push($(this).attr('id').split('-')[1]); // Lấy ID của thương hiệu
    });
    return selectedBrands.join(',');
}

function getSelectedPrice() {
    return $('.input-select').val();
}

function getCategory() {
    var spanElement = document.querySelector('.hide.category-id');
    return spanElement ? spanElement.textContent : 0;
}

$(document).ready(function () {
    formatAllPrices();
    controlLoadMoreButton();
    // Event delegation for "Add to Cart" button
    $('.product-list').on('click', '.add-to-cart-btn', function (event) {
        event.preventDefault();
        let $button = $(this);
        let productId = $button.data('product-id');
        let servletUrl = $button.data('servlet-url');
        let action = $button.data('action');

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

        let ammout = document.getElementsByClassName('product').length;
        let cateId = $(this).data('cate-id');
        let cateName = $(this).data('cate-name');
        let selectedBrands = getSelectedBrands();
        let selectedPrice = getSelectedPrice();

        // Add your AJAX request or other logic here to load more products
        $.ajax({
            url: 'load', // Replace with your URL
            method: 'GET',
            data: {
                existedProduct: ammout,
                cateId: cateId,
                selectedPrice: selectedPrice,
                selectedBrands: selectedBrands
            },
            success: function (data) {
                var productList = $('.product-list');
                var size = $(data).find('.product').length;
                if (parseInt(size) % 3 !== 0 || parseInt(size) === 0) {
                    $('#load-more-btn').hide();
                } else {
                    $('#load-more-btn').show();
                }

                productList.append(data);// Append new products to the product list
                formatAllPrices();

            },
            error: function (error) {
                console.log(error);
            }
        });
    });

    $('.brand-checkbox').on('change', function () {
        let selectedBrands = getSelectedBrands();
        let selectedValue = getSelectedPrice();
        let category = getCategory();
        // Make AJAX request to get products by selected brands
        loadProductsBySorting(selectedValue, selectedBrands, category);
    });

    $('.input-select').on('change', function () {
        // Get the selected sorting option value
        let selectedValue = getSelectedPrice();
        let selectedBrands = getSelectedBrands();
        let category = getCategory();
        // Load products based on the selected sorting option
        loadProductsBySorting(selectedValue, selectedBrands, category);
    });

    function loadProductsBySorting(price, brands, category) {
        // Add your logic to load products based on the sorting option
        // For example, make an AJAX request to the server to fetch sorted products
        console.log(category);
        $.ajax({
            url: 'store', // Replace with your URL
            method: 'POST',
            data: {
                brands: brands,
                price: price,
                category: category
            },
            success: function (data) {

                var size = $(data).find('.product').length;
                if (parseInt(size) % 3 !== 0 || parseInt(size) === 0) {
                    $('#load-more-btn').hide();
                } else {
                    $('#load-more-btn').show();
                }

                // Update the product list with the newly sorted products
                $('.product-list').html(data);
                formatAllPrices();
            },
            error: function (error) {
                console.log(error);
            }
        });
    }

    function controlLoadMoreButton() {
        let controller = $('.product').length;
        if (parseInt(controller) % 3 !== 0) {
            $('#load-more-btn').hide();
        } else {
            $('#load-more-btn').show();
        }
    }
});