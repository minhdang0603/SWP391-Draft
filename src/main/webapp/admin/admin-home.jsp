<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Dashboard</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

    <!-- Favicons -->
    <link href="${contextPath}/assets/img/favicon.png" rel="icon">

    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
          rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="../assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="../assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="../assets/vendor/quill/quill.snow.css" rel="stylesheet">
    <link href="../assets/vendor/quill/quill.bubble.css" rel="stylesheet">
    <link href="../assets/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="../assets/vendor/simple-datatables/style.css" rel="stylesheet">

    <link href="../assets/css/style.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/v/dt/dt-2.0.8/date-1.5.2/r-3.0.2/sp-2.3.1/datatables.min.css"
          rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- Ensure jQuery is loaded first -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</head>
</head>
<body>
<!-- ======= Header ======= -->
<jsp:include page="../components/navbar-admin.jsp"/>
<!-- End Header -->

<!-- ======= Sidebar ======= -->
<jsp:include page="../components/sidebar.jsp"/>
<!-- End Sidebar-->

<main id="main" class="main">

    <div class="pagetitle">
        <h1>Dashboard</h1>
    </div><!-- End Page Title -->

    <section class="section dashboard">
        <div class="row">

            <!-- Left side columns -->
            <div class="col-lg-12">
                <div class="row">

                    <!-- Sales Card -->
                    <div class="col-xxl-4 col-md-6">
                        <div class="card info-card sales-card">
                            <div class="filter">
                                <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                    <li class="dropdown-header text-start">
                                        <h6>Filter</h6>
                                    </li>
                                    <li><a class="dropdown-item filter-option" href="#" data-filter="today">Hôm nay</a>
                                    </li>
                                    <li><a class="dropdown-item filter-option" href="#" data-filter="thisMonth">Tháng
                                        này</a></li>
                                    <li><a class="dropdown-item filter-option" href="#" data-filter="thisYear">Năm
                                        nay</a></li>
                                </ul>
                            </div>
                            <div class="card-body">
                                <h5 class="card-title">Đơn hàng <span id="filter-label">| Hôm nay</span></h5>
                                <div class="d-flex align-items-center">
                                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                        <i class="bi bi-cart"></i>
                                    </div>
                                    <div class="ps-3">
                                        <h6 id="sales-count">${sales}</h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div><!-- End Sales Card -->

                    <!-- Revenue Card -->
                    <div class="col-xxl-4 col-md-6">
                        <div class="card info-card revenue-card">
                            <div class="filter">
                                <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                    <li class="dropdown-header text-start">
                                        <h6>Filter</h6>
                                    </li>
                                    <li><a class="dropdown-item filter-option-revenue" href="#" data-filter="today">Hôm
                                        nay</a></li>
                                    <li><a class="dropdown-item filter-option-revenue" href="#" data-filter="thisMonth">Tháng
                                        này</a></li>
                                    <li><a class="dropdown-item filter-option-revenue" href="#" data-filter="thisYear">Năm
                                        nay</a></li>
                                </ul>
                            </div>
                            <div class="card-body">
                                <h5 class="card-title">Doanh Thu <span id="revenue-filter-label">| Hôm nay</span></h5>
                                <div class="d-flex align-items-center">
                                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                        <i class="bi bi-currency-dollar"></i>
                                    </div>
                                    <div class="ps-3">
                                        <h6 id="revenue-amount">${totalRevenue}</h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div><!-- End Revenue Card -->

                    <!-- Customers Card -->
                    <div class="col-xxl-4 col-xl-12">

                        <div class="card info-card customers-card">

                            <div class="card-body">
                                <h5 class="card-title">Khách hàng</h5>

                                <div class="d-flex align-items-center">
                                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                        <i class="bi bi-people"></i>
                                    </div>
                                    <div class="ps-3">
                                        <h6>${cusQuant}</h6>

                                    </div>
                                </div>

                            </div>
                        </div>

                    </div><!-- End Customers Card -->


                    <!-- Recent Orders -->
                    <div class="col-12">
                        <div class="card recent-sales overflow-auto">

                            <div class="card-body">
                                <h5 class="card-title">Đơn hàng gần đây</h5>

                                <!-- Order Table -->
                                <div class="table-responsive">
                                    <table id="myTable"
                                           class="table table-striped datatable align-items-center mb-0 display"
                                           style="width: 100%">
                                        <thead>
                                        <tr>
                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-0 text-center">
                                                ID
                                            </th>
                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-1 text-center">
                                                Người đặt hàng
                                            </th>
                                            <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                                Ngày tạo
                                            </th>
                                            <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                                Tổng tiền
                                            </th>
                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                                Trạng thái
                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="order" items="${orderList}">
                                            <tr>
                                                <td class="align-middle text-center">${order.id}</td>
                                                <td class="align-middle text-center">
                                                        ${order.customer.userName}
                                                </td>
                                                <td class="align-middle text-sm"
                                                    style="text-align: center">${order.getFormattedOrderDate()}</td>
                                                <td class="align-middle text-center text-sm payment-amount"
                                                    style="padding-right: 30px">${order.payment.amount}</td>
                                                <td class="align-middle text-sm"
                                                    style="padding-right: 30px">${order.orderStatus}</td>

                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                        </div>
                    </div><!-- End Recent Sales -->

<%--                    <!-- Recent Ratings -->--%>
<%--                    <div class="col-12">--%>
<%--                        <div class="card recent-ratings overflow-auto">--%>

<%--                            <div class="card-body">--%>
<%--                                <h5 class="card-title">Đánh giá sản phẩm gần đây</h5>--%>

<%--                                <!-- Rating Table -->--%>
<%--                                <div class="table-responsive">--%>
<%--                                    <table id="myRatingTable"--%>
<%--                                           class="table table-striped datatable align-items-center mb-0 display"--%>
<%--                                           style="width: 100%">--%>
<%--                                        <thead>--%>
<%--                                        <tr>--%>
<%--                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-1 text-center">--%>
<%--                                                Sản phẩm--%>
<%--                                            </th>--%>
<%--                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-1 text-center">--%>
<%--                                                Người mua--%>
<%--                                            </th>--%>
<%--                                            <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">--%>
<%--                                                Nội dung bình luận--%>
<%--                                            </th>--%>
<%--                                            <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">--%>
<%--                                                Ngày tạo--%>
<%--                                            </th>--%>
<%--                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">--%>
<%--                                                Điểm đánh giá--%>
<%--                                            </th>--%>
<%--                                        </tr>--%>
<%--                                        </thead>--%>
<%--                                        <tbody>--%>
<%--                                        <c:forEach var="rate" items="${ratingList}">--%>
<%--                                            <tr>--%>
<%--                                                <td class="align-middle text-center">--%>
<%--                                                        ${rate.product.productName}--%>
<%--                                                </td>--%>
<%--                                                <td class="align-middle text-center">--%>
<%--                                                        ${rate.user.userName}--%>
<%--                                                </td>--%>
<%--                                                <td class="align-middle text-center">--%>
<%--                                                        ${rate.content}--%>
<%--                                                </td>--%>
<%--                                                <td class="align-middle text-sm"--%>
<%--                                                    style="text-align: center">${rate.getFormattedCreateTime()}</td>--%>
<%--                                                <td class="align-middle text-sm"--%>
<%--                                                    style="padding-right: 30px">${rate.ratingScore}</td>--%>

<%--                                            </tr>--%>
<%--                                        </c:forEach>--%>
<%--                                        </tbody>--%>
<%--                                    </table>--%>
<%--                                </div>--%>
<%--                            </div>--%>

<%--                        </div>--%>
<%--                    </div><!-- End Recent Sales -->--%>

                    <!-- Recent Ratings -->
                    <div class="col-12">
                        <div class="card recent-ratings overflow-auto">
                            <div class="card-body">
                                <h5 class="card-title">Đánh giá sản phẩm gần đây</h5>

                                <!-- Search Box -->
                                <div class="row mb-3">
                                    <div class="col">
                                        <input type="text" id="searchScore" class="form-control" placeholder="Tìm kiếm theo Điểm đánh giá">
                                    </div>
                                    <div class="col">
                                        <input type="date" id="searchDate" class="form-control" placeholder="Tìm kiếm theo Ngày tạo">
                                    </div>
                                </div>

                                <!-- Rating Table -->
                                <div class="table-responsive">
                                    <table id="myRatingTable" class="table table-striped align-items-center mb-0" style="width: 100%">
                                        <thead>
                                        <tr>
                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-1 text-center">Sản phẩm</th>
                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-1 text-center">Người mua</th>
                                            <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Nội dung bình luận</th>
                                            <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Ngày tạo</th>
                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Điểm đánh giá</th>
                                        </tr>
                                        </thead>
                                        <tbody id="ratingBody">
                                        <!-- Your rows will be here -->
                                        <c:forEach var="rate" items="${ratingList}">
                                            <tr>
                                                <td class="align-middle text-center">${rate.product.productName}</td>
                                                <td class="align-middle text-center">${rate.user.userName}</td>
                                                <td class="align-middle text-center">${rate.content}</td>
                                                <td class="align-middle text-sm text-center">${rate.getFormattedCreateTime()}</td>
                                                <td class="align-middle text-sm text-center">${rate.ratingScore}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Pagination Controls -->
                                <div class="row mt-2">
                                    <div class="col">
                                        <div id="pagination" class="btn-group"></div>
                                        <span id="pageInfo" class="ml-2"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                </div>
            </div><!-- End Left side columns -->


        </div>
    </section>

</main><!-- End #main -->

<!-- ======= Footer ======= -->
<footer id="footer" class="footer">
    <div class="copyright">
        &copy; Copyright <strong><span>LaptopTG</span></strong>. All Rights Reserved
    </div>
</footer><!-- End Footer -->

<a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i
        class="bi bi-arrow-up-short"></i></a>

<!-- Vendor JS Files -->

<script src="../assets/vendor/apexcharts/apexcharts.min.js"></script>
<script src="../assets/vendor/quill/quill.js"></script>
<script src="../assets/vendor/tinymce/tinymce.min.js"></script>
<script src="../assets/vendor/php-email-form/validate.js"></script>

<script src="https://cdn.datatables.net/v/dt/dt-2.0.8/date-1.5.2/r-3.0.2/sp-2.3.1/datatables.min.js"></script>


<!-- Template Main JS File -->
<script src="../assets/js/dashboard.js"></script>
<script src="../assets/js/main.js"></script>
</body>
</html>