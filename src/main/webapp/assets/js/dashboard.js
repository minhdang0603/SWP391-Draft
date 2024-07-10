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
    // $('#myTable').DataTable({
    // });
    // $('#myRatingTable').DataTable({
    // });
    $('.display').DataTable({
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

document.addEventListener("DOMContentLoaded", function() {
    const rowsPerPage = 5;
    let currentPage = 1;
    const tableBody = document.getElementById("ratingBody");
    const rows = Array.from(tableBody.getElementsByTagName("tr"));

    function renderTable(page, filteredRows) {
        tableBody.innerHTML = "";
        const start = (page - 1) * rowsPerPage;
        const end = start + rowsPerPage;
        const paginatedRows = filteredRows.slice(start, end);

        paginatedRows.forEach(row => {
            tableBody.appendChild(row);
        });

        document.getElementById("pageInfo").innerText = `Page ${page} of ${Math.ceil(filteredRows.length / rowsPerPage)}`;
        renderPagination(filteredRows.length, page);
    }

    function parseDateString(dateString) {
        const [day, month, year, time] = dateString.split(/[\s/:]+/);
        return new Date(`${month}-${day}-${year}`);
    }

    function filterTable() {
        const scoreFilter = document.getElementById("searchScore").value.trim();
        const dateFilter = document.getElementById("searchDate").value.trim();

        const filteredRows = rows.filter(row => {
            const score = row.cells[4].innerText;
            const dateText = row.cells[3].innerText;
            const date = parseDateString(dateText);
            let showRow = true;

            if (scoreFilter && !score.includes(scoreFilter)) {
                showRow = false;
            }
            if (dateFilter) {
                const filterDate = new Date(dateFilter);
                if (date.toDateString() !== filterDate.toDateString()) {
                    showRow = false;
                }
            }

            return showRow;
        });

        renderTable(1, filteredRows);
    }

    function renderPagination(totalRows, currentPage) {
        const totalPages = Math.ceil(totalRows / rowsPerPage);
        const pagination = document.getElementById("pagination");
        pagination.innerHTML = "";

        for (let i = 1; i <= totalPages; i++) {
            const pageButton = document.createElement("button");
            pageButton.classList.add("btn", "btn-primary");
            pageButton.innerText = i;
            pageButton.disabled = (i === currentPage);
            pageButton.addEventListener("click", function() {
                renderTable(i, filterRows());
            });
            pagination.appendChild(pageButton);
        }
    }

    function filterRows() {
        const scoreFilter = document.getElementById("searchScore").value.trim();
        const dateFilter = document.getElementById("searchDate").value.trim();

        return rows.filter(row => {
            const score = row.cells[4].innerText;
            const dateText = row.cells[3].innerText;
            const date = parseDateString(dateText);
            let showRow = true;

            if (scoreFilter && !score.includes(scoreFilter)) {
                showRow = false;
            }
            if (dateFilter) {
                const filterDate = new Date(dateFilter);
                if (date.toDateString() !== filterDate.toDateString()) {
                    showRow = false;
                }
            }

            return showRow;
        });
    }

    document.getElementById("searchScore").addEventListener("input", filterTable);
    document.getElementById("searchDate").addEventListener("input", filterTable);

    // Initial render
    renderTable(currentPage, rows);
});



