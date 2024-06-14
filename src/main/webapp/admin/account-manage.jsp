<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>User Profile</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

    <!-- Favicons -->
    <link href="${contextPath}/assets/home/img/logo1.png" rel="icon">
    <link href="${contextPath}/assets/css/font-awesome.min.css" rel="stylesheet">

    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
          rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="${contextPath}/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="${contextPath}/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="${contextPath}/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="${contextPath}/assets/vendor/quill/quill.snow.css" rel="stylesheet">
    <link href="${contextPath}/assets/vendor/quill/quill.bubble.css" rel="stylesheet">
    <link href="${contextPath}/assets/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.datatables.net/2.0.8/css/dataTables.dataTables.css">

    <!-- Template Main CSS File -->
    <link href="${contextPath}/assets/css/style.css" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Your custom CSS -->
    <link href="${contextPath}/assets/css/style.css" rel="stylesheet">

    <style>
        .form-control-lg {
            font-size: 1.25rem;
            padding: .5rem 1rem;
        }

        .large-textarea {
            min-height: 200px;
            font-size: 1.25rem;
            padding: .75rem;
        }

        #myTable th, td {
            text-align: left;
            align-content: center;
        }

        th, td {
            padding: 12px 15px;
        }

        th {
            background-color: #f8f9fa;
        }

        .error-message {
            color: red;
            font-size: 0.875em;
        }
    </style>
</head>

<body>

<!-- ======= Header ======= -->
<jsp:include page="../components/navbar-admin.jsp"/>
<!-- End Header -->
<c:if test="${account.role == 'ADMIN' || account.role == 'SALER'}">
    <jsp:include page="../components/sidebar.jsp"/>
</c:if>

<main id="main" class="main">

    <div class="pagetitle text-center">
        <h1>Quản Lý Tài Khoản</h1>
    </div><!-- End Page Title -->

    <section class="section profile">
        <div class="row">

            <div class="col-md-10 offset-1">
                <div class="card">
                    <div class="card-body pt-3">
                        <!-- Bordered Tabs -->
                        <ul class="nav nav-tabs nav-tabs-bordered">

                            <li class="nav-item">
                                <button class="nav-link active" data-bs-toggle="tab"
                                        data-bs-target="#profile-overview">
                                    Danh Sách Tài Khoản
                                </button>
                            </li>

                            <li class="nav-item">
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit">Tạo Mới
                                </button>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane fade show active profile-overview" id="profile-overview">
                                <!-- Account Table -->
                                <div class="table-responsive">
                                    <table id="myTable"
                                           class="table table-striped datatable align-items-center mb-0">
                                        <thead>
                                        <tr>
                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">
                                                ID
                                            </th>
                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                                UserName
                                            </th>
                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                                Email
                                            </th>
                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                                Địa chỉ
                                            </th>
                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                                Điện thoại
                                            </th>
                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                                Vai trò
                                            </th>
                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                                Trạng thái
                                            </th>
                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                                Sửa
                                            </th>
                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                                Xóa
                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="user" items="${listUser}">
                                            <tr>
                                                <td>${user.id}</td>
                                                <td>${user.userName}</td>
                                                <td>${user.email}</td>
                                                <td>${user.address}</td>
                                                <td>${user.phoneNumber}</td>
                                                <td>${user.role.roleName}</td>
                                                <td>${user.status}</td>
                                                <td>
                                                    <a href="javascript:void(0);" class="bi bi-pencil-square" style="font-size: 20px; color: deepskyblue" onclick="editUser('${user.id}', '${user.userName}', '${user.email}', '${user.address}', '${user.phoneNumber}', '${user.role.roleName}', '${user.status}')"></a>
                                                </td>
                                                <td>
                                                    <a href="${contextPath}/admin/account-manage?idDelete=${user.id}"
                                                       onclick="return confirmDelete();"
                                                       class="bi bi-trash2-fill"
                                                       style="font-size: 20px; color: red; text-decoration: none;">
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <div class="tab-pane fade profile-edit pt-3" id="profile-edit">
                                <!-- Create New User Form -->
                                <div class="container">
                                    <form id="userAddForm" action="${contextPath}/admin/account-manage" method="post"
                                          oninput="validateForm()">
                                        <input type="hidden" name="formType" value="add"/>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="row mb-3">
                                                    <label for="userName" class="col-md-4 col-form-label">Tên người dùng</label>
                                                    <div class="col-md-8">
                                                        <input name="userName" type="text" class="form-control"
                                                               id="userName" required>
                                                        <div id="userNameError" class="error-message"></div>
                                                    </div>
                                                </div>

                                                <div class="row mb-3">
                                                    <label for="email" class="col-md-4 col-form-label">Email</label>
                                                    <div class="col-md-8">
                                                        <input name="email" type="email" class="form-control"
                                                               id="email" required>
                                                        <div id="emailError" class="error-message"></div>
                                                    </div>
                                                </div>

                                                <div class="row mb-3">
                                                    <label for="password" class="col-md-4 col-form-label">Mật khẩu</label>
                                                    <div class="col-md-8">
                                                        <input name="password" type="password" class="form-control"
                                                               id="password" required>
                                                        <div id="passwordError" class="error-message"></div>
                                                        <small id="passwordValidation" class="form-text text-danger" style="display: none;">Mật khẩu phải có 8 ký tự trở lên, ít nhất 1 số và 1 chữ hoa.</small>
                                                    </div>
                                                </div>

                                                <div class="row mb-3">
                                                    <label for="repassword" class="col-md-4 col-form-label">Nhập lại </label>
                                                    <div class="col-md-8">
                                                        <input name="repassword" type="password" class="form-control"
                                                               id="repassword" required>
                                                        <div id="repasswordError" class="error-message"></div>
                                                        <small id="passwordHelp" class="form-text text-danger" style="display: none;">Nhập lại, không đúng với new password!!!.</small>
                                                    </div>
                                                </div>

                                                <div class="row mb-3">
                                                    <label for="address" class="col-md-4 col-form-label">Địa chỉ</label>
                                                    <div class="col-md-8">
                                                        <input name="address" type="text" class="form-control"
                                                               id="address" required>
                                                        <div id="addressError" class="error-message"></div>
                                                    </div>
                                                </div>

                                                <div class="row mb-3">
                                                    <label for="phoneNumber" class="col-md-4 col-form-label">Số điện thoại</label>
                                                    <div class="col-md-8">
                                                        <input name="phoneNumber" type="text" class="form-control"
                                                               id="phoneNumber" required>
                                                        <div id="phoneNumberError" class="error-message"></div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="row mb-3">
                                                    <label for="role" class="col-md-4 col-form-label">Vai trò</label>
                                                    <div class="col-md-8">
                                                        <select name="role" class="form-control" id="role" required>
                                                            <option value="">Chọn vai trò</option>
                                                            <option value="1">Admin</option>
                                                            <option value="2">Nhân viên</option>
                                                            <option value="3">Khách hàng</option>
                                                        </select>
                                                        <div id="roleError" class="error-message"></div>
                                                    </div>
                                                </div>



                                                <div class="row mb-3">
                                                    <label for="status" class="col-md-4 col-form-label">Trạng thái</label>
                                                    <div class="col-md-8">
                                                        <select name="status" class="form-control" id="status" required>
                                                            <option value="">Chọn trạng thái</option>
                                                            <option value="active">ACTIVE</option>
                                                            <option value="inactive">INACTIVE</option>
                                                        </select>
                                                        <div id="statusError" class="error-message"></div>
                                                    </div>
                                                </div>

                                                <div class="row mb-3">
                                                    <div class="col-md-12 text-center">
                                                        <button type="submit" class="btn btn-primary" id="changePassbtn">Tạo tài khoản</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <!--End add user form -->
                            </div>
                            <!-- Edit User Modal -->
                            <div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="editUserModalLabel">Edit User</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <form id="userEditForm" action="${contextPath}/admin/account-manage" method="post">
                                                <input type="hidden" name="formType" value="edit"/>
                                                <input type="hidden" name="userId" id="editUserId"/>

                                                <div class="mb-3">
                                                    <label for="editUserName" class="form-label">Tên người dùng</label>
                                                    <input type="text" class="form-control" id="editUserName" name="userName" required>
                                                </div>

                                                <div class="mb-3">
                                                    <label for="editEmail" class="form-label">Email</label>
                                                    <input type="email" class="form-control" id="editEmail" name="email" readonly>
                                                </div>

                                                <div class="mb-3">
                                                    <label for="editAddress" class="form-label">Địa chỉ</label>
                                                    <input type="text" class="form-control" id="editAddress" name="address" required>
                                                </div>

                                                <div class="mb-3">
                                                    <label for="editPhoneNumber" class="form-label">Điện thoại</label>
                                                    <input type="text" class="form-control" id="editPhoneNumber" name="phoneNumber" required>
                                                </div>

                                                <div class="mb-3">
                                                    <label for="editRole" class="form-label">Vai trò</label>
                                                    <select class="form-control" id="editRole" name="role" required>
                                                        <option value="1">Admin</option>
                                                        <option value="2">Saler</option>
                                                        <option value="3">MEMBER</option>
                                                        <!-- Thêm các lựa chọn vai trò khác nếu cần -->
                                                    </select>
                                                </div>

                                                <div class="mb-3">
                                                    <label for="editStatus" class="form-label">Trạng thái</label>
                                                    <select class="form-control" id="editStatus" name="status" required>
                                                        <option value="active">Active</option>
                                                        <option value="inactive">Inactive</option>
                                                    </select>
                                                </div>

                                                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div><!-- End Bordered Tabs -->
                </div>
            </div>
        </div>
    </section>
</main><!-- End #main -->

<!-- ======= Footer ======= -->
<%--<jsp:include page="../components/footer.jsp"/>--%>
<!-- End Footer -->

<a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i
        class="bi bi-arrow-up-short"></i></a>

<!-- Vendor JS Files -->
<script src="${contextPath}/assets/vendor/apexcharts/apexcharts.min.js"></script>
<script src="${contextPath}/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/assets/vendor/chart.js/chart.umd.js"></script>
<script src="${contextPath}/assets/vendor/echarts/echarts.min.js"></script>
<script src="${contextPath}/assets/vendor/quill/quill.min.js"></script>
<script src="${contextPath}/assets/vendor/simple-datatables/simple-datatables.js"></script>
<script src="${contextPath}/assets/vendor/tinymce/tinymce.min.js"></script>
<script src="${contextPath}/assets/vendor/php-email-form/validate.js"></script>
<script src="${contextPath}/assets/js/validation-password-add-user.js"></script>
<script src="https://cdn.datatables.net/2.0.8/js/jquery.dataTables.js"></script>
<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

<script>
    function editUser(id, userName, email, address, phoneNumber, roleName, status) {
        // Set the values in the modal form
        document.getElementById('editUserId').value = id;
        document.getElementById('editUserName').value = userName;
        document.getElementById('editEmail').value = email;
        document.getElementById('editAddress').value = address;
        document.getElementById('editPhoneNumber').value = phoneNumber;
        document.getElementById('editRole').value = roleName;
        document.getElementById('editStatus').value = status;

        // Show the modal
        var myModal = new bootstrap.Modal(document.getElementById('editUserModal'));
        myModal.show();
    }

    $(document).ready(function () {
        $('#myTable').DataTable();
    });
</script>
<script>
    // DataTable initialization
    $(document).ready(function () {
        $('#myTable').DataTable();
    });

    function validateForm() {
        // Clear previous error messages
        $('.error-message').text('');

        let isValid = true;

        const userName = document.getElementById('userName').value;
        const email = document.getElementById('email').value;
        const address = document.getElementById('address').value;
        const phoneNumber = document.getElementById('phoneNumber').value;
        const role = document.getElementById('role').value;
        const password = document.getElementById('password').value;
        const status = document.getElementById('status').value;

        // Validation logic
        if (!userName.trim()) {
            document.getElementById('userNameError').textContent = 'Tên người dùng là bắt buộc';
            isValid = false;
        }
        if (!email.trim()) {
            document.getElementById('emailError').textContent = 'Email là bắt buộc';
            isValid = false;
        } else if (!validateEmail(email)) {
            document.getElementById('emailError').textContent = 'Email không hợp lệ';
            isValid = false;
        }
        // if (!address.trim()) {
        //     document.getElementById('addressError').textContent = 'Địa chỉ là bắt buộc';
        //     isValid = false;
        // }
        if (!phoneNumber.trim()) {
            document.getElementById('phoneNumberError').textContent = 'Số điện thoại là bắt buộc';
            isValid = false;
        } else if (!validatePhoneNumber(phoneNumber)) {
            document.getElementById('phoneNumberError').textContent = 'Số điện thoại không hợp lệ';
            isValid = false;
        }
        // if (!role) {
        //     document.getElementById('roleError').textContent = 'Vai trò là bắt buộc';
        //     isValid = false;
        // }
        // if (!password.trim()) {
        //     document.getElementById('passwordError').textContent = 'Mật khẩu là bắt buộc';
        //     isValid = false;
        // }
        // if (!status) {
        //     document.getElementById('statusError').textContent = 'Trạng thái là bắt buộc';
        //     isValid = false;
        // }

        return isValid;
    }

    function validateEmail(email) {
        // Simple email validation regex
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(email);
    }

    function validatePhoneNumber(phoneNumber) {
        // Simple phone number validation regex (Vietnam phone number format)
        const re = /(03|05|07|08|09|01[2|6|8|9])+([0-9]{8})\b/;
        return re.test(phoneNumber);
    }
</script>

<!--Alert xóa tài khoản-->
<script>
    function confirmDelete() {
        if (confirm('Bạn có chắc chắn muốn xóa tài khoản này?')) {
            return true; // Cho phép thực hiện hành động xóa
        } else {
            return false; // Ngăn không cho thực hiện hành động xóa
        }
    }
</script>

</body>

</html>