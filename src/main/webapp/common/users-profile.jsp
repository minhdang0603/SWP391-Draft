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

    <title>Tài khoản</title>
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
    <link href="${contextPath}/assets/css/orders.css" rel="stylesheet">

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
<jsp:include page="../components/navbar-admin.jsp"/>
<!-- End Header -->

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
            <h1>Thông tin tài khoản</h1>
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
                                        Tổng quan
                                    </button>
                                </li>

                                <li class="nav-item">
                                    <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit">
                                        Thay đổi thông tin
                                    </button>
                                </li>

                                <li class="nav-item">
                                    <button class="nav-link" data-bs-toggle="tab"
                                            data-bs-target="#profile-change-password">
                                        Thay đổi mật khẩu
                                    </button>
                                </li>

                                <c:if test="${account.role == 'MEMBER'}">
                                    <li class="nav-item dropdown">
                                        <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#"
                                           role="button"
                                           aria-expanded="false">Đơn hàng</a>
                                        <ul class="dropdown-menu">
                                            <li>
                                                <button class="dropdown-item" data-bs-toggle="tab"
                                                        data-bs-target="#pending-orders">
                                                    <i class="bx bx-time-five text-warning"></i>
                                                    <span class="text-dark">Chờ xác nhận</span>
                                                </button>
                                            </li>
                                            <li>
                                                <hr class="dropdown-divider">
                                            </li>
                                            <li>
                                                <button class="dropdown-item" data-bs-toggle="tab"
                                                        data-bs-target="#processing-orders">
                                                    <i class="bx bx-loader-circle text-info"></i>
                                                    <span class="text-dark">Đang xử lý</span>
                                                </button>
                                            </li>
                                            <li>
                                                <hr class="dropdown-divider">
                                            </li>
                                            <li>
                                                <button class="dropdown-item" data-bs-toggle="tab"
                                                        data-bs-target="#received-orders">
                                                    <i class="bx bx-check-circle text-success"></i>
                                                    <span class="text-dark">Đã nhận</span>
                                                </button>
                                            </li>
                                            <li>
                                                <hr class="dropdown-divider">
                                            </li>
                                            <li>
                                                <button class="dropdown-item" data-bs-toggle="tab"
                                                        data-bs-target="#cancelled-orders">
                                                    <i class="bx bx-x-circle text-danger"></i>
                                                    <span class="text-dark">Đã hủy</span>
                                                </button>
                                            </li>
                                        </ul>

                                    </li>
                                </c:if>

                            </ul>
                            <div class="tab-content pt-2">

                                <div class="tab-pane fade show active profile-overview" id="profile-overview">
                                    <h5 class="card-title">Thông tin chi tiết</h5>

                                    <div class="row">
                                        <div class="col-lg-3 col-md-4 label ">Tên người dùng</div>
                                        <div class="col-lg-9 col-md-8">${account.userName}</div>
                                    </div>

                                    <div class="row">
                                        <div class="col-lg-3 col-md-4 label">Địa chỉ</div>
                                        <div class="col-lg-9 col-md-8">${account.address}</div>
                                    </div>

                                    <div class="row">
                                        <div class="col-lg-3 col-md-4 label">Số điện thoại</div>
                                        <div class="col-lg-9 col-md-8">${account.phoneNumber}</div>
                                    </div>
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
                                            <label for="fullName" class="col-md-4 col-lg-3 col-form-label">Tên người
                                                dùng</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="fullName" type="text" class="form-control" id="fullName"
                                                       value="${account.userName}">
                                                <small id="fullNameHelp" class="form-text text-danger"></small>
                                                <!-- Thông báo lỗi -->
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="Address" class="col-md-4 col-lg-3 col-form-label">Địa
                                                chỉ</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="address" type="text" class="form-control" id="Address"
                                                       value="${account.address}">
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="Phone" class="col-md-4 col-lg-3 col-form-label">Số điện
                                                thoại</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="phone" type="text" class="form-control" id="Phone"
                                                       value="${account.phoneNumber}">
                                                <small id="phoneHelp" class="form-text text-danger"></small>
                                                <!-- Thông báo lỗi -->
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="Email" class="col-md-4 col-lg-3 col-form-label">Email</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="email" type="email" class="form-control" id="Email"
                                                       value="${account.email}" readonly>
                                            </div>
                                        </div>

                                        <div class="text-center">
                                            <button type="submit" class="btn btn-primary" id="saveChangesBtn">
                                                Lưu thay đổi
                                            </button>
                                        </div>
                                    </form><!-- End Profile Edit Form -->

                                </div>

                                <!-- Change Password Form -->
                                <div class="tab-pane fade profile-change-password pt-3" id="profile-change-password">
                                    <form action="${contextPath}/profile" method="post">
                                        <input type="hidden" name="formType" value="form2">

                                        <div class="row mb-3">
                                            <label for="currentPassword" class="col-md-4 col-lg-3 col-form-label">Mật
                                                khẩu hiện tại</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="currentPassword" type="password" class="form-control"
                                                       id="currentPassword">
                                                <small id="currentPasswordHelp" class="form-text text-danger"></small>
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="newPassword" class="col-md-4 col-lg-3 col-form-label">Mật khẩu
                                                mới</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="newPassword" type="password" class="form-control"
                                                       id="newPassword">
                                                <small id="newPasswordHelp" class="form-text text-danger"></small>
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="renewPassword" class="col-md-4 col-lg-3 col-form-label">Nhập lại
                                                mật khẩu mới</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input type="password" class="form-control" id="renewPassword">
                                                <small id="renewPasswordHelp" class="form-text text-danger"></small>
                                            </div>
                                        </div>

                                        <div class="text-center">
                                            <button type="submit" class="btn btn-primary" id="changePassbtn" disabled>
                                                Lưu mật khẩu mới
                                            </button>
                                        </div>
                                    </form>
                                </div>
                                <!-- End change password Form -->

                                <!-- Pending orders -->
                                <div class="tab-pane fade overflow-auto" id="pending-orders">
                                    <c:choose>
                                        <c:when test="${pendingOrders.size() == 0}">
                                            <div class="no-order">
                                                <img src="https://frontend.tikicdn.com/_desktop-next/static/img/account/empty-order.png"
                                                     class="no-order-img">
                                                <p>Chưa có đơn hàng</p>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="orders">
                                                <c:forEach var="order" items="${pendingOrders}">
                                                    <div class="order">
                                                        <div class="status pb-3">
                                                            <i class="bx bx-time-five"></i>
                                                            <span class="ml-2">Chờ xác nhận</span>
                                                        </div>
                                                        <c:forEach var="item" items="${order.orderDetails}">
                                                            <div class="item d-flex flex-row">
                                                                <div class="item-picture">
                                                                    <img src="${contextPath}/assets/img/product-img/${item.image}"
                                                                         alt="">
                                                                </div>
                                                                <div class="item-name">
                                                                        ${item.productName} <br>
                                                                    <span class="quantity">Số lượng: ${item.quantity}</span>
                                                                </div>
                                                                <div class="item-price price">
                                                                        ${item.unitPrice}
                                                                </div>
                                                            </div>
                                                        </c:forEach>
                                                        <div class="order-footer">
                                                            <a class="btn_5"
                                                               href="#" onclick="showOrderDetails(${order.id})">Chi
                                                                tiết</a>
                                                            <!-- Order detail modal-->
                                                            <div class="modal fade" id="orderDetailsModal${order.id}"
                                                                 tabindex="-1"
                                                                 aria-labelledby="orderDetailsModalLabel"
                                                                 aria-hidden="true">
                                                                <div class="modal-dialog modal-dialog-scrollable modal-xl modal-dialog-centered">
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <h5 class="modal-title"
                                                                                id="orderDetailsModalLabel${order.id}">
                                                                                Chi Tiết Đơn Hàng</h5>
                                                                            <button type="button" class="btn-close"
                                                                                    data-dismiss="modal"
                                                                                    aria-label="Close"></button>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            <div class="row mb-2">
                                                                                <div class="col-md-6">
                                                                                    <p><strong>Mã đơn hàng:</strong>
                                                                                        <span>${order.id}</span></p>
                                                                                    <p><strong>Trạng thái:</strong>
                                                                                        <span>
                                                                        <c:choose>
                                                                            <c:when test="${order.orderStatus == 'pending'}">
                                                                                Đang chờ duyệt
                                                                            </c:when>
                                                                            <c:when test="${order.orderStatus == 'processing'}">
                                                                                Đang xử lý
                                                                            </c:when>
                                                                            <c:when test="${order.orderStatus == 'received'}">
                                                                                Đã nhận hàng
                                                                            </c:when>
                                                                            <c:when test="${order.orderStatus == 'cancelled'}">
                                                                                Đã hủy
                                                                            </c:when>
                                                                        </c:choose>
                                                                    </span></p>
                                                                                    <p><strong>Ngày đặt hàng:</strong>
                                                                                        <span>${order.getFormattedOrderDate()}</span>
                                                                                    </p>
                                                                                    <p><strong>Ngày giao hàng:</strong>
                                                                                        <span>${order.getFormattedDeliverDate()}</span>
                                                                                    </p>
                                                                                    <p><strong>Ngày nhận hàng:</strong>
                                                                                        <span>${order.getFormattedReceiveDate()}</span>
                                                                                    </p>
                                                                                    <p><strong>Ngày thanh toán:</strong>
                                                                                        <span>${order.payment.getFormattedPayDate()}</span>
                                                                                    </p>
                                                                                </div>
                                                                                <div class="col-md-6">
                                                                                    <p><strong>Người đặt hàng:</strong>
                                                                                        <span>${order.customer.userName}</span>
                                                                                    </p>
                                                                                    <p><strong>Số điện thoại:</strong>
                                                                                        <span>${order.phoneNumber}</span>
                                                                                    </p>
                                                                                    <p><strong>Địa chỉ giao
                                                                                        hàng:</strong>
                                                                                        <span>${order.address}</span>
                                                                                    </p>
                                                                                    <p><strong>Ghi chú:</strong>
                                                                                        <span>${order.note}</span>
                                                                                    </p>
                                                                                    <p><strong>Hình thức thanh
                                                                                        toán:</strong> <span>
                                                                        <c:choose>
                                                                            <c:when test="${order.payment.method == 'cod'}">
                                                                                Thanh toán khi nhận hàng
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                Thanh toán online
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </span>
                                                                                    </p>
                                                                                    <p><strong>Trạng thái thanh
                                                                                        toán:</strong>
                                                                                        <span>
                                                                        <c:choose>
                                                                            <c:when test="${order.payment.status == 'unpaid'}">
                                                                                Chưa thanh toán
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                Đã thanh toán
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </span>
                                                                                    </p>
                                                                                </div>
                                                                            </div>
                                                                            <div>
                                                                                <div class="product-table">
                                                                                    <div class="product-header">
                                                                                        <div class="product-cell">Sản
                                                                                            phẩm
                                                                                        </div>
                                                                                        <div class="product-cell">Đơn
                                                                                            giá
                                                                                        </div>
                                                                                        <div class="product-cell">Số
                                                                                            lượng
                                                                                        </div>
                                                                                        <div class="product-cell">Thành
                                                                                            tiền
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="product-body">
                                                                                        <c:forEach
                                                                                                items="${order.orderDetails}"
                                                                                                var="detail">
                                                                                            <div class="product-row">
                                                                                                <div class="product-cell">${detail.productName}</div>
                                                                                                <div class="product-cell price">${detail.unitPrice}</div>
                                                                                                <div class="product-cell">${detail.quantity}</div>
                                                                                                <div class="product-cell price">${detail.unitPrice * detail.quantity}</div>
                                                                                            </div>
                                                                                        </c:forEach>
                                                                                    </div>
                                                                                    <div class="product-footer">
                                                                                        <div class="product-cell"
                                                                                             colspan="3"><strong>Tổng
                                                                                            tiền</strong></div>
                                                                                        <div class="product-cell price">${order.payment.amount}</div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <button type="button"
                                                                                    class="btn btn-secondary"
                                                                                    data-dismiss="modal">Đóng
                                                                            </button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <!-- end modal -->
                                                            <c:if test="${order.payment.status == 'unpaid'}">
                                                                <a class="btn_6 ms-3"
                                                                   onclick="deleteModal('${order.id}')">Hủy đơn hàng</a>
                                                                <div class="modal fade alert-primary" tabindex="-1"
                                                                     data-keyboard="false"
                                                                     id="myModal${order.id}">
                                                                    <div class="modal-dialog modal-dialog-centered">
                                                                        <div class="modal-content">
                                                                            <div class="modal-header">
                                                                                <h5 class="modal-title">Xác Nhận</h5>
                                                                            </div>
                                                                            <div class="container"></div>
                                                                            <div class="modal-body">
                                                                                <p>Bạn có chắc chắn muốn hủy đơn hàng
                                                                                    này không?</p>
                                                                            </div>
                                                                            <div class="modal-footer">
                                                                                <a type="button"
                                                                                   class="btn btn-secondary"
                                                                                   data-dismiss="modal">Hủy
                                                                                </a>
                                                                                <a href="${contextPath}/order-process?orderId=${order.id}&action=cancel"
                                                                                   type="button" id="confirmDeleteBtn"
                                                                                   class="btn btn-primary">Xác nhận
                                                                                </a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </c:if>
                                                            <c:if test="${order.payment.method == 'online' && order.payment.status == 'unpaid'}">
                                                                <a class="btn_6 ms-3"
                                                                   href="${contextPath}/online-payment?orderId=${order.id}">Thanh
                                                                    toán</a>
                                                            </c:if>
                                                            <div class="order-total">
                                                                Tổng tiền: <span
                                                                    class="order-price price">${order.payment.amount}</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <!-- End pending orders -->

                                <!-- Processing orders -->
                                <div class="tab-pane fade overflow-auto" id="processing-orders">
                                    <c:choose>
                                        <c:when test="${processingOrders.size() == 0}">
                                            <div class="no-order">
                                                <img src="https://frontend.tikicdn.com/_desktop-next/static/img/account/empty-order.png"
                                                     class="no-order-img">
                                                <p>Chưa có đơn hàng</p>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="orders">
                                                <c:forEach var="order" items="${processingOrders}">
                                                    <div class="order">
                                                        <div class="status pb-3">
                                                            <i class="bx bx-loader-circle"></i>
                                                            <span class="ml-2">Đang xử lý</span>
                                                        </div>
                                                        <c:forEach var="item" items="${order.orderDetails}">
                                                            <div class="item d-flex flex-row">
                                                                <div class="item-picture">
                                                                    <img src="${contextPath}/assets/img/product-img/${item.image}"
                                                                         alt="">
                                                                </div>
                                                                <div class="item-name">
                                                                        ${item.productName} <br>
                                                                    <span class="quantity">Số lượng: ${item.quantity}</span>
                                                                </div>
                                                                <div class="item-price price">
                                                                        ${item.unitPrice}
                                                                </div>
                                                            </div>
                                                        </c:forEach>
                                                        <div class="order-footer">
                                                            <a class="btn_5"
                                                               href="#" onclick="showOrderDetails(${order.id})">Chi
                                                                tiết</a>
                                                            <!-- Order detail modal-->
                                                            <div class="modal fade" id="orderDetailsModal${order.id}"
                                                                 tabindex="-1"
                                                                 aria-labelledby="orderDetailsModalLabel"
                                                                 aria-hidden="true">
                                                                <div class="modal-dialog modal-dialog-scrollable modal-xl modal-dialog-centered">
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <h5 class="modal-title">Chi
                                                                                Tiết Đơn Hàng</h5>
                                                                            <button type="button" class="btn-close"
                                                                                    data-dismiss="modal"
                                                                                    aria-label="Close"></button>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            <div class="row mb-2">
                                                                                <div class="col-md-6">
                                                                                    <p><strong>Mã đơn hàng:</strong>
                                                                                        <span>${order.id}</span>
                                                                                    </p>
                                                                                    <p><strong>Trạng thái:</strong>
                                                                                        <span>
                                                                        <c:choose>
                                                                            <c:when test="${order.orderStatus == 'pending'}">
                                                                                Đang chờ duyệt
                                                                            </c:when>
                                                                            <c:when test="${order.orderStatus == 'processing'}">
                                                                                Đang xử lý
                                                                            </c:when>
                                                                            <c:when test="${order.orderStatus == 'received'}">
                                                                                Đã nhận hàng
                                                                            </c:when>
                                                                            <c:when test="${order.orderStatus == 'cancelled'}">
                                                                                Đã hủy
                                                                            </c:when>
                                                                        </c:choose>
                                                                    </span></p>
                                                                                    <p><strong>Ngày đặt hàng:</strong>
                                                                                        <span>${order.getFormattedOrderDate()}</span>
                                                                                    </p>
                                                                                    <p><strong>Ngày giao hàng:</strong>
                                                                                        <span>${order.getFormattedDeliverDate()}</span>
                                                                                    </p>
                                                                                    <p><strong>Ngày nhận hàng:</strong>
                                                                                        <span>${order.getFormattedReceiveDate()}</span>
                                                                                    </p>
                                                                                    <p><strong>Ngày thanh toán:</strong>
                                                                                        <span>${order.payment.getFormattedPayDate()}</span>
                                                                                    </p>
                                                                                </div>
                                                                                <div class="col-md-6">
                                                                                    <p><strong>Người đặt hàng:</strong>
                                                                                        <span>${order.customer.userName}</span>
                                                                                    </p>
                                                                                    <p><strong>Số điện thoại:</strong>
                                                                                        <span>${order.phoneNumber}</span>
                                                                                    </p>
                                                                                    <p><strong>Địa chỉ giao
                                                                                        hàng:</strong>
                                                                                        <span>${order.address}</span>
                                                                                    </p>
                                                                                    <p><strong>Ghi chú:</strong>
                                                                                        <span>${order.note}</span>
                                                                                    </p>
                                                                                    <p><strong>Hình thức thanh
                                                                                        toán:</strong> <span>
                                                                        <c:choose>
                                                                            <c:when test="${order.payment.method == 'cod'}">
                                                                                Thanh toán khi nhận hàng
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                Thanh toán online
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </span>
                                                                                    </p>
                                                                                    <p><strong>Trạng thái thanh
                                                                                        toán:</strong>
                                                                                        <span>
                                                                        <c:choose>
                                                                            <c:when test="${order.payment.status == 'unpaid'}">
                                                                                Chưa thanh toán
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                Đã thanh toán
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </span>
                                                                                    </p>
                                                                                </div>
                                                                            </div>
                                                                            <div>
                                                                                <div class="product-table">
                                                                                    <div class="product-header">
                                                                                        <div class="product-cell">Sản
                                                                                            phẩm
                                                                                        </div>
                                                                                        <div class="product-cell">Đơn
                                                                                            giá
                                                                                        </div>
                                                                                        <div class="product-cell">Số
                                                                                            lượng
                                                                                        </div>
                                                                                        <div class="product-cell">Thành
                                                                                            tiền
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="product-body">
                                                                                        <c:forEach
                                                                                                items="${order.orderDetails}"
                                                                                                var="detail">
                                                                                            <div class="product-row">
                                                                                                <div class="product-cell">${detail.productName}</div>
                                                                                                <div class="product-cell price">${detail.unitPrice}</div>
                                                                                                <div class="product-cell">${detail.quantity}</div>
                                                                                                <div class="product-cell price">${detail.unitPrice * detail.quantity}</div>
                                                                                            </div>
                                                                                        </c:forEach>
                                                                                    </div>
                                                                                    <div class="product-footer">
                                                                                        <div class="product-cell"
                                                                                             colspan="3"><strong>Tổng
                                                                                            tiền</strong></div>
                                                                                        <div class="product-cell price">${order.payment.amount}</div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="modal-footer">

                                                                            <button type="button"
                                                                                    class="btn btn-secondary"
                                                                                    data-dismiss="modal">Đóng
                                                                            </button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <!-- end modal -->
                                                            <a class="btn_5 ms-3"
                                                               href="${contextPath}/order-process?orderId=${order.id}&action=receive">Đã
                                                                nhận hàng</a>
                                                            <div class="order-total">
                                                                Tổng tiền: <span
                                                                    class="order-price price">${order.payment.amount}</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <!-- End processing orders -->

                                <!-- Received orders -->
                                <div class="tab-pane fade overflow-auto" id="received-orders">
                                    <c:choose>
                                        <c:when test="${receivedOrders.size() == 0}">
                                            <div class="no-order">
                                                <img src="https://frontend.tikicdn.com/_desktop-next/static/img/account/empty-order.png"
                                                     class="no-order-img">
                                                <p>Chưa có đơn hàng</p>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="orders">
                                                <c:forEach var="order" items="${receivedOrders}">
                                                    <div class="order">
                                                        <div class="status pb-3">
                                                            <i class="bx bx-check-circle"></i>
                                                            <span class="ml-2">Đã nhận</span>
                                                        </div>
                                                        <c:forEach var="item" items="${order.orderDetails}">
                                                            <div class="item d-flex flex-row">
                                                                <div class="item-picture">
                                                                    <img src="${contextPath}/assets/img/product-img/${item.image}"
                                                                         alt="">
                                                                </div>
                                                                <div class="item-name">
                                                                        ${item.productName} <br>
                                                                    <span class="quantity">Số lượng: ${item.quantity}</span>
                                                                </div>
                                                                <div class="flex-column justify-content-start">
                                                                    <div class="item-price price">
                                                                            ${item.unitPrice}
                                                                    </div>
                                                                    <c:if test="${!item.rated}">
                                                                        <a class="btn_7"
                                                                           onclick="ratingModal(${item.product.id})">Đánh
                                                                            giá</a>
                                                                    </c:if>
                                                                </div>
                                                                <!-- Rating modal -->
                                                                <div class="modal fade alert-primary" tabindex="-1"
                                                                     data-keyboard="false"
                                                                     id="ratingModal${item.product.id}">
                                                                    <div class="modal-dialog modal-dialog-centered">
                                                                        <div class="modal-content">
                                                                            <div class="modal-header">
                                                                                <h5 class="modal-title">Đánh giá</h5>
                                                                            </div>
                                                                            <div class="modal-body">
                                                                                <div class="review-form">
                                                                                    <form action="${contextPath}/rating-process"
                                                                                          method="post"
                                                                                          onsubmit="return validateForm()">
                                                                                        <input type="hidden"
                                                                                               name="productId"
                                                                                               value="${item.product.id}">
                                                                                        <input type="hidden"
                                                                                               name="orderDetailId"
                                                                                               value="${item.id}">
                                                                                        <div class="form-group">
                                                                                            <input class="form-control input"
                                                                                                   type="text" readonly
                                                                                                   placeholder="Tên người dùng"
                                                                                                   value="${account.userName}">
                                                                                        </div>
                                                                                        <div class="form-group">
                                                                                            <input class="form-control input"
                                                                                                   type="email" readonly
                                                                                                   placeholder="Email"
                                                                                                   value="${account.email}">
                                                                                        </div>
                                                                                        <div class="form-group">
                                                                                            <textarea
                                                                                                    class="form-control input"
                                                                                                    id="review-text${item.product.id}"
                                                                                                    name="review"
                                                                                                    rows="4"
                                                                                                    maxlength="500"
                                                                                                    placeholder="Bình luận"
                                                                                                    style="resize: none"></textarea>
                                                                                        </div>
                                                                                        <div class="form-group input-rating">
                                                                                            <span>Đánh giá: </span>
                                                                                            <div class="stars">
                                                                                                <input id="star5${item.product.id}"
                                                                                                       name="rating"
                                                                                                       value="5"
                                                                                                       type="radio">
                                                                                                <label for="star5${item.product.id}"
                                                                                                       class="bx bxs-star"></label>
                                                                                                <input id="star4${item.product.id}"
                                                                                                       name="rating"
                                                                                                       value="4"
                                                                                                       type="radio">
                                                                                                <label for="star4${item.product.id}"
                                                                                                       class="bx bxs-star"></label>
                                                                                                <input id="star3${item.product.id}"
                                                                                                       name="rating"
                                                                                                       value="3"
                                                                                                       type="radio">
                                                                                                <label for="star3${item.product.id}"
                                                                                                       class="bx bxs-star"></label>
                                                                                                <input id="star2${item.product.id}"
                                                                                                       name="rating"
                                                                                                       value="2"
                                                                                                       type="radio">
                                                                                                <label for="star2${item.product.id}"
                                                                                                       class="bx bxs-star"></label>
                                                                                                <input id="star1${item.product.id}"
                                                                                                       name="rating"
                                                                                                       value="1"
                                                                                                       type="radio">
                                                                                                <label for="star1${item.product.id}"
                                                                                                       class="bx bxs-star"></label>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="modal-footer">
                                                                                            <button type="button"
                                                                                                    class="btn btn-secondary"
                                                                                                    data-dismiss="modal">
                                                                                                Hủy
                                                                                            </button>
                                                                                            <button type="submit"
                                                                                                    class="btn btn-primary">
                                                                                                Gửi đánh giá
                                                                                            </button>
                                                                                        </div>
                                                                                    </form>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <!-- en model -->
                                                            </div>
                                                        </c:forEach>
                                                        <div class="order-footer">
                                                            <a class="btn_5"
                                                               href="#" onclick="showOrderDetails(${order.id})">Chi
                                                                tiết</a>
                                                            <!-- Order detail modal-->
                                                            <div class="modal fade" id="orderDetailsModal${order.id}"
                                                                 tabindex="-1"
                                                                 aria-labelledby="orderDetailsModalLabel"
                                                                 aria-hidden="true">
                                                                <div class="modal-dialog modal-dialog-scrollable modal-xl modal-dialog-centered">
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <h5 class="modal-title">Chi Tiết Đơn
                                                                                Hàng</h5>
                                                                            <button type="button" class="btn-close"
                                                                                    data-dismiss="modal"
                                                                                    aria-label="Close"></button>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            <div class="row mb-2">
                                                                                <div class="col-md-6">
                                                                                    <p><strong>Mã đơn hàng:</strong>
                                                                                        <span>${order.id}</span>
                                                                                    </p>
                                                                                    <p><strong>Trạng thái:</strong>
                                                                                        <span>
                                                                        <c:choose>
                                                                            <c:when test="${order.orderStatus == 'pending'}">
                                                                                Đang chờ duyệt
                                                                            </c:when>
                                                                            <c:when test="${order.orderStatus == 'processing'}">
                                                                                Đang xử lý
                                                                            </c:when>
                                                                            <c:when test="${order.orderStatus == 'received'}">
                                                                                Đã nhận hàng
                                                                            </c:when>
                                                                            <c:when test="${order.orderStatus == 'cancelled'}">
                                                                                Đã hủy
                                                                            </c:when>
                                                                        </c:choose>
                                                                    </span></p>
                                                                                    <p><strong>Ngày đặt hàng:</strong>
                                                                                        <span>${order.getFormattedOrderDate()}</span>
                                                                                    </p>
                                                                                    <p><strong>Ngày giao hàng:</strong>
                                                                                        <span>${order.getFormattedDeliverDate()}</span>
                                                                                    </p>
                                                                                    <p><strong>Ngày nhận hàng:</strong>
                                                                                        <span>${order.getFormattedReceiveDate()}</span>
                                                                                    </p>
                                                                                    <p><strong>Ngày thanh toán:</strong>
                                                                                        <span>${order.payment.getFormattedPayDate()}</span>
                                                                                    </p>
                                                                                </div>
                                                                                <div class="col-md-6">
                                                                                    <p><strong>Người đặt hàng:</strong>
                                                                                        <span>${order.customer.userName}</span>
                                                                                    </p>
                                                                                    <p><strong>Số điện thoại:</strong>
                                                                                        <span>${order.phoneNumber}</span>
                                                                                    </p>
                                                                                    <p><strong>Địa chỉ giao
                                                                                        hàng:</strong>
                                                                                        <span>${order.address}</span>
                                                                                    </p>
                                                                                    <p><strong>Ghi chú:</strong>
                                                                                        <span>${order.note}</span>
                                                                                    </p>
                                                                                    <p><strong>Hình thức thanh
                                                                                        toán:</strong> <span>
                                                                        <c:choose>
                                                                            <c:when test="${order.payment.method == 'cod'}">
                                                                                Thanh toán khi nhận hàng
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                Thanh toán online
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </span>
                                                                                    </p>
                                                                                    <p><strong>Trạng thái thanh
                                                                                        toán:</strong>
                                                                                        <span>
                                                                        <c:choose>
                                                                            <c:when test="${order.payment.status == 'unpaid'}">
                                                                                Chưa thanh toán
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                Đã thanh toán
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </span>
                                                                                    </p>
                                                                                </div>
                                                                            </div>
                                                                            <div>
                                                                                <div class="product-table">
                                                                                    <div class="product-header">
                                                                                        <div class="product-cell">Sản
                                                                                            phẩm
                                                                                        </div>
                                                                                        <div class="product-cell">Đơn
                                                                                            giá
                                                                                        </div>
                                                                                        <div class="product-cell">Số
                                                                                            lượng
                                                                                        </div>
                                                                                        <div class="product-cell">Thành
                                                                                            tiền
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="product-body">
                                                                                        <c:forEach
                                                                                                items="${order.orderDetails}"
                                                                                                var="detail">
                                                                                            <div class="product-row">
                                                                                                <div class="product-cell">${detail.productName}</div>
                                                                                                <div class="product-cell price">${detail.unitPrice}</div>
                                                                                                <div class="product-cell">${detail.quantity}</div>
                                                                                                <div class="product-cell price">${detail.unitPrice * detail.quantity}</div>
                                                                                            </div>
                                                                                        </c:forEach>
                                                                                    </div>
                                                                                    <div class="product-footer">
                                                                                        <div class="product-cell"
                                                                                             colspan="3" style="font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif"><strong>Tổng
                                                                                            tiền</strong></div>
                                                                                        <div class="product-cell price">${order.payment.amount}</div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <button type="button"
                                                                                    class="btn btn-secondary"
                                                                                    data-dismiss="modal">Đóng
                                                                            </button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <!-- end modal -->
                                                            <div class="order-total">
                                                                Tổng tiền: <span
                                                                    class="order-price price">${order.payment.amount}</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <!-- End received orders -->

                                <!-- Cancelled orders -->
                                <div class="tab-pane fade recent-sales overflow-auto" id="cancelled-orders">
                                    <c:choose>
                                        <c:when test="${cancelledOrders.size() == 0}">
                                            <div class="no-order">
                                                <img src="https://frontend.tikicdn.com/_desktop-next/static/img/account/empty-order.png"
                                                     class="no-order-img">
                                                <p>Chưa có đơn hàng</p>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="orders">
                                                <c:forEach var="order" items="${cancelledOrders}">
                                                    <div class="order">
                                                        <div class="status pb-3">
                                                            <i class="bx bx-x-circle"></i>
                                                            <span class="ml-2">Đã hủy</span>
                                                        </div>
                                                        <c:forEach var="item" items="${order.orderDetails}">
                                                            <div class="item d-flex flex-row">
                                                                <div class="item-picture">
                                                                    <img src="${contextPath}/assets/img/product-img/${item.image}"
                                                                         alt="">
                                                                </div>
                                                                <div class="item-name">
                                                                        ${item.productName} <br>
                                                                    <span class="quantity">Số lượng: ${item.quantity}</span>
                                                                </div>
                                                                <div class="item-price price">
                                                                        ${item.unitPrice}
                                                                </div>
                                                            </div>
                                                        </c:forEach>
                                                        <div class="order-footer">
                                                            <a class="btn_5" href="#"
                                                               onclick="showOrderDetails(${order.id})">Chi tiết</a>
                                                            <!-- Order detail modal-->
                                                            <div class="modal fade" id="orderDetailsModal${order.id}"
                                                                 tabindex="-1"
                                                                 aria-labelledby="orderDetailsModalLabel"
                                                                 aria-hidden="true">
                                                                <div class="modal-dialog modal-dialog-scrollable modal-xl modal-dialog-centered">
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <h5 class="modal-title">Chi Tiết Đơn
                                                                                Hàng</h5>
                                                                            <button type="button" class="btn-close"
                                                                                    data-dismiss="modal"
                                                                                    aria-label="Close"></button>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            <div class="row mb-2">
                                                                                <div class="col-md-6">
                                                                                    <p><strong>Mã đơn hàng:</strong>
                                                                                        <span>${order.id}</span>
                                                                                    </p>
                                                                                    <p><strong>Trạng thái:</strong>
                                                                                        <span>
                                                                        <c:choose>
                                                                            <c:when test="${order.orderStatus == 'pending'}">
                                                                                Đang chờ duyệt
                                                                            </c:when>
                                                                            <c:when test="${order.orderStatus == 'processing'}">
                                                                                Đang xử lý
                                                                            </c:when>
                                                                            <c:when test="${order.orderStatus == 'received'}">
                                                                                Đã nhận hàng
                                                                            </c:when>
                                                                            <c:when test="${order.orderStatus == 'cancelled'}">
                                                                                Đã hủy
                                                                            </c:when>
                                                                        </c:choose>
                                                                    </span></p>
                                                                                    <p><strong>Ngày đặt hàng:</strong>
                                                                                        <span>${order.getFormattedOrderDate()}</span>
                                                                                    </p>
                                                                                    <p><strong>Ngày giao hàng:</strong>
                                                                                        <span>${order.getFormattedDeliverDate()}</span>
                                                                                    </p>
                                                                                    <p><strong>Ngày nhận hàng:</strong>
                                                                                        <span>${order.getFormattedReceiveDate()}</span>
                                                                                    </p>
                                                                                    <p><strong>Ngày thanh toán:</strong>
                                                                                        <span>${order.payment.getFormattedPayDate()}</span>
                                                                                    </p>
                                                                                </div>
                                                                                <div class="col-md-6">
                                                                                    <p><strong>Người đặt hàng:</strong>
                                                                                        <span>${order.customer.userName}</span>
                                                                                    </p>
                                                                                    <p><strong>Số điện thoại:</strong>
                                                                                        <span>${order.phoneNumber}</span>
                                                                                    </p>
                                                                                    <p><strong>Địa chỉ giao
                                                                                        hàng:</strong>
                                                                                        <span>${order.address}</span>
                                                                                    </p>
                                                                                    <p><strong>Ghi chú:</strong>
                                                                                        <span>${order.note}</span>
                                                                                    </p>
                                                                                    <p><strong>Hình thức thanh
                                                                                        toán:</strong> <span>
                                                                        <c:choose>
                                                                            <c:when test="${order.payment.method == 'cod'}">
                                                                                Thanh toán khi nhận hàng
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                Thanh toán online
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </span>
                                                                                    </p>
                                                                                    <p><strong>Trạng thái thanh
                                                                                        toán:</strong>
                                                                                        <span>
                                                                        <c:choose>
                                                                            <c:when test="${order.payment.status == 'unpaid'}">
                                                                                Chưa thanh toán
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                Đã thanh toán
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </span>
                                                                                    </p>
                                                                                </div>
                                                                            </div>
                                                                            <div>
                                                                                <div class="product-table">
                                                                                    <div class="product-header">
                                                                                        <div class="product-cell">Sản
                                                                                            phẩm
                                                                                        </div>
                                                                                        <div class="product-cell">Đơn
                                                                                            giá
                                                                                        </div>
                                                                                        <div class="product-cell">Số
                                                                                            lượng
                                                                                        </div>
                                                                                        <div class="product-cell">Thành
                                                                                            tiền
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="product-body">
                                                                                        <c:forEach
                                                                                                items="${order.orderDetails}"
                                                                                                var="detail">
                                                                                            <div class="product-row">
                                                                                                <div class="product-cell">${detail.productName}</div>
                                                                                                <div class="product-cell price">${detail.unitPrice}</div>
                                                                                                <div class="product-cell">${detail.quantity}</div>
                                                                                                <div class="product-cell price">${detail.unitPrice * detail.quantity}</div>
                                                                                            </div>
                                                                                        </c:forEach>
                                                                                    </div>
                                                                                    <div class="product-footer">
                                                                                        <div class="product-cell">
                                                                                            <strong>Tổng tiền</strong>
                                                                                        </div>
                                                                                        <div class="product-cell price"
                                                                                             id="totalPrice">${order.payment.amount}</div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="modal-footer">

                                                                            <button type="button"
                                                                                    class="btn btn-secondary"
                                                                                    data-dismiss="modal">Đóng
                                                                            </button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <!-- end modal -->
                                                            <div class="order-total">
                                                                Tổng tiền: <span
                                                                    class="order-price price">${order.payment.amount}</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <!-- End cancelled orders -->
                            </div>


                        </div><!-- End Bordered Tabs -->
                    </div>
                </div>
            </div>
        </section>
    </main><!-- End main -->


    <c:if test="${updateSuccess != null}">
    <a class="visually-hidden" id="updateSuccess">${updateSuccess}</a>
    </c:if>
    <c:if test="${passwordChangeSuccess != null}">
    <a class="visually-hidden" id="passwordChangeSuccess">${passwordChangeSuccess}</a>
    </c:if>
    <c:if test="${passwordChangeFailure != null}">
    <a class="visually-hidden" id="passwordChangeFailure">${passwordChangeFailure}</a>
    </c:if>
    <c:if test="${error != null}">
    <a class="visually-hidden" id="error">${error}</a>
    </c:if>
    <c:if test="${success != null}">
    <a class="visually-hidden" id="success">${success}</a>
    </c:if>
    <c:if test="${ratingSuccess != null}">
    <a class="visually-hidden" id="ratingSuccess">${ratingSuccess}</a>
    </c:if>
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
    <script src="${contextPath}/assets/js/profile-modal.js"></script>

    <!-- Toastr -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
