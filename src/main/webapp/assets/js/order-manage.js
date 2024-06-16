

document.addEventListener("DOMContentLoaded", function () {
    var msgDiv = document.getElementById('msg');
    var msgContent = document.getElementById('msgContent');
    // Kiểm tra nội dung của thẻ h1
    if (msgContent.textContent.trim() !== "") {
        setTimeout(function (){
            msgDiv.classList.add('show');
            setTimeout(function () {
                msgDiv.classList.remove('show');
                setTimeout(function () {
                    msgDiv.style.display = 'none';
                }, 600); // Chờ thời gian chuyển tiếp để hoàn thành
            }, 3000); // Hiển thị thông báo trong 3 giây
        }, 500);
    }
});
$(document).ready(function () {
    $('#myTable').DataTable({
        columnDefs: [
            {width: "30%", targets: 1},
            {width: "30%", targets: 2}// Set width of second column (index 1) to 50%
        ]
    });
});


function showOrderDetails(orderID) {
    var orderDetailsModal = new bootstrap.Modal(document.getElementById('orderDetailsModal' + orderID));
    orderDetailsModal.show();
}

function editModal(orderID) {
    var orderUpdateModal = new bootstrap.Modal(document.getElementById('orderUpdateModal' + orderID));
    orderUpdateModal.show();
}

function deleteModal(id) {
    var deleteModal = new bootstrap.Modal(document.getElementById('myModal' + id));
    deleteModal.show();
}

// Function to calculate the total price
function calculateTotalPrice() {
    var totalPrice = 0;
    var productTotals = document.getElementsByClassName('product-total');

    for (var i = 0; i < productTotals.length; i++) {
        totalPrice += parseFloat(productTotals[i].innerText);
    }

    document.getElementById('totalPrice').innerText = totalPrice.toLocaleString('vi-VN', {
        style: 'currency',
        currency: 'VND'
    });
}

// Call the function to calculate total price on page load
document.addEventListener('DOMContentLoaded', calculateTotalPrice);