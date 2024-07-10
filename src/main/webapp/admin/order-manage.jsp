<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Quản lý đơn hàng</title>
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


    <%--    <link href="${contextPath}/assets/vendor/simple-datatables/style.css" rel="stylesheet">--%>

    <!-- Template Main CSS File -->
    <link href="${contextPath}/assets/css/style.css" rel="stylesheet">
    <link href="${contextPath}/assets/css/productManage.css" rel="stylesheet">
    <style>
        .product-table {
            display: flex;
            flex-direction: column;
        }

        .product-header, .product-row, .product-footer {
            display: flex;
            flex-direction: row;
        }

        .product-cell {
            flex: 1;
            padding: 8px;
            border: 1px solid #ddd;
            text-align: left;
        }

        .product-header {
            font-weight: bold;
            background-color: #f4f4f4;
        }

        .product-row:nth-child(even) {
            background-color: #f9f9f9;
        }

        .product-footer {
            font-weight: bold;
            background-color: #f4f4f4;
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
        <h1>Quản Lý Đơn Hàng</h1>
    </div>
    <div id="msg" class="notification">
        <h6 id="msgContent">${msg}</h6>
        <c:remove var="msg" scope="session"/>
    </div>
    <!-- End Page Title -->

    <section class="section profile">
        <div class="row">

            <div class="col-md-10 offset-1">
                <div class="card">
                    <div class="card-body pt-3">
                        <!-- Bordered Tabs -->
                        <ul class="nav nav-tabs nav-tabs-bordered">
                            <li class="nav-item">
                                <p class="nav-link active">
                                    Danh Sách Đơn Hàng
                                </p>
                            </li>

                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane fade show active profile-overview" id="profile-overview">
                                <!-- Order Table -->
                                <div class="table-responsive">
                                    <table id="myTable" class="table table-striped datatable align-items-center mb-0" style="width: 100%">
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
                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                                Trạng thái
                                            </th>
                                            <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                                Chi tiết
                                            </th>
                                            <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                                Sửa
                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="order" items="${list}">

                                            <tr>
                                                <td class="align-middle text-center">${order.id}</td>
                                                <td class="align-middle text-center">
                                                        ${order.customer.userName}
                                                </td>
                                                <td class="align-middle text-sm" style="text-align: center">${order.getFormattedOrderDate()}</td>
                                                <td class="align-middle text-sm"
                                                    style="padding-right: 30px">${order.orderStatus}</td>
                                                <td class="align-middle text-center text-sm mr-2"><a href="#"
                                                                                                     onclick="showOrderDetails(
                                                                                                             '${order.id}'
                                                                                                             )">
                                                    <i class="bi bi-eye-fill"
                                                       style="font-size: 20px; color: deepskyblue"></i></a></td>

                                                <td class="align-middle text-center text-sm mr-2"><a href="#"
                                                                                                     onclick="editModal('${order.id}')">
                                                    <i
                                                            class="bi bi-pencil-square"
                                                            style="font-size: 20px; color: deepskyblue"></i></a></td>

                                            </tr>


                                            <!-- Order Details Modal -->
                                            <div class="modal fade" id="orderDetailsModal${order.id}" tabindex="-1"
                                                 aria-labelledby="orderDetailsModalLabel"
                                                 aria-hidden="true">
                                                <div class="modal-dialog modal-dialog-scrollable modal-xl modal-dialog-centered">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="orderDetailsModalLabel">Chi
                                                                Tiết Đơn Hàng</h5>
                                                            <button type="button" class="btn-close" data-dismiss="modal"
                                                                    aria-label="Close"></button>
                                                        </div>
                                                        <div id="toPrint${order.id}" class="modal-body">
                                                            <div class="row mb-2">
                                                                <div class="col-md-6">
                                                                    <p><strong>Mã đơn hàng:</strong> <span
                                                                            id="modalID">${order.id}</span></p>
                                                                    <p><strong>Trạng thái:</strong> <span
                                                                            id="modalOrderStatus">
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
                                                                    </span>
                                                                    </p>
                                                                    <p><strong>Nhân viên phụ trách:</strong> <span
                                                                            id="modalSalerName">${order.saler.userName}</span>
                                                                    </p>
                                                                    <p><strong>Ngày đặt hàng:</strong> <span
                                                                            id="modalOrderDate">${order.getFormattedOrderDate()}</span>
                                                                    </p>
                                                                    <p><strong>Ngày giao hàng:</strong> <span
                                                                            id="modalDeliveryDate">${order.getFormattedDeliverDate()}</span>
                                                                    </p>
                                                                    <p><strong>Ngày nhận hàng:</strong> <span
                                                                            id="modalReceiveDateDate">${order.getFormattedReceiveDate()}</span>
                                                                    </p>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <p><strong>Người đặt hàng:</strong> <span
                                                                            id="modalCustomerName">${order.customer.userName}</span>
                                                                    </p>
                                                                    <p><strong>Số điện thoại:</strong> <span
                                                                            id="modalPhone">${order.phoneNumber}</span>
                                                                    </p>
                                                                    <p><strong>Địa chỉ giao hàng:</strong> <span
                                                                            id="modalAddress">${order.address}</span>
                                                                    </p>
                                                                    <p><strong>Ghi chú:</strong> <span
                                                                            id="modalNote">${order.note}</span>
                                                                    </p>
                                                                    <p><strong>Hình thức thanh toán:</strong> <span
                                                                            id="modalMethod">
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
                                                                    <p><strong>Trạng thái thanh toán:</strong>
                                                                        <span id="modalPaymentStatus">
                                                                        <c:choose>
                                                                            <c:when test="${order.payment.status == 'unpaid'}">
                                                                                Chưa thanh toán
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                Đã thanh toán ${order.payment.getFormattedPayDate()}
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </span>
                                                                    </p>
                                                                </div>
                                                            </div>
                                                            <div>
                                                                <div class="product-table">
                                                                    <div class="product-header">
                                                                        <div class="product-cell">Sản phẩm</div>
                                                                        <div class="product-cell">Đơn giá</div>
                                                                        <div class="product-cell">Số lượng</div>
                                                                        <div class="product-cell">Thành tiền</div>
                                                                    </div>
                                                                    <div id="productTableBody" class="product-body">
                                                                        <c:forEach items="${order.orderDetails}"
                                                                                   var="detail">
                                                                            <div class="product-row">
                                                                                <div class="product-cell">${detail.productName}</div>
                                                                                <div class="product-cell pricevnd">${detail.unitPrice}</div>
                                                                                <div class="product-cell">${detail.quantity}</div>
                                                                                <div class="product-cell pricevnd">${detail.unitPrice * detail.quantity}</div>
                                                                            </div>
                                                                        </c:forEach>
                                                                    </div>
                                                                    <div class="product-footer">
                                                                        <div class="product-cell" colspan="3"><strong>Tổng
                                                                            tiền</strong></div>
                                                                        <div class="product-cell pricevnd"
                                                                             id="totalPrice">${order.payment.amount}</div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-primary"
                                                                    onclick="printModal(${order.id})">In
                                                            </button>

                                                            <button type="button" class="btn btn-secondary"
                                                                    data-dismiss="modal">Đóng
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--end detail modal-->

                                            <!-- Order Update Modal -->
                                            <div class="modal" id="orderUpdateModal${order.id}" tabindex="-1"
                                                 aria-labelledby="orderUpdatesModalLabel"
                                                 aria-hidden="true">
                                                <div class="modal-dialog modal-dialog-scrollable modal-xl modal-dialog-centered"
                                                     style="display: block;" data-keyboard="false"
                                                     data-backdrop="static">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="orderUpdatesModalLabel">Chỉnh
                                                                Sửa Đơn Hàng</h5>
                                                            <button type="button" class="btn-close" data-dismiss="modal"
                                                                    aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <form id="updateOrderForm"
                                                                  action="${contextPath}/admin/order-update"
                                                                  method="post">
                                                                <div class="row">
                                                                    <div class="col-lg-6">
                                                                        <div class="form-group">
                                                                            <label for="orderIDUpdate"><strong>Mã đơn
                                                                                hàng:</strong></label>
                                                                            <input type="text"
                                                                                   class="form-control readonly"
                                                                                   id="orderIDUpdate" name="orderId"
                                                                                   value="${order.id}" readonly>
                                                                        </div>
                                                                        <div class="form-group" style="display: ${account.role == 'ADMIN' ? 'block' : 'none'}">
                                                                            <label for="salerUpdate"><strong>Nhân
                                                                                viên phụ trách:</strong></label>
                                                                            <select name="saler"
                                                                                    class="form-control"
                                                                                    id="salerUpdate"
                                                                                    required >
                                                                                <c:forEach items="${salerList}"
                                                                                           var="saler">
                                                                                    <option value="${saler.id}" ${saler.id == order.saler.id ? 'selected' : ''}>
                                                                                            ${saler.userName}</option>
                                                                                </c:forEach>
                                                                            </select>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="orderStatusUpdate"><strong>Trạng
                                                                                thái đơn hàng:</strong></label>
                                                                            <select name="orderStatus"
                                                                                    class="form-control"
                                                                                    id="orderStatusUpdate" required>
                                                                                <option value="pending" ${order.orderStatus == 'pending' ? 'selected' : ''}>
                                                                                    Đang chờ duyệt
                                                                                </option>
                                                                                <option value="processing" ${order.orderStatus == 'processing' ? 'selected' : ''}>
                                                                                    Đang xử lý
                                                                                </option>
                                                                                <option value="received" ${order.orderStatus == 'received' ? 'selected' : ''}>
                                                                                    Đã nhận hàng
                                                                                </option>
                                                                                <option value="cancelled" ${order.orderStatus == 'cancelled' ? 'selected' : ''}>
                                                                                    Đã hủy
                                                                                </option>
                                                                            </select>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="paymentStatusUpdate"><strong>Trạng
                                                                                thái thanh toán:</strong></label>
                                                                            <select name="paymentStatus"
                                                                                    class="form-control"
                                                                                    id="paymentStatusUpdate" required>
                                                                                <option value="unpaid" ${order.payment.status == 'unpaid' ? 'selected' : ''}>
                                                                                    Chưa thanh toán
                                                                                </option>
                                                                                <option value="paid" ${order.payment.status == 'paid' ? 'selected' : ''}>
                                                                                    Đã thanh toán
                                                                                </option>
                                                                            </select>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="paymentMethodUpdate"><strong>Hình
                                                                                thức thanh toán:</strong></label>
                                                                            <select name="paymentMethod"
                                                                                    class="form-control"
                                                                                    id="paymentMethodUpdate" required>
                                                                                <option value="cod" ${order.payment.method == 'cod' ? 'selected' : ''}>
                                                                                    Thanh toán khi nhận hàng
                                                                                </option>
                                                                                <option value="online" ${order.payment.method == 'online' ? 'selected' : ''}>
                                                                                    Thanh toán online
                                                                                </option>
                                                                            </select>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-lg-6">
                                                                        <div class="form-group">
                                                                            <label for="deliveryDate"><strong>Ngày giao
                                                                                hàng:</strong></label>
                                                                            <input type="date" class="form-control"
                                                                                   id="deliveryDate" name="deliverDate"
                                                                                   value="${order.deliverDate}">
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="receivedDate"><strong>Ngày nhận
                                                                                hàng:</strong></label>
                                                                            <input type="date" class="form-control"
                                                                                   id="receivedDate" name="receiveDate"
                                                                                   value="${order.receiveDate}">
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="paymentDate"><strong>Ngày thanh
                                                                                toán:</strong></label>
                                                                            <input type="date" class="form-control"
                                                                                   id="paymentDate" name="paymentDate"
                                                                                   value="${order.payment.getFormattedPayDate()}">
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-secondary"
                                                                            data-dismiss="modal">Đóng
                                                                    </button>
                                                                    <button type="submit"
                                                                            class="btn btn-primary">Lưu
                                                                    </button>
                                                                </div><!--end update modal-->

                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--end form update-->
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
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
<script src="${contextPath}/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/assets/vendor/quill/quill.js"></script>
<script src="${contextPath}/assets/vendor/tinymce/tinymce.min.js"></script>
<script src="${contextPath}/assets/vendor/php-email-form/validate.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.datatables.net/2.0.8/js/dataTables.js"></script>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- Template Main JS File -->
<script src="${contextPath}/assets/js/main.js"></script>
<script src="${contextPath}/assets/js/order-manage.js"></script>
<script>
    function printModal(id) {
        var printContents = document.querySelector('#toPrint' + id).innerHTML;
        var originalContents = document.body.innerHTML;

        document.body.innerHTML = printContents;

        window.print();

        document.body.innerHTML = originalContents;
        window.location.reload();  // Để tải lại trang và khôi phục nội dung ban đầu
    }
</script>
</body>

</html>
