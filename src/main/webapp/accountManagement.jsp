<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 6/4/2024
  Time: 10:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="apple-touch-icon" sizes="76x76" href="assets/admin/img/apple-icon.png">
    <link rel="icon" type="image/png" href="assets/admin/img/favicon.png">
    <title>
        Account Management
    </title>
    <!--     Fonts and icons     -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
    <!-- Nucleo Icons -->
    <link href="assets/admin/css/nucleo-icons.css" rel="stylesheet" />
    <link href="assets/admin/css/nucleo-svg.css" rel="stylesheet" />
    <!-- Font Awesome Icons -->
    <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
    <link href="assets/admin/css/nucleo-svg.css" rel="stylesheet" />
    <!-- CSS Files -->
    <link id="pagestyle" href="assets/admin/css/argon-dashboard.css?v=2.0.4" rel="stylesheet" />

    <!-- Toastr CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet"/>
</head>

<body class="g-sidenav-show   bg-gray-100">
<div class="min-height-300 bg-primary position-absolute w-100"></div>
<aside
        class="sidenav bg-white navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 fixed-start ms-4 "
        id="sidenav-main">
    <div class="sidenav-header">
        <i class="fas fa-times p-3 cursor-pointer text-secondary opacity-5 position-absolute end-0 top-0 d-none d-xl-none"
           aria-hidden="true" id="iconSidenav"></i>
        <a class="navbar-brand m-0" href=" ../pages/dashboard.html " target="_blank">
            <img src="assets/admin/img/logo-ct-dark.png" class="navbar-brand-img h-100" alt="main_logo">
            <span class="ms-1 font-weight-bold">Admin</span>
        </a>
    </div>
    <hr class="horizontal dark mt-0">
    <div class="collapse navbar-collapse  w-auto " id="sidenav-collapse-main">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link " href="../pages/dashboard.html">
                    <div
                            class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="ni ni-tv-2 text-primary text-sm opacity-10"></i>
                    </div>
                    <span class="nav-link-text ms-1">Dashboard</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link " href="../pages/salemanagement.html">
                    <div
                            class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="ni ni-money-coins text-warning text-sm opacity-10"></i>
                    </div>
                    <span class="nav-link-text ms-1">Sales</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link " href="../pages/accountmanagement.html">
                    <div
                            class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="ni ni-world-2 text-warning text-sm opacity-10"></i>
                    </div>
                    <span class="nav-link-text ms-1">Account Management</span>
                </a>

            </li>
            <li class="nav-item">
                <a class="nav-link " href="../pages/productmanagement.html">
                    <div
                            class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="ni ni-cart text-warning text-sm opacity-10"></i>
                    </div>
                    <span class="nav-link-text ms-1">Product Management</span>
                </a>
            </li>
        </ul>
    </div>
</aside>
<main class="main-content position-relative border-radius-lg ">
    <!-- Navbar -->
    <nav class="navbar navbar-main navbar-expand-lg px-0 mx-4 shadow-none border-radius-xl " id="navbarBlur"
         data-scroll="false">
        <div class="container-fluid py-1 px-3">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb bg-transparent mb-0 pb-0 pt-1 px-0 me-sm-6 me-5">
                    <li class="breadcrumb-item text-sm"><a class="opacity-5 text-white" href="javascript:;">Pages</a></li>
                    <li class="breadcrumb-item text-sm text-white active" aria-current="page">Account Management</li>
                </ol>
                <h6 class="font-weight-bolder text-white mb-0">Account Management</h6>
            </nav>
            <div class="collapse navbar-collapse mt-sm-0 mt-2 me-md-0 me-sm-4" id="navbar">
                <div class="ms-md-auto pe-md-3 d-flex align-items-center">
                    <div class="input-group">
                        <span class="input-group-text text-body"><i class="fas fa-search" aria-hidden="true"></i></span>
                        <form action="search-account" method="post">  <input type="text" name="searchAcc" class="form-control" placeholder="Type here...">
                            <input type="submit" value="search">
                        </form>

                    </div>
                </div>
                <ul class="navbar-nav  justify-content-end">
                    <li class="nav-item d-flex align-items-center">
                        <a href="javascript:;" class="nav-link text-white font-weight-bold px-0">
                            <i class="fa fa-user me-sm-1"></i>
                            <span class="d-sm-inline d-none">Sign In</span>
                        </a>
                    </li>
                    <li class="nav-item d-xl-none ps-3 d-flex align-items-center">
                        <a href="javascript:;" class="nav-link text-white p-0" id="iconNavbarSidenav">
                            <div class="sidenav-toggler-inner">
                                <i class="sidenav-toggler-line bg-white"></i>
                                <i class="sidenav-toggler-line bg-white"></i>
                                <i class="sidenav-toggler-line bg-white"></i>
                            </div>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <!-- End Navbar -->
    <div class="container-fluid py-4">
        <div class="row">
            <div class="col-12">
                <div class="card mb-4">
                    <div class="card-body px-0 pt-0 pb-2">
                        <div class=table-responsive pb-0">
                        <table class="table align-items-center mb-0">
                            <thead>
                            <tr>
                                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">ID</th>
                                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">User Name</th>
                                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Email</th>
                                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Address</th>
                                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Phone Number</th>
                                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Role</th>
                                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Status</th>
                                <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="user" items="${listUser}">
                                <tr>
                                    <td>
                                        <p class="text-xs font-weight-bold mb-0">${user.id}</p>
                                    </td>
                                    <td>
                                        <p class="text-xs font-weight-bold mb-0">${user.userName}</p>
                                    </td>
                                    <td>
                                        <p class="text-xs font-weight-bold mb-0">${user.email}</p>
                                    </td>
                                    <td>
                                        <p class="text-xs font-weight-bold mb-0">${user.address}</p>
                                    </td>
                                    <td>
                                        <p class="text-xs font-weight-bold mb-0">${user.phoneNumber}</p>
                                    </td>
                                    <td>
                                        <p class="text-xs font-weight-bold mb-0">${user.role.roleName}</p>
                                    </td>
                                    <td>
                                        <p class="text-xs font-weight-bold mb-0">${user.status}</p>
                                    </td>
                                    <td class="align-middle text-center text-sm">
                                        <a href="account-manage?update=${user.id}" class="badge badge-sm bg-gradient-success view-user" data-id="${user.id}" data-bs-toggle="modal" data-bs-target="#userModal">View</a>
                                        <a href="#" class="badge badge-sm bg-gradient-danger delete-user" >Delete</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>


    <!-- ---------------------------------------------------------------- -->
    <!-- Modal -->
    <div class="modal fade" id="userModal" tabindex="-1" role="dialog" aria-labelledby="userModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="userModalLabel">User Information</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="userForm" action="account-manage" method="post">
                        <input type="hidden" id="userId" name="userId">
                        <div class="mb-3">
                            <label for="username" class="form-label">Username</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label for="phone" class="form-label">Phone Number</label>
                            <input type="tel" class="form-control" id="phone" name="phone" required>
                        </div>
                        <div class="mb-3">
                            <label for="address" class="form-label">Address</label>
                            <input type="text" class="form-control" id="address" name="address" required>
                        </div>
                        <div class="mb-3">
                            <label for="role" class="form-label">Role</label>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="role" id="employee" value="employee" required>
                                <label class="form-check-label" for="employee">Employee</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="role" id="customer" value="customer" required>
                                <label class="form-check-label" for="customer">MEMBER</label>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="status" class="form-label">Status</label>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="status" id="active" value="active" required>
                                <label class="form-check-label" for="active">Active</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="status" id="inactive" value="inactive" required>
                                <label class="form-check-label" for="inactive">Inactive</label>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary" id="saveChanges">Save changes</button>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</main>
<!--   Core JS Files   -->
<script src="assets/admin/js/core/popper.min.js"></script>
<script src="assets/admin/js/core/bootstrap.min.js"></script>
<script src="assets/admin/js/plugins/perfect-scrollbar.min.js"></script>
<script src="assets/admin/js/plugins/smooth-scrollbar.min.js"></script>
<!-- Github buttons -->
<script async defer src="https://buttons.github.io/buttons.js"></script>
<!-- Control Center for Soft Dashboard: parallax effects, scripts for the example pages etc -->
<script src="assets/admin/js/argon-dashboard.min.js?v=2.0.4"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const deleteButtons = document.querySelectorAll('.delete-user');

        deleteButtons.forEach(button => {
            button.addEventListener('click', function(event) {
                event.preventDefault();
                const userId = this.getAttribute('data-id');

                if (confirm('Bạn có chắc chắn muốn xóa người dùng này không?')) {
                    fetch(`account-manage?idDelete=${userId}`, {
                        method: 'GET'
                    })
                        .then(response => {
                            if (response.ok) {
                                toastr.success('Đã xóa thành công!', 'Thông báo', { timeOut: 3000 });
                                setTimeout(() => {
                                    location.reload();
                                }, 3000);
                            } else {
                                toastr.error('Xóa thất bại!', 'Lỗi', { timeOut: 3000 });
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            toastr.error('Xóa thất bại!', 'Lỗi', { timeOut: 3000 });
                        });
                }
            });
        });
    });
</script>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.view-user').forEach(function(element) {
            element.addEventListener('click', function(event) {
                event.preventDefault();
                var userId = this.getAttribute('data-id');

                // Gửi yêu cầu AJAX để lấy thông tin người dùng
                fetch(`/getUserInfo?aid=${userId}`)
                    .then(response => response.json())
                    .then(data => {
                        // Cập nhật nội dung modal với thông tin người dùng
                        document.getElementById('userId').value = data.id;
                        document.getElementById('username').value = data.username;
                        document.getElementById('phone').value = data.phone;
                        document.getElementById('address').value = data.address;
                        // Nếu bạn muốn hiển thị role và status, thêm mã tương ứng ở đây
                    })
                    .catch(error => console.error('Error:', error));
            });
        });
    });

    // Function to populate modal with user information
    function populateModal(data) {
        $('#userId').val(data.id);
        $('#username').val(data.userName);
        $('#phone').val(data.phoneNumber);
        $('#address').val(data.address);
        // Nếu bạn muốn hiển thị email, hãy thêm dòng sau:
        $('#email').val(data.email);
        // Nếu bạn muốn hiển thị role và status, hãy thêm mã tương ứng ở đây
    }

    // Fetch user information and populate the modal
    $('.badge.bg-gradient-success').on('click', function () {
        var userId = $(this).data('id');
        // Make an AJAX request to fetch user information
        $.ajax({
            url: 'account-manage?id=' + userId,
            method: 'GET',
            success: function (data) {
                // Populate the modal with user information
                populateModal(data);
            },
            error: function () {
                // Handle error case
                $('.modal-body').html('<p>Failed to load user information.</p>');
            }
        });
    });

    // Save changes when the "Save changes" button is clicked
    $('#saveChanges').on('click', function () {
        var formData = $('#userForm').serialize();
        // Make an AJAX request to save changes
        $.ajax({
            url: 'account-manage',
            method: 'POST',
            data: formData,
            success: function (response) {
                // Handle success response
                // Close the modal or perform any other actions
                $('#userModal').modal('hide');
                // Reload page or update user list if needed
                // window.location.reload(); // Reload page
                // updateUserList(); // Update user list
            },
            error: function () {
                // Handle error case
                alert('Failed to save changes.');
            }
        });
    });
    document.addEventListener('DOMContentLoaded', function() {
        var userId; // Biến để lưu user.id

        // Xử lí khi nhấp vào nút "View"
        document.querySelectorAll('.view-user').forEach(function(element) {
            element.addEventListener('click', function(event) {
                event.preventDefault();
                userId = this.getAttribute('data-id'); // Lưu user.id
                // Hiển thị modal ở đây nếu cần
            });
        });

        // Xử lí khi ấn nút "Save changes"
        document.getElementById('saveChanges').addEventListener('click', function(event) {
            event.preventDefault();
            // Kiểm tra xem userId đã được lưu hay chưa
            if (userId) {
                // Lấy thông tin từ form modal ở đây (username, phone, address, role, status)
                var formData = {
                    userId: userId,
                    // Thêm các trường thông tin khác từ modal vào đây
                };

                // Gửi yêu cầu AJAX để lưu thông tin người dùng
                fetch('/yourServletURL', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(formData)
                })
                    .then(response => {
                        // Xử lí phản hồi từ máy chủ ở đây
                    })
                    .catch(error => console.error('Lỗi:', error));
            } else {
                console.error('userId chưa được xác định');
            }
        });
    });
</script>
</body>

</html>