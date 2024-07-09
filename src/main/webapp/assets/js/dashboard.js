$(document).ready(function() {
    // Function to format numbers as VND
    function formatVND(amount) {
        return new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND'
        }).format(amount);
    }

    // Format initial revenue amount
    var initialRevenue = $('#revenue-amount').text();
    var formattedInitialRevenue = formatVND(parseFloat(initialRevenue.replace(/[^\d.-]/g, '')));
    $('#revenue-amount').text(formattedInitialRevenue);

    formatAllAmount();


    $('.filter-option').on('click', function() {
        var filterType = $(this).data('filter');
        $('#filter-label').text('| ' + $(this).text());

        $.ajax({
            url: 'home',  // Ensure this matches the @WebServlet URL pattern
            type: 'POST',
            data: { filterType: filterType },
            dataType: 'json',  // Ensure the expected response type is JSON
            success: function(response) {
                var totalSales = response.totalSales;  // Assuming response contains totalSales
                $('#sales-count').text(totalSales);
            },
            error: function(xhr, status, error) {
                console.error("Error: ", error);
                console.error("Status: ", status);
                console.error("Response: ", xhr.responseText);
            }
        });
    });



    $('.filter-option-revenue').on('click', function() {
        var filterType = $(this).data('filter');
        $('#revenue-filter-label').text('| ' + $(this).text());

        $.ajax({
            url: 'home',  // Ensure this matches the @WebServlet URL pattern
            type: 'POST',
            data: { filterType: filterType },
            dataType: 'json',  // Ensure the expected response type is JSON
            success: function(response) {
                var totalRevenue = response.totalRevenue;  // Assuming response contains totalRevenue
                var formattedRevenue = formatVND(totalRevenue);
                $('#revenue-amount').text(formattedRevenue);
            },
            error: function(xhr, status, error) {
                console.error("Error: ", error);
                console.error("Status: ", status);
                console.error("Response: ", xhr.responseText);
            }
        });
    });
})

$(document).ready(function () {
    $('#myTable').DataTable({
    });
});

function formatVND(n) {
    return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + ' đ';
}

function formatAllAmount() {
    document.querySelectorAll('.payment-amount').forEach(function (element) {
        var price = parseFloat(element.textContent.replace(/[^\d.-]/g, '')); // Extract the numerical value from the price element
        element.textContent = formatVND(price); // Format the price and set it back to the element
    });
}