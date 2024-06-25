function validateFileType() {
    const fileInput = document.getElementById('fileUpload');
    const fildAdd = document.getElementById('image');
    const filePath = fileInput.value;
    const addFile = fileAdd.value;
    const allowedExtensions = /(\.jpg|\.jpeg|\.png|\.img)$/i;

    if (!allowedExtensions.exec(filePath)) {
        alert('Vui lòng upload file có định dạng .jpg, .jpeg, .png, hoặc .img');
        fileInput.value = '';
        return false;
    }

    return true;
}

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
            {width: "50%", targets: 1} // Set width of second column (index 1) to 50%
        ]
    });
});
document.addEventListener('DOMContentLoaded', function () {
    toggleFields();  // Initial check on page load
});

function validateForm() {
    const createButton = document.getElementById('createButton');

    let isValid = true;

    // Kiểm tra trường productName nếu đã nhập dữ liệu
    var productName = document.getElementById('productName').value.trim();
    if (productName === '') {
        document.getElementById('productNameError').textContent = 'Vui lòng nhập tên sản phẩm.';
        isValid = false;
    } else {
        document.getElementById('productNameError').textContent = '';
    }

    // Kiểm tra trường unitPrice
    var unitPrice = document.getElementById('unitPrice').value.trim();
    if (unitPrice === '') {
        document.getElementById('unitPriceError').textContent = 'Vui lòng nhập đơn giá.';
        isValid = false;
    } else if (isNaN(unitPrice) || unitPrice <= 0 || unitPrice.indexOf('.') !== -1) {
        document.getElementById('unitPriceError').textContent = 'Đơn giá phải là số nguyên lớn hơn 0.';
        isValid = false;
    } else {
        document.getElementById('unitPriceError').textContent = '';
    }

    // Kiểm tra trường stockUnit
    var stockUnit = document.getElementById('stockUnit').value.trim();
    if (stockUnit === '') {
        document.getElementById('stockUnitError').textContent = 'Vui lòng nhập số lượng sản phẩm.';
        isValid = false;
    } else if (isNaN(stockUnit) || stockUnit <= 0 || stockUnit.indexOf('.') !== -1) {
        document.getElementById('stockUnitError').textContent = 'Số lượng sản phẩm phải là số nguyên lớn hơn 0.';
        isValid = false;
    } else {
        document.getElementById('stockUnitError').textContent = '';
    }

    // Kiểm tra trường image (file) nếu đã chọn file
    var fileInput = document.getElementById('image');
    var filePath = fileInput.value;
    var allowedExtensions = /(\.jpg|\.jpeg|\.png|\.img)$/i;
    if (filePath !== '') {
        if (!allowedExtensions.exec(filePath)) {
            document.getElementById('imageError').textContent = 'Định dạng file ảnh không hợp lệ. Chỉ chấp nhận các định dạng: .jpg, .jpeg, .png, .img.';
            isValid = false;
        } else {
            document.getElementById('imageError').textContent = '';
        }
    }

    createButton.disabled = !isValid;
}

function toggleFields() {
    const category = document.getElementById('productCategory').value;
    const conditionalFields = document.getElementById('conditionalFields');
    if (category === '1' || category === '2') {
        conditionalFields.style.display = 'block';
    } else {
        conditionalFields.style.display = 'none';
    }
}


function resetForm() {
    document.getElementById('productForm').reset();
    document.getElementById('createButton').disabled = true;
    document.getElementById('productNameError').textContent = '';
    document.getElementById('unitPriceError').textContent = '';
    document.getElementById('conditionalFields').style.display = 'none';
}

function showProductDetails(categoryId, producID) {
    var productDetailsModal = new bootstrap.Modal(document.getElementById('productDetailsModal' + producID));
    productDetailsModal.show();
}

function editModal(categoryId, producID) {
    var productUpdateModal = new bootstrap.Modal(document.getElementById('productUpdateModal' + producID));
    productUpdateModal.show();
}

function confirmMod() {
    var confirmModal = new bootstrap.Modal(document.getElementById('confirmModal'));
    confirmModal.show();
}

function deleteModal(id) {
    var deleteModal = new bootstrap.Modal(document.getElementById('myModal' + id));
    deleteModal.show();
}