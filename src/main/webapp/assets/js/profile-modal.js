document.addEventListener('DOMContentLoaded', function () {
    const updateSuccess = document.getElementById('updateSuccess');
    const passwordChangeSuccess = document.getElementById('passwordChangeSuccess');
    const passwordChangeFailure = document.getElementById('passwordChangeFailure');
    const error = document.getElementById('error');
    const success = document.getElementById('success');
    const ratingSuccess = document.getElementById('ratingSuccess');

    toastr.options = {
        "closeButton": true,
        "debug": false,
        "newestOnTop": false,
        "progressBar": true,
        "positionClass": "toast-top-right",
        "preventDuplicates": false,
        "onclick": null,
        "showDuration": "300",
        "hideDuration": "1000",
        "timeOut": "3000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    };

    if (updateSuccess) {
        toastr.success('Đã cập nhật thông tin thành công!', 'Thành công');
        updateSuccess.remove();
    }

    if (passwordChangeSuccess) {
        toastr.success('Đã thay đổi mật khẩu thành công!', 'Thành công');
        passwordChangeSuccess.remove();
    }

    if (success) {
        toastr.success(success.textContent, 'Thành công');
        success.remove();
    }

    if (ratingSuccess) {
        toastr.success(ratingSuccess.textContent, 'Thành công');
        ratingSuccess.remove();
    }

    if (passwordChangeFailure) {
        toastr.error('Mật khẩu cũ không đúng!', 'Lỗi');
        passwordChangeFailure.remove();
    }

    if (error) {
        toastr.error(error.textContent, 'Lỗi');
        error.remove();
    }
});

function deleteModal(id) {
    var deleteModal = new bootstrap.Modal(document.getElementById('myModal' + id));
    deleteModal.show();
}

function ratingModal(id) {
    var ratingModal = new bootstrap.Modal(document.getElementById('ratingModal' + id));
    ratingModal.show();
}

function showOrderDetails(orderID) {
    var orderDetailsModal = new bootstrap.Modal(document.getElementById('orderDetailsModal' + orderID));
    orderDetailsModal.show();
}

function validateForm() {
    const reviewText = document.getElementById('review-text').value.trim();
    const rating = document.querySelector('input[name="rating"]:checked');

    if (!reviewText) {
        alert("Vui lòng nhập bình luận của bạn.");
        return false;
    }

    if (!rating) {
        alert("Vui lòng chọn đánh giá của bạn.");
        return false;
    }

    return true;
}