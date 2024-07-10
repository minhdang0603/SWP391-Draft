<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Quản lý tài khoản</title>
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

    <!--Toastr-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">

    <!-- Template Main CSS File -->
    <link href="${contextPath}/assets/css/style.css" rel="stylesheet">
    <link href="${contextPath}/assets/css/account-manage.css" rel="stylesheet">


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
                                           class="table table-striped datatable align-items-center mb-0" style="width: 100%;">
                                        <thead>
                                        <tr>
                                            <th class="text-uppercase text-center text-secondary text-xxs font-weight-bolder opacity-7 ps-2">
                                                ID
                                            </th>
                                            <th class="text-uppercase text-center text-secondary text-xxs font-weight-bolder opacity-7">
                                                Tên người dùng
                                            </th>
                                            <th class="text-uppercase text-center text-secondary text-xxs font-weight-bolder opacity-7">
                                                Email
                                            </th>
                                            <th class="text-uppercase text-center text-secondary text-xxs font-weight-bolder opacity-7">
                                                Vai trò
                                            </th>
                                            <th class="text-uppercase text-center text-secondary text-xxs font-weight-bolder opacity-7">
                                                Sửa
                                            </th>
                                            <th class="text-uppercase text-center text-secondary text-xxs font-weight-bolder opacity-7">
                                                Xóa
                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="user" items="${listUser}">
                                            <tr>
                                                <td class="align-middle text-center">${user.id}</td>
                                                <td class="align-middle text-center">${user.userName}</td>
                                                <td class="align-middle text-center">${user.email}</td>
                                                <td class="align-middle text-sm text-center">${user.role.roleName}</td>
                                                <td class="align-middle text-center text-sm mr-2">
                                                    <a href="javascript:void(0);" class="bi bi-pencil-square" style="font-size: 20px; color: deepskyblue"
                                                       onclick="editUser('${user.id}', '${user.userName}', '${user.email}', '${user.address}', '${user.phoneNumber}', '${user.role.roleName}', '${user.status}')"></a>
                                                </td>
                                                <td class="align-middle text-center text-sm mr-2">
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
                                    <form id="userAddForm" action="${contextPath}/admin/account-manage" method="post" onsubmit="return validateForm()">
                                        <input type="hidden" name="formType" value="add"/>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="row mb-3">
                                                    <label for="userName" class="col-md-4 col-form-label">Tên người dùng</label>
                                                    <div class="col-md-8">
                                                        <input name="userName" type="text" class="form-control"
                                                               id="userName" placeholder="Nguyễn Văn A" >
                                                        <div id="userNameError" class="error-message"></div>
                                                    </div>
                                                </div>

                                                <div class="row mb-3">
                                                    <label for="email" class="col-md-4 col-form-label">Email</label>
                                                    <div class="col-md-8">
                                                        <div class="required-note">*Thông tin bắt buộc</div>
                                                        <input name="email" type="email" class="form-control"
                                                               id="email" placeholder="a@gmail.com"required>
                                                        <div id="emailError" class="error-message"></div>
                                                    </div>
                                                </div>

                                                <div class="row mb-3">
                                                    <label for="password" class="col-md-4 col-form-label">Mật khẩu</label>
                                                    <div class="col-md-8">
                                                        <div class="required-note">*Thông tin bắt buộc</div>
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
                                                               id="address" >
                                                        <div id="addressError" class="error-message"></div>
                                                    </div>
                                                </div>

                                                <div class="row mb-3">
                                                    <label for="phoneNumber" class="col-md-4 col-form-label">Số điện thoại</label>
                                                    <div class="col-md-8">
                                                        <input name="phoneNumber" type="text" class="form-control"
                                                               id="phoneNumber" placeholder="123456789" >
                                                        <div id="phoneNumberError" class="error-message"></div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="row mb-3">
                                                    <label for="role" class="col-md-4 col-form-label">Vai trò</label>
                                                    <div class="col-md-8">
                                                        <div class="required-note">*Thông tin bắt buộc</div>
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
                                                        <div class="required-note">*Thông tin bắt buộc</div>
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
                                                    <input type="text" class="form-control" id="editUserName" name="userName" readonly>
                                                </div>

                                                <div class="mb-3">
                                                    <label for="editEmail" class="form-label">Email</label>
                                                    <input type="email" class="form-control" id="editEmail" name="email" readonly>
                                                </div>

                                                <div class="mb-3">
                                                    <label for="editAddress" class="form-label">Địa chỉ</label>
                                                    <input type="text" class="form-control" id="editAddress" name="address" readonly>
                                                </div>

                                                <div class="mb-3">
                                                    <label for="editPhoneNumber" class="form-label">Điện thoại</label>
                                                    <input type="text" class="form-control" id="editPhoneNumber" name="phoneNumber" readonly>
                                                </div>

                                                <div class="mb-3">
                                                    <label for="editRole" class="form-label">Vai trò</label>
                                                    <select class="form-control" id="editRole" name="role" required>
                                                        <option value="ADMIN">Admin</option>
                                                        <option value="SALER">Saler</option>
                                                        <option value="MEMBER">Member</option>
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



<a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i
        class="bi bi-arrow-up-short"></i></a>



<!-- Vendor JS Files -->
<script src="${contextPath}/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/assets/vendor/quill/quill.js"></script>
<script src="${contextPath}/assets/vendor/tinymce/tinymce.min.js"></script>
<script src="${contextPath}/assets/vendor/php-email-form/validate.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.datatables.net/2.0.8/js/dataTables.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.min.js"></script>

<!-- Template Main JS File -->
<script src="${contextPath}/assets/js/main.js"></script>
<script src="${contextPath}/assets/js/account-manage.js"></script>

<!-- Toastr -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<script>
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
    $(document).ready(function () {
        <c:if test="${not empty successMessage}">
        toastr.success('${successMessage}');
        </c:if>
        <c:if test="${not empty errorMessage}">
        toastr.error('${errorMessage}');
        </c:if>
    });
</script>


</body>
</html>