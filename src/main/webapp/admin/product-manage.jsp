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
    <link href="${contextPath}/assets/vendor/simple-datatables/style.css" rel="stylesheet">

    <!-- Template Main CSS File -->
    <link href="${contextPath}/assets/css/style.css" rel="stylesheet">

    <style>


        #myTable th, td {
            text-align: center;
            align-content: center;
        }

        .error-message {
            color: red;
            font-size: 0.875em;
        }
    </style>
</head>

<body>

<!-- ======= Header ======= -->
<header id="header" class="header fixed-top d-flex align-items-center">

    <div class="d-flex align-items-center justify-content-between">
        <a href="${contextPath}/home" class="logo d-flex align-items-center">
            <img src="${contextPath}/assets/home/img/logo1.png" alt="">
            <span class="d-none d-lg-block">LaptopTG</span>
        </a>
        <c:if test="${account.role == 'ADMIN' || account.role == 'SALER'}">
            <i class="bi bi-list toggle-sidebar-btn"></i>
        </c:if>

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
<c:choose>
<c:when test="${account.role == 'ADMIN' || account.role == 'SALER'}">
<main id="main" class="main">
    </c:when>
    <c:otherwise>
    <main id="main" class="main" style="margin-left: 0px">
        </c:otherwise>
        </c:choose>


        <div class="pagetitle text-center">
            <h1>Quản Lý Sản Phẩm</h1>
        </div><!-- End Page Title -->

        <section class="section profile">
            <div class="row">

                <div class="col-md-10 offset-1">
                    <div class="card">
                        <div class="card-body pt-3">
                            <!-- Bordered Tabs -->
                            <ul class="nav nav-tabs nav-tabs-bordered">
                                <%--                                <c:if test="${account.role == 'ADMIN' || account.role == 'SALER'}">--%>
                                <li class="nav-item">
                                    <button class="nav-link active" data-bs-toggle="tab"
                                            data-bs-target="#profile-overview">
                                        Danh Sách Sản Phẩm
                                    </button>
                                </li>
                                <%--                                </c:if>--%>

                                <li class="nav-item">
                                    <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit">Tạo Mới
                                    </button>
                                </li>

                            </ul>
                            <div class="tab-content pt-2">
                                <div class="tab-pane fade show active profile-overview" id="profile-overview">
                                    <!-- Products Table -->
                                    <div class="" id="myTable">
                                        <table class="table table-borderless datatable">
                                            <thead>
                                            <tr>
                                                <th scope="col">ID</th>
                                                <th scope="col">Minh Họa</th>
                                                <th scope="col">Sản Phẩm</th>
                                                <th scope="col">Danh Mục</th>
                                                <th scope="col">Hãng</th>
                                                <th scope="col">Tồn Kho</th>
                                                <th scope="col">Sửa</th>
                                                <th scope="col">Xóa</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="pro" items="${list}">
                                                <tr>
                                                    <td>${pro.id}</td>
                                                    <td><img style="width: 100px; height: 100px"
                                                             src="${contextPath}/assets/img/product-img/${pro.image}">
                                                    </td>
                                                    <td>${pro.productName}</td>
                                                    <td>${pro.category.categoryName}</td>
                                                    <td>${pro.brand.brandName}</td>
                                                    <td>${pro.stockUnit}</td>
                                                    <td><i class="bi bi-pencil-square"
                                                           style="font-size: 20px; color: deepskyblue"></i></td>
                                                    <td><i class="bi bi-trash2-fill"
                                                           style="font-size: 20px;color: red"></i></td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>


                                <div class="tab-pane fade profile-edit pt-3" id="profile-edit">

                                    <!-- Create New Product Form -->
                                    <form id="productForm" action="${contextPath}/product-add" method="post"
                                          oninput="validateForm()">
                                        <div class="row mb-3">
                                            <label for="productName" class="col-md-4 col-lg-3 col-form-label">Tên sản
                                                phẩm</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="productName" type="text" class="form-control"
                                                       id="productName" required>
                                                <div id="productNameError" class="error-message"></div>
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="productBrand" class="col-md-4 col-lg-3 col-form-label">Hãng sản
                                                phẩm</label>
                                            <div class="col-md-8 col-lg-9">
                                                <select name="productBrand" class="form-control" id="productBrand">
                                                    <c:forEach items="${listBrand}" var="brand">
                                                        <option value="${brand.id}">${brand.brandName}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="productCategory" class="col-md-4 col-lg-3 col-form-label">Danh
                                                mục sản phẩm</label>
                                            <div class="col-md-8 col-lg-9">
                                                <select name="productCategory" class="form-control"
                                                        id="productCategory">
                                                    <c:forEach items="${listCate}" var="category">
                                                        <option value="${category.id}">${category.categoryName}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="unitPrice" class="col-md-4 col-lg-3 col-form-label">Đơn giá
                                                (VND)</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="unitPrice" type="number" class="form-control"
                                                       id="unitPrice" min="0" step="1" required>
                                                <div id="unitPriceError" class="error-message"></div>
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="unitPrice" class="col-md-4 col-lg-3 col-form-label">Số lượng</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="stockUnit" type="number" class="form-control"
                                                       id="stockUnit" min="0" step="1" required>
                                                <div id="stockUnitError" class="error-message"></div>
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="os" class="col-md-4 col-lg-3 col-form-label">Hệ điều
                                                hành</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="os" type="text" class="form-control" id="os">
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="cpu" class="col-md-4 col-lg-3 col-form-label">CPU</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="cpu" type="text" class="form-control" id="cpu">
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="ram" class="col-md-4 col-lg-3 col-form-label">RAM</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="ram" type="text" class="form-control" id="ram">
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="screen" class="col-md-4 col-lg-3 col-form-label">Màn
                                                hình</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="screen" type="text" class="form-control" id="screen">
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="battery" class="col-md-4 col-lg-3 col-form-label">Dung tích
                                                PIN</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="battery" type="text" class="form-control" id="battery">
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="design" class="col-md-4 col-lg-3 col-form-label">Thiết
                                                kế</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="design" type="text" class="form-control" id="design">
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="warranty" class="col-md-4 col-lg-3 col-form-label">Thời gian bảo
                                                hành</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="warranty" type="text" class="form-control" id="warranty">
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="description" class="col-md-4 col-lg-3 col-form-label">Mô tả sản
                                                phẩm</label>
                                            <div class="col-md-8 col-lg-9">
                                                <textarea name="description" class="form-control"
                                                          id="description"></textarea>
                                            </div>
                                        </div>

<%--                                        <div class="row mb-3">--%>
<%--                                            <label for="image" class="col-md-4 col-lg-3 col-form-label">Hình ảnh minh--%>
<%--                                                họa</label>--%>
<%--                                            <div class="col-md-8 col-lg-9">--%>
<%--                                                <input name="image" type="file" class="form-control" id="image">--%>
<%--                                            </div>--%>
<%--                                        </div>--%>

                                        <div class="text-center">
                                            <button type="submit" class="btn btn-primary" id="createButton" disabled>Tạo
                                                mới
                                            </button>
                                            <button type="reset" class="btn btn-secondary" onclick="resetForm()">Reset
                                            </button>
                                        </div>
                                    </form><!-- End Create New Product Form -->
                                </div>
                            </div>
                        </div>
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
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <!-- Template Main JS File -->
    <script src="${contextPath}/assets/js/main.js"></script>
    <script>
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

        function resetForm() {
            document.getElementById('productForm').reset();
            document.getElementById('createButton').disabled = true;
            document.getElementById('productNameError').textContent = '';
            document.getElementById('unitPriceError').textContent = '';
        }
    </script>

</body>

</html>
