

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

// Hàm để định dạng giá trị thành tiền tệ VND
function formatCurrencyVND(value) {
    return value.toLocaleString('vi-VN', {
        style: 'currency',
        currency: 'VND'
    });
}

// Hàm để định dạng tất cả các giá trị trong các ô chứa giá trị tiền tệ
function formatAllCurrency() {
    var priceCells = document.getElementsByClassName('pricevnd');

    for (var i = 0; i < priceCells.length; i++) {
        var value = parseFloat(priceCells[i].innerText.replace(/,/g, '')); // Loại bỏ dấu phẩy nếu có
        if (!isNaN(value)) {
            priceCells[i].innerText = formatCurrencyVND(value);
        }
    }
}

// Gọi hàm để định dạng các giá trị tiền tệ khi trang được tải
document.addEventListener('DOMContentLoaded', formatAllCurrency);

document.addEventListener('DOMContentLoaded', function() {
    var deliveryDateInput = document.getElementById('deliveryDate');
    var receivedDateInput = document.getElementById('receivedDate');

    if (deliveryDateInput.value === 'N/A') {
        deliveryDateInput.value = '';
    }

    if (receivedDateInput.value === 'N/A') {
        receivedDateInput.value = '';
    }
});
function printModal() {
    var printContents = document.querySelector('.modal-body').innerHTML;
    var originalContents = document.body.innerHTML;

    document.body.innerHTML = printContents;

    window.print();

    document.body.innerHTML = originalContents;
    window.location.reload();  // Để tải lại trang và khôi phục nội dung ban đầu
}