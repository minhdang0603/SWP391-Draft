<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 5/16/2024
  Time: 6:02 PM
  To change this template use File | Settings | File Templates.
--%>
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
    <link href="${contextPath}/assets/vendor/simple-datatables/style.css" rel="stylesheet">

    <!-- Template Main CSS File -->
    <link href="${contextPath}/assets/css/style.css" rel="stylesheet">

    <!--Toastr-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">

    <!-- =======================================================
    * Template Name: NiceAdmin
    * Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
    * Updated: Apr 20 2024 with Bootstrap v5.3.3
    * Author: BootstrapMade.com
    * License: https://bootstrapmade.com/license/
    ======================================================== -->
</head>

<body>

<!-- ======= Header ======= -->
<header id="header" class="header fixed-top d-flex align-items-center">

    <div class="d-flex align-items-center justify-content-between">
        <a href="${contextPath}/home" class="logo d-flex align-items-center">
            <img src="${contextPath}/assets/home/img/logo1.png" alt="">
            <span class="d-none d-lg-block">LaptopTG</span>
        </a>
    </div><!-- End Logo -->

    <nav class="header-nav ms-auto">
        <ul class="d-flex align-items-center">

            <li class="nav-item dropdown pe-3">

                <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
                    <span class="d-none d-md-block dropdown-toggle ps-2">${account.userName}</span>
                </a><!-- End Profile Iamge Icon -->

                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
                    <li class="dropdown-header">
                        <h6>${account.userName}</h6>
                        <span>${account.email}</span>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li>
                        <a class="dropdown-item d-flex align-items-center"
                           href="${contextPath}/common/users-profile.jsp">
                            <span>Account Settings</span>
                        </a>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li>
                        <a class="dropdown-item d-flex align-items-center" href="${contextPath}/logout">
                            <span>Sign Out</span>
                        </a>
                    </li>

                </ul><!-- End Profile Dropdown Items -->
            </li><!-- End Profile Nav -->

        </ul>
    </nav><!-- End Icons Navigation -->

</header><!-- End Header -->

<c:if test="${account.role == 'ADMIN' || account.role == 'SALER'}">
    <jsp:include page="../components/sidebar.jsp"/>
</c:if>

<main id="main" class="main" style="margin-left: 0px">

    <div class="pagetitle text-center">
        <h1>User Profile</h1>
    </div><!-- End Page Title -->

    <section class="section profile">
        <div class="row">

            <div class="col-md-10 offset-1">
                <div class="card">
                    <div class="card-body pt-3">
                        <!-- Bordered Tabs -->
                        <ul class="nav nav-tabs nav-tabs-bordered">

                            <li class="nav-item">
                                <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#profile-overview">
                                    Overview
                                </button>
                            </li>

                            <li class="nav-item">
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit">Edit
                                    Profile
                                </button>
                            </li>

                            <li class="nav-item">
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-change-password">
                                    Change Password
                                </button>
                            </li>

                            <c:if test="${account.role == 'MEMBER'}">
                                <li class="nav-item">
                                    <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-orders">
                                        Orders
                                    </button>
                                </li>
                            </c:if>

                        </ul>
                        <div class="tab-content pt-2">

                            <div class="tab-pane fade show active profile-overview" id="profile-overview">
                                <h5 class="card-title">Profile Details</h5>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label ">User Name</div>
                                    <div class="col-lg-9 col-md-8">${account.userName}</div>
                                    <c:if test="${not empty messName && messName eq 'Full Name cannot contain numbers.'}">
                                        <small id="fullNameHelp" class="form-text text-danger">${messName}</small>
                                    </c:if>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Address</div>
                                    <div class="col-lg-9 col-md-8">${account.address}</div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Phone</div>
                                    <div class="col-lg-9 col-md-8">${account.phoneNumber}</div>
                                </div>
                                <c:if test="${not empty messPhone && messPhone eq 'Phone number must be 9 or 10 digits.'}">
                                    <small id="phoneHelp" class="form-text text-danger">${messPhone}</small>
                                </c:if>
                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Email</div>
                                    <div class="col-lg-9 col-md-8">${account.email}</div>
                                </div>

                            </div>

                            <div class="tab-pane fade profile-edit pt-3" id="profile-edit">

                                <!-- Profile Edit Form -->
                                <form action="${contextPath}/profile" method="post">
                                    <input type="hidden" name="formType" value="form1">
                                    <div class="row mb-3">
                                        <label for="fullName" class="col-md-4 col-lg-3 col-form-label">User Name</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input name="fullName" type="text" class="form-control" id="fullName" value="${account.userName}">
                                            <small id="fullNameHelp" class="form-text text-danger"></small> <!-- Thông báo lỗi -->
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <label for="Address" class="col-md-4 col-lg-3 col-form-label">Address</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input name="address" type="text" class="form-control" id="Address" value="${account.address}">
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <label for="Phone" class="col-md-4 col-lg-3 col-form-label">Phone</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input name="phone" type="text" class="form-control" id="Phone" value="${account.phoneNumber}">
                                            <small id="phoneHelp" class="form-text text-danger"></small> <!-- Thông báo lỗi -->
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <label for="Email" class="col-md-4 col-lg-3 col-form-label">Email</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input name="email" type="email" class="form-control" id="Email" value="${account.email}" readonly>
                                        </div>
                                    </div>

                                    <div class="text-center">
                                        <button type="submit" class="btn btn-primary" id="saveChangesBtn" disabled>Save Changes</button>
                                    </div>
                                </form><!-- End Profile Edit Form -->

                            </div>
                            <!-- Change Password Form -->
                            <div class="tab-pane fade profile-change-password pt-3" id="profile-change-password">
                                <form id="changePasswordForm" action="${contextPath}/profile" method="post">
                                    <input type="hidden" name="formType" value="form2">

                                    <div class="row mb-3">
                                        <label for="currentPassword" class="col-md-4 col-lg-3 col-form-label">Current Password</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input name="currentPassword" type="password" class="form-control" id="currentPassword">
                                            <small id="currentPasswordHelp" class="form-text text-danger" style="display: none;">Không được để trống !!!</small>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <label for="newPassword" class="col-md-4 col-lg-3 col-form-label">New Password</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input name="newpassword" type="password" class="form-control" id="newPassword">
                                            <small id="newPasswordHelp" class="form-text text-danger" style="display: none;">Mật khẩu mới không được giống mật khẩu cũ.</small>
                                            <small id="newPasswordValidation" class="form-text text-danger" style="display: none;">Mật khẩu phải có 8 ký tự trở lên, ít nhất 1 số và 1 chữ hoa.</small>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <label for="renewPassword" class="col-md-4 col-lg-3 col-form-label">Re-enter New Password</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input name="renewpassword" type="password" class="form-control" id="renewPassword">
                                            <small id="renewPasswordHelp" class="form-text text-danger" style="display: none;">Nhập lại, không đúng với new password!!!.</small>
                                        </div>
                                    </div>

                                    <div class="text-center">
                                        <button type="submit" class="btn btn-primary" id="changePassbtn" disabled>Change Password</button>
                                    </div>
                                </form>
                            </div>


                            <!-- End change password Form -->


                            <div class="tab-pane fade pt-3 recent-sales overflow-auto" id="profile-orders">
                                <!-- Orders Table -->
                                <div class="filter">
                                    <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                                    <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                        <li class="dropdown-header text-start">
                                            <h6>Filter</h6>
                                        </li>

                                        <li><a class="dropdown-item" href="#">Today</a></li>
                                        <li><a class="dropdown-item" href="#">This Month</a></li>
                                        <li><a class="dropdown-item" href="#">This Year</a></li>
                                    </ul>
                                </div>

                                <div class="">
                                    <h5 class="">Recent Sales <span>| Today</span></h5>

                                    <table class="table table-borderless datatable">
                                        <thead>
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">Customer</th>
                                            <th scope="col">Product</th>
                                            <th scope="col">Price</th>
                                            <th scope="col">Status</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <th scope="row"><a href="#">#2457</a></th>
                                            <td>Brandon Jacob</td>
                                            <td><a href="#" class="text-primary">At praesentium minu</a></td>
                                            <td>$64</td>
                                            <td><span class="badge bg-success">Approved</span></td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><a href="#">#2147</a></th>
                                            <td>Bridie Kessler</td>
                                            <td><a href="#" class="text-primary">Blanditiis dolor omnis similique</a></td>
                                            <td>$47</td>
                                            <td><span class="badge bg-warning">Pending</span></td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><a href="#">#2049</a></th>
                                            <td>Ashleigh Langosh</td>
                                            <td><a href="#" class="text-primary">At recusandae consectetur</a></td>
                                            <td>$147</td>
                                            <td><span class="badge bg-success">Approved</span></td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><a href="#">#2644</a></th>
                                            <td>Angus Grady</td>
                                            <td><a href="#" class="text-primar">Ut voluptatem id earum et</a></td>
                                            <td>$67</td>
                                            <td><span class="badge bg-danger">Rejected</span></td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><a href="#">#2644</a></th>
                                            <td>Raheem Lehner</td>
                                            <td><a href="#" class="text-primary">Sunt similique distinctio</a></td>
                                            <td>$165</td>
                                            <td><span class="badge bg-success">Approved</span></td>
                                        </tr>
                                        </tbody>
                                    </table>
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
<script src="${contextPath}/assets/vendor/apexcharts/apexcharts.min.js"></script>
<script src="${contextPath}/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/assets/vendor/chart.js/chart.umd.js"></script>
<script src="${contextPath}/assets/vendor/echarts/echarts.min.js"></script>
<script src="${contextPath}/assets/vendor/quill/quill.js"></script>
<script src="${contextPath}/assets/vendor/simple-datatables/simple-datatables.js"></script>
<script src="${contextPath}/assets/vendor/tinymce/tinymce.min.js"></script>
<script src="${contextPath}/assets/vendor/php-email-form/validate.js"></script>

<!-- Template Main JS File -->
<script src="${contextPath}/assets/js/main.js"></script>

<script src="${contextPath}/assets/js/validation-profile.js"></script>
<script src="${contextPath}/assets/js/validation-change-pass.js"></script>

<!-- Toastr -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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

    <% if (request.getAttribute("updateSuccess") != null && (Boolean) request.getAttribute("updateSuccess")) { %>
    toastr.success('Đã cập nhật thông tin thành công!', 'Thành công');
    <% } %>

    <% if (request.getAttribute("passwordChangeSuccess") != null && (Boolean) request.getAttribute("passwordChangeSuccess")) { %>
    toastr.success('Đã thay đổi mật khẩu thành công!', 'Thành công');
    <% } %>


    <% if (request.getAttribute("passwordChangeFailure") != null && (Boolean) request.getAttribute("passwordChangeFailure")) { %>
    toastr.error('Mật khẩu cũ không đúng!', 'Lỗi', {
        "timeOut": "3000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut",
        "progressBar": true,
        "positionClass": "toast-top-right",
        "closeButton": true,
        "newestOnTop": false,
        "preventDuplicates": false,
        "onclick": null,
        "showDuration": "300",
        "hideDuration": "1000",
        "show": {
            "duration": "300",
            "easing": "swing"
        },
        "hide": {
            "duration": "1000",
            "easing": "linear"
        },
        "style": {
            "color": "red"
        }
    });
    <% } %>
</script>


</body>

</html>
