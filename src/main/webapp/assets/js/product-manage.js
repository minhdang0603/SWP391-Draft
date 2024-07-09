let isValid4 = true;
let isValid5 = true;
let isValid6 = true;
let isValid7 = true;
let isValid8 = true;

function validateProductName(id) {
    const productName = document.getElementById("productNameUpdate" + id).value.trim();
    const updateButton = document.getElementById('updateButton' + id);
    if (productName.length === 0) {
        showError("productNameUpdateError" + id, "Tên sản phẩm không được để trống.");
        isValid4 = false;
    } else {
        clearError("productNameUpdateError" + id);
        isValid4 = true;
    }
    checkIsValidUpdate(id);
}

function validateUnitPrice(id) {
    const unitPrice = document.getElementById("unitPriceUpdate" + id).value;
    const updateButton = document.getElementById('updateButton' + id);
    if (unitPrice === "" || isNaN(unitPrice) || unitPrice < 0) {
        showError("unitPriceUpdateError" + id, "Đơn giá phải là một số lớn hơn hoặc bằng 0.");
        isValid5 = false;
    } else {
        clearError("unitPriceUpdateError" + id);
        isValid5 = true;
    }
    checkIsValidUpdate(id);
}

function validateStockUnit(id) {
    const stockUnit = document.getElementById("stockUnitUpdate" + id).value;
    const updateButton = document.getElementById('updateButton' + id);

    if (stockUnit === "" || isNaN(stockUnit) || stockUnit < 0) {
        showError("stockUnitUpdateError" + id, "Tồn kho phải là một số lớn hơn hoặc bằng 0.");
        isValid7 = false;

    } else {
        clearError("stockUnitUpdateError" + id);
        isValid7 = true;

    }
    checkIsValidUpdate(id);
}

function validateSoldUnit(id) {
    const soldUnit = document.getElementById("soldUnitUpdate" + id).value;
    const updateButton = document.getElementById('updateButton' + id);

    if (soldUnit === "" || isNaN(soldUnit) || soldUnit < 0) {
        showError("soldUnitUpdateError" + id, "Đã bán phải là một số lớn hơn hoặc bằng 0.");
        isValid6 = false;

    } else {
        clearError("soldUnitUpdateError" + id);
        isValid6 = true;

    }
    checkIsValidUpdate(id);
}

function validateImage(id) {
    const imageInput = document.getElementById("fileUpload" + id);
    const imagePreview = document.getElementById("imagePreview" + id);
    const updateButton = document.getElementById('updateButton' + id);
    let currentImageSrc = "/laptop-tg/assets/img/product-img/" + id + ".png";

    const allowedExtensions = /(\.jpg|\.jpeg|\.png|\.img)$/i;

    const file = imageInput.files[0];

    // Kiểm tra định dạng file chỉ khi có sự thay đổi trong src của ảnh
    if (imagePreview.src !== currentImageSrc) {
        if (!allowedExtensions.test(file.name)) {
            showError("imageUpdateError" + id, "Chỉ chấp nhận các định dạng file: .jpg, .jpeg, .png, .img.");
            updateButton.disabled = true;
            imagePreview.style.display = "none"; // Ẩn ảnh preview nếu file không hợp lệ
        } else {
            clearError("imageUpdateError" + id);
            updateButton.disabled = false;
            const reader = new FileReader();
            reader.onload = function (e) {
                imagePreview.src = e.target.result;
                imagePreview.style.display = "block"; // Hiển thị ảnh preview khi file hợp lệ
            };
            reader.readAsDataURL(file);
        }
    } else {
        clearError("imageUpdateError" + id);
        updateButton.disabled = false;
    }
}


function showError(elementId, message) {
    const errorElement = document.getElementById(elementId);
    errorElement.textContent = message;
    errorElement.style.display = "block";
}

function clearError(elementId) {
    const errorElement = document.getElementById(elementId);
    errorElement.textContent = "";
    errorElement.style.display = "none";
}

function checkIsValidUpdate(id) {
    const update = document.getElementById('updateButton' + id);
    if (isValid4 === true && isValid5 === true && isValid6 === true && isValid7 === true) {
        update.disabled = false;
        return;
    }
    update.disabled = true;
}

document.addEventListener("DOMContentLoaded", function () {
    var msgDiv = document.getElementById('msg');
    var msgContent = document.getElementById('msgContent');
    // Kiểm tra nội dung của thẻ h1
    if (msgContent.textContent.trim() !== "") {
        setTimeout(function () {
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
const createButton = document.getElementById('createButton');
const productName = document.getElementById('productName');
const unitPrice = document.getElementById('unitPrice');
const stockUnit = document.getElementById('stockUnit');
const fileInput = document.getElementById('image');
let isValid1 = false;
let isValid2 = false;
let isValid3 = false;


/*
    ------------- check valid add product ------------------------
 */
productName.addEventListener('input', () => {
    const val1 = productName.value;
    if (val1.trim().length === 0) {
        document.getElementById('productNameError').textContent = 'Vui lòng nhập tên sản phẩm.';
        isValid1 = false;
    } else {
        document.getElementById('productNameError').textContent = '';
        isValid1 = true;
    }
    checkIsValidCreate();
});

        unitPrice.addEventListener('input', () => {
            const val1 = unitPrice.value;
            if (val1.length === 0) {
                document.getElementById('unitPriceError').textContent = 'Vui lòng nhập đơn giá.';
                isValid2 = false;
            } else if (isNaN(val1) || val1 <= 0 || val1.indexOf('.') !== -1) {
                document.getElementById('unitPriceError').textContent = 'Đơn giá phải là số nguyên lớn hơn 0.';
                isValid2 = false;
            } else {
                document.getElementById('unitPriceError').textContent = '';
                isValid2 = true;
            }
            checkIsValidCreate();
        });
        stockUnit.addEventListener('input', () => {
            const val1 = stockUnit.value;
            if (val1.length === 0) {
                document.getElementById('stockUnitError').textContent = 'Vui lòng nhập số lượng.';
                isValid3 = false;
            } else if (isNaN(val1) || val1 < 0 || val1.indexOf('.') !== -1) {
                document.getElementById('stockUnitError').textContent = 'Vui lòng nhập số nguyên từ 0.';
                isValid3 = false;
            } else {
                document.getElementById('stockUnitError').textContent = '';
                isValid3 = true;
            }
            checkIsValidCreate();
        });

        function checkIsValidCreate() {
            if (isValid1 === true && isValid2 === true && isValid3 === true) {
                createButton.disabled = false;
                return;
            }
            createButton.disabled = true;
        }

        fileInput.addEventListener('input', () => {
            let isValid = true;
            // Kiểm tra trường image (file) nếu đã chọn file
            const filePath = fileInput.value;
            const allowedExtensions = /(\.jpg|\.jpeg|\.png|\.img)$/i;
            if (filePath !== '') {
                if (!allowedExtensions.exec(filePath)) {
                    document.getElementById('imageError').textContent = 'Định dạng file ảnh không hợp lệ. Chỉ chấp nhận các định dạng: .jpg, .jpeg, .png, .img.';
                    isValid = false;
                } else {
                    document.getElementById('imageError').textContent = '';
                }
            }
            createButton.disabled = !isValid;
        });

        /*
            ------------- END check valid add product ------------------------
         */


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