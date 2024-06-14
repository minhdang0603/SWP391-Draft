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

    // if (!allowedExtensions.exec(addFile)) {
    //     alert('Vui lòng upload file có định dạng .jpg, .jpeg, .png, hoặc .img');
    //     fileInput.value = '';
    //     return false;
    // }

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
        }, 2000);
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
    const productName = document.getElementById('productName').value;
    const unitPrice = document.getElementById('unitPrice').value;
    const createButton = document.getElementById('createButton');

    let isValid = true;

    // Validate Product Name
    const productNameError = document.getElementById('productNameError');
    if (productName.trim() === '') {
        productNameError.textContent = 'Tên sản phẩm là bắt buộc.';
        isValid = false;
    } else {
        productNameError.textContent = '';
    }

    // Validate Unit Price
    const unitPriceError = document.getElementById('unitPriceError');
    if (unitPrice.trim() === '' || isNaN(unitPrice) || parseInt(unitPrice) < 0 || !Number.isInteger(Number(unitPrice))) {
        unitPriceError.textContent = 'Đơn giá phải là số nguyên không âm.';
        isValid = false;
    } else {
        unitPriceError.textContent = '';
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