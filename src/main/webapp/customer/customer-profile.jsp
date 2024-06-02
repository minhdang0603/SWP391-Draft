<%--
  Created by IntelliJ IDEA.
  User: MinhDang HE181967
  Date: 6/2/2024
  Time: 1:30 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Profile</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

    <link href="https://fonts.gstatic.com" rel="preconnect">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
          rel="stylesheet">
    <link href="${contextPath}/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="${contextPath}/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="${contextPath}/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="${contextPath}/assets/vendor/quill/quill.snow.css" rel="stylesheet">
    <link href="${contextPath}/assets/vendor/quill/quill.bubble.css" rel="stylesheet">
    <link href="${contextPath}/assets/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="${contextPath}/assets/vendor/simple-datatables/style.css" rel="stylesheet">

    <!-- Template Main CSS File -->
    <link href="${contextPath}/assets/css/style.css" rel="stylesheet">
    <style>
        .dropdown-menu {
            border-radius: 4px;
            padding: 10px 0;
            animation-name: dropdown-animate;
            animation-duration: 0.2s;
            animation-fill-mode: both;
            border: 0;
            box-shadow: 0 5px 30px 0 rgba(82, 63, 105, 0.2);
        }

        .dropdown-menu .dropdown-header,
        .dropdown-menu .dropdown-footer {
            text-align: center;
            font-size: 15px;
            padding: 10px 25px;
        }

        .dropdown-menu .dropdown-footer a {
            color: #444444;
            text-decoration: underline;
        }

        .dropdown-menu .dropdown-footer a:hover {
            text-decoration: none;
        }

        .dropdown-menu .dropdown-divider {
            color: #a5c5fe;
            margin: 0;
        }

        .dropdown-menu .dropdown-item {
            font-size: 14px;
            padding: 10px 15px;
            transition: 0.3s;
        }

        .dropdown-menu .dropdown-item i {
            margin-right: 10px;
            font-size: 18px;
            line-height: 0;
        }

        .dropdown-menu .dropdown-item:hover {
            background-color: #f6f9ff;
        }

        @media (min-width: 768px) {
            .dropdown-menu-arrow::before {
                content: "";
                width: 13px;
                height: 13px;
                background: #fff;
                position: absolute;
                top: -7px;
                right: 20px;
                transform: rotate(45deg);
                border-top: 1px solid #eaedf1;
                border-left: 1px solid #eaedf1;
            }
        }

        @keyframes dropdown-animate {
            0% {
                opacity: 0;
            }

            100% {
                opacity: 1;
            }

            0% {
                opacity: 0;
            }
        }

        #header {
            padding-top: 15px;
            padding-bottom: 15px;
            background-color: #15161D;
        }

        .header-logo {
            float: left;
        }

        .header-logo .logo img {
            display: block;
        }
    </style>

</head>
<body>

<%--Header--%>
<header>
    <!-- MAIN HEADER -->
    <div id="header">
        <!-- container -->
        <div class="container">
            <!-- row -->
            <div class="row">
                <!-- LOGO -->
                <div class="col-md-3">
                    <div class="header-logo">
                        <a href="home" class="logo">
                            <img src="${contextPath}/assets/home/img/logo1.png" alt="">
                        </a>
                    </div>
                </div>
                <!-- /LOGO -->

                <!-- ACCOUNT -->
                <div class="col-md-3 clearfix">
                    <div class="dropdown" style="cursor: pointer">
                        <a class="dropdown-toggle" data-toggle="dropdown">
                            <i class="fa fa-user-circle"></i>
                            ${account.userName}
                        </a>

                        <ul class="dropdown-menu dropdown-menu-end">
                            <li class="dropdown-header">
                                <h5 class="text-center">${account.userName}</h5>
                                <span>${account.email}</span>
                            </li>
                            <li>
                                <hr class="dropdown-divider" style="margin: 2px">
                            </li>
                            <li>
                                <a class="dropdown-item d-flex align-items-center" href="../common/users-profile.jsp">
                                    <i class="fa fa-gear"></i>
                                    <span>User Profile</span>
                                </a>
                            </li>
                            <li>
                                <hr class="dropdown-divider" style="margin: 2px">
                            </li>
                            <li>
                                <a class="dropdown-item d-flex align-items-center" href="logout">
                                    <i class="fa fa-sign-out"></i>
                                    <span class="text-center">Sign Out</span>
                                </a>
                            </li>
                        </ul><!-- End Profile Dropdown Items -->
                    </div>
                    <!-- /Login -->
                </div>
                <!-- /ACCOUNT -->
            </div>
            <!-- row -->
        </div>
        <!-- container -->
    </div>
    <!-- /MAIN HEADER -->
</header>
<%--/Header--%>

<div class="container mt-5">
    <div class="row">
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
                        <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit">Edit Profile
                        </button>
                    </li>

                    <li class="nav-item">
                        <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-change-password">Change
                            Password
                        </button>
                    </li>

                </ul>
                <div class="tab-content pt-2">

                    <div class="tab-pane fade show active profile-overview" id="profile-overview">
                        <h5 class="card-title">About</h5>
                        <p class="small fst-italic">Sunt est soluta temporibus accusantium neque nam maiores cumque
                            temporibus. Tempora libero non est unde veniam est qui dolor. Ut sunt iure rerum quae
                            quisquam autem eveniet perspiciatis odit. Fuga sequi sed ea saepe at unde.</p>

                        <h5 class="card-title">Profile Details</h5>

                        <div class="row">
                            <div class="col-lg-3 col-md-4 label ">Full Name</div>
                            <div class="col-lg-9 col-md-8">Kevin Anderson</div>
                        </div>

                        <div class="row">
                            <div class="col-lg-3 col-md-4 label">Company</div>
                            <div class="col-lg-9 col-md-8">Lueilwitz, Wisoky and Leuschke</div>
                        </div>

                        <div class="row">
                            <div class="col-lg-3 col-md-4 label">Job</div>
                            <div class="col-lg-9 col-md-8">Web Designer</div>
                        </div>

                        <div class="row">
                            <div class="col-lg-3 col-md-4 label">Country</div>
                            <div class="col-lg-9 col-md-8">USA</div>
                        </div>

                        <div class="row">
                            <div class="col-lg-3 col-md-4 label">Address</div>
                            <div class="col-lg-9 col-md-8">A108 Adam Street, New York, NY 535022</div>
                        </div>

                        <div class="row">
                            <div class="col-lg-3 col-md-4 label">Phone</div>
                            <div class="col-lg-9 col-md-8">(436) 486-3538 x29071</div>
                        </div>

                        <div class="row">
                            <div class="col-lg-3 col-md-4 label">Email</div>
                            <div class="col-lg-9 col-md-8">k.anderson@example.com</div>
                        </div>

                    </div>

                    <div class="tab-pane fade profile-edit pt-3" id="profile-edit">

                        <!-- Profile Edit Form -->
                        <form>
                            <div class="row mb-3">
                                <label for="profileImage" class="col-md-4 col-lg-3 col-form-label">Profile Image</label>
                                <div class="col-md-8 col-lg-9">
                                    <img src="assets/img/profile-img.jpg" alt="Profile">
                                    <div class="pt-2">
                                        <a href="#" class="btn btn-primary btn-sm" title="Upload new profile image"><i
                                                class="bi bi-upload"></i></a>
                                        <a href="#" class="btn btn-danger btn-sm" title="Remove my profile image"><i
                                                class="bi bi-trash"></i></a>
                                    </div>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <label for="fullName" class="col-md-4 col-lg-3 col-form-label">Full Name</label>
                                <div class="col-md-8 col-lg-9">
                                    <input name="fullName" type="text" class="form-control" id="fullName"
                                           value="Kevin Anderson">
                                </div>
                            </div>

                            <div class="row mb-3">
                                <label for="about" class="col-md-4 col-lg-3 col-form-label">About</label>
                                <div class="col-md-8 col-lg-9">
                                    <textarea name="about" class="form-control" id="about" style="height: 100px">Sunt est soluta temporibus accusantium neque nam maiores cumque temporibus. Tempora libero non est unde veniam est qui dolor. Ut sunt iure rerum quae quisquam autem eveniet perspiciatis odit. Fuga sequi sed ea saepe at unde.</textarea>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <label for="company" class="col-md-4 col-lg-3 col-form-label">Company</label>
                                <div class="col-md-8 col-lg-9">
                                    <input name="company" type="text" class="form-control" id="company"
                                           value="Lueilwitz, Wisoky and Leuschke">
                                </div>
                            </div>

                            <div class="row mb-3">
                                <label for="Job" class="col-md-4 col-lg-3 col-form-label">Job</label>
                                <div class="col-md-8 col-lg-9">
                                    <input name="job" type="text" class="form-control" id="Job" value="Web Designer">
                                </div>
                            </div>

                            <div class="row mb-3">
                                <label for="Country" class="col-md-4 col-lg-3 col-form-label">Country</label>
                                <div class="col-md-8 col-lg-9">
                                    <input name="country" type="text" class="form-control" id="Country" value="USA">
                                </div>
                            </div>

                            <div class="row mb-3">
                                <label for="Address" class="col-md-4 col-lg-3 col-form-label">Address</label>
                                <div class="col-md-8 col-lg-9">
                                    <input name="address" type="text" class="form-control" id="Address"
                                           value="A108 Adam Street, New York, NY 535022">
                                </div>
                            </div>

                            <div class="row mb-3">
                                <label for="Phone" class="col-md-4 col-lg-3 col-form-label">Phone</label>
                                <div class="col-md-8 col-lg-9">
                                    <input name="phone" type="text" class="form-control" id="Phone"
                                           value="(436) 486-3538 x29071">
                                </div>
                            </div>

                            <div class="row mb-3">
                                <label for="Email" class="col-md-4 col-lg-3 col-form-label">Email</label>
                                <div class="col-md-8 col-lg-9">
                                    <input name="email" type="email" class="form-control" id="Email"
                                           value="k.anderson@example.com">
                                </div>
                            </div>

                            <div class="text-center">
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                            </div>
                        </form><!-- End Profile Edit Form -->

                    </div>

                </div>

                <div class="tab-pane fade pt-3" id="profile-change-password">
                    <!-- Change Password Form -->
                    <form>

                        <div class="row mb-3">
                            <label for="currentPassword" class="col-md-4 col-lg-3 col-form-label">Current
                                Password</label>
                            <div class="col-md-8 col-lg-9">
                                <input name="password" type="password" class="form-control" id="currentPassword">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label for="newPassword" class="col-md-4 col-lg-3 col-form-label">New Password</label>
                            <div class="col-md-8 col-lg-9">
                                <input name="newpassword" type="password" class="form-control" id="newPassword">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label for="renewPassword" class="col-md-4 col-lg-3 col-form-label">Re-enter New
                                Password</label>
                            <div class="col-md-8 col-lg-9">
                                <input name="renewpassword" type="password" class="form-control" id="renewPassword">
                            </div>
                        </div>

                        <div class="text-center">
                            <button type="submit" class="btn btn-primary">Change Password</button>
                        </div>
                    </form><!-- End Change Password Form -->

                </div>

            </div><!-- End Bordered Tabs -->

        </div>
    </div>
</div>

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
</body>
</html>
