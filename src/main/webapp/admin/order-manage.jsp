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


    <%--    <link href="${contextPath}/assets/vendor/simple-datatables/style.css" rel="stylesheet">--%>

    <!-- Template Main CSS File -->
    <link href="${contextPath}/assets/css/style.css" rel="stylesheet">
    <link href="${contextPath}/assets/css/productManage.css" rel="stylesheet">

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
                            <%--                                <c:if test="${account.role == 'ADMIN' || account.role == 'SALER'}">--%>
                            <li class="nav-item">
                                <button class="nav-link active">
                                    Danh Sách Đơn Hàng
                                </button>
                            </li>
                            <%--                                </c:if>--%>

                            <%--                            <li class="nav-item">--%>
                            <%--                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit">Tạo Mới--%>
                            <%--                                </button>--%>
                            <%--                            </li>--%>

                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane fade show active profile-overview" id="profile-overview">
                                <!-- Order Table -->
                                <div class="table-responsive">
                                    <table id="myTable"
                                           class="table-responsive table-striped datatable align-items-center mb-0">
                                        <thead>
                                        <tr>
                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2 text-center">
                                                ID
                                            </th>
                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 text-center">
                                                Người đặt hàng
                                            </th>
                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 text-center">
                                                Nhân viên phụ trách
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
                                            <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                                Xóa
                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="order" items="${list}">
                                            <tr>
                                                <td class="align-middle text-center">${order.id}</td>
                                                <td class="align-middle text-center"
                                                    style="width: 50%">
                                                        ${order.customer.userName}
                                                </td>
                                                <td class="align-middle text-center"
                                                    style="width: 50%">
                                                        ${order.saler.userName}
                                                </td>
                                                <td class="align-middle text-sm">${order.orderDate}</td>
                                                <td class="align-middle text-sm"
                                                    style="padding-right: 30px">${order.orderStatus}</td>
                                                <td class="align-middle text-center text-sm mr-2"><a href="#"
                                                                                                     onclick="showOrderDetails(
                                                                                                             '${order.id}'
                                                                                                             )">
                                                    <i
                                                            class="bi bi-eye-fill"
                                                            style="font-size: 20px; color: deepskyblue"></i></a></td>

                                                <td class="align-middle text-center text-sm mr-2"><a href="#"
                                                                                                     onclick="editModal('${order.id}')">
                                                    <i
                                                            class="bi bi-pencil-square"
                                                            style="font-size: 20px; color: deepskyblue"></i></a></td>
                                                <td class="align-middle text-center text-sm mr-2"><a href="#"
                                                                                                     onclick="deleteModal('${order.id}')"><i
                                                        class="bi bi-trash2-fill"
                                                        style="font-size: 20px;color: red"></i></a></td>
                                            </tr>
                                            <!--Confirm Delete Modal-->
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
                                                            <p>Bạn có chắc chắn muốn chuyển sản phẩm này sang trạng thái
                                                                "Ngừng bán" không?</p>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <a type="button"
                                                               class="btn btn-secondary"
                                                               data-dismiss="modal">Hủy
                                                            </a>
                                                            <a href="${contextPath}/admin/order-delete?id=${order.id}"
                                                               type="button" id="confirmDeleteBtn"
                                                               class="btn btn-primary">Xác nhận
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--end confirm delete modal-->

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
                                                        <div class="modal-body">
                                                            <div class="row mb-2">
                                                                <div class="col-md-4">
                                                                    <p><strong>Mã đơn hàng:</strong> <span
                                                                            id="modalID">${order.id}</span></p>
                                                                    <p><strong>Trạng thái:</strong> <span
                                                                            id="modalOrderStatus">${order.orderStatus}</span>
                                                                    </p>
                                                                    <p><strong>Nhân viên phụ trách:</strong> <span
                                                                            id="modalSalerName">${order.saler.userName}</span>
                                                                    </p>
                                                                    <p><strong>Ngày đặt hàng:</strong> <span
                                                                            id="modalOrderDate">${order.orderDate}</span>
                                                                    </p>
                                                                    <p><strong>Ngày giao hàng:</strong> <span
                                                                            id="modalDeliveryDate">${order.deliverDate}</span>
                                                                    </p>
                                                                    <p><strong>Ngày nhận hàng:</strong> <span
                                                                            id="modalReceiveDateDate">${order.receiveDate}</span>
                                                                    </p>
                                                                </div>
                                                                <div class="col-md-4">
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
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <table class="table table-responsive">
                                                                        <thead>
                                                                        <tr>
                                                                            <th>Sản phẩm</th>
                                                                            <th>Đơn giá</th>
                                                                            <th>Số lượng</th>
                                                                            <th>Thành tiền</th>
                                                                        </tr>
                                                                        </thead>
                                                                        <tbody id="productTableBody">
                                                                        <c:forEach items="${detailList}" var="detail">
                                                                            <tr>
                                                                                <c:if test="${detail.order.id == order.id}">
                                                                                    <td>${detail.productName}</td>
                                                                                    <td>${detail.unitPrice}</td>
                                                                                    <td>${detail.quantity}</td>
                                                                                    <td class="product-total">${detail.unitPrice * detail.quantity}</td>
                                                                                </c:if>
                                                                            </tr>
                                                                        </c:forEach>
                                                                        </tbody>
                                                                        <tfoot>
                                                                        <tr>
                                                                            <td colspan="3"><strong>Tổng tiền</strong>
                                                                            </td>
                                                                            <td id="totalPrice">0</td>
                                                                        </tr>
                                                                        </tfoot>
                                                                    </table>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-secondary"
                                                                            data-dismiss="modal">Đóng
                                                                    </button>
                                                                </div>
                                                            </div>
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
                                                                        <div class="form-group">
                                                                            <label for="salerNameUpdate"><strong>Nhân
                                                                                viên phụ trách:</strong></label>
                                                                            <select name="salerName"
                                                                                    class="form-control"
                                                                                    id="salerNameUpdate"
                                                                                     required>
                                                                                <c:forEach items="${salerList}"
                                                                                           var="saler">
                                                                                    <option value="${saler.id}" ${saler.id == order.saler.id ? 'selected' : ''}>
                                                                                            ${saler.userName}</option>
                                                                                </c:forEach>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-6">

                                                                    </div>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-secondary"
                                                                            data-dismiss="modal">Đóng
                                                                    </button>
                                                                    <button type="submit"
                                                                            class="btn btn-primary">Lưu
                                                                    </button>
                                                                        <%--                                                                    <a data-toggle="modal" href="#myModal2${pro.id}"--%>
                                                                        <%--                                                                       class="btn btn-primary">Lưu</a>--%>
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
<%--<script src="${contextPath}/assets/vendor/apexcharts/apexcharts.min.js"></script>--%>
<script src="${contextPath}/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/assets/vendor/chart.js/chart.umd.js"></script>
<script src="${contextPath}/assets/vendor/echarts/echarts.min.js"></script>
<script src="${contextPath}/assets/vendor/quill/quill.js"></script>
<%--<script src="${contextPath}/assets/vendor/simple-datatables/simple-datatables.js"></script>--%>
<script src="${contextPath}/assets/vendor/tinymce/tinymce.min.js"></script>
<script src="${contextPath}/assets/vendor/php-email-form/validate.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.datatables.net/2.0.8/js/dataTables.js"></script>

<%--<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>--%>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- Template Main JS File -->
<script src="${contextPath}/assets/js/main.js"></script>
<script src="${contextPath}/assets/js/order-manage.js"></script>

</body>

</html>
