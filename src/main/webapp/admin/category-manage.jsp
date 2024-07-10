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

    <title>Quản lý danh mục</title>
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
        <h1>Quản Lý Danh Mục</h1>
    </div>
    <div id="msg" class="notification">
        <h6 id="msgContent">${msg}</h6>
        <c:remove var="msg" scope="session"/>
    </div>
    <!-- End Page Title -->

    <section class="section profile">
        <!-- Create new category -->
        <div class="row">
            <div class="col-md-10 offset-1">
                <div class="card">
                    <div class="card-body pt-3">
                        <!-- Bordered Tabs -->
                        <ul class="nav nav-tabs nav-tabs-bordered">
                            <%--                                <c:if test="${account.role == 'ADMIN' || account.role == 'SALER'}">--%>
                            <%--                                </c:if>--%>
                            <li class="nav-item">
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit">Tạo Mới
                                </button>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane fade show active profile-overview pt-3">
                                <div class="container">
                                    <form id="categoryForm" method="post" action="${contextPath}/admin/category-add"
                                          onsubmit="return validateFileType()" oninput="validateForm()"
                                    >
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="row mb-3">
                                                    <label for="categoryName" class="col-md-4 col-form-label">Tên danh
                                                        mục
                                                    </label>
                                                    <div class="col-md-8">
                                                        <input name="categoryName" type="text" class="form-control"
                                                               id="categoryName" required>
                                                        <div id="categoryNameError" class="error-message"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="text-center">
                                            <button type="submit" class="btn btn-primary" id="createButton">Lưu</button>
                                            <button type="reset" class="btn btn-secondary" onclick="resetForm()">Reset
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
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
                                    Danh Sách Danh Mục
                                </button>
                            </li>
                            <%--                                </c:if>--%>
                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane fade show active profile-overview" id="profile-overview">
                                <!-- Products Table -->
                                <div class="table-responsive">
                                    <table id="myTable"
                                           class="table-responsive table-striped datatable align-items-center mb-0" style="width: 100%;">
                                        <thead>
                                        <tr>
                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2 text-center">
                                                ID
                                            </th>
                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 text-center">
                                                Danh Mục
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
                                        <c:forEach var="cate" items="${listCate}">
                                            <tr>
                                                <td class="align-middle text-center">${cate.id}</td>
                                                <td class="align-middle text-sm">${cate.categoryName}</td>
                                                <td class="align-middle text-center text-sm mr-2"><a href="#"
                                                                                                     onclick="editModal('${cate.id}')">
                                                    <i
                                                            class="bi bi-pencil-square"
                                                            style="font-size: 20px; color: deepskyblue"></i></a></td>
                                                <td class="align-middle text-center text-sm mr-2"><a href="#"
                                                                                                     onclick="deleteModal('${cate.id}')"><i
                                                        class="bi bi-trash2-fill"
                                                        style="font-size: 20px;color: red"></i></a></td>
                                            </tr>
                                            <!--Confirm Delete Modal-->
                                            <div class="modal fade alert-primary" tabindex="-1"
                                                 data-keyboard="false"
                                                 id="myModal${cate.id}">
                                                <div class="modal-dialog modal-dialog-centered">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Xác Nhận</h5>
                                                        </div>
                                                        <div class="container"></div>
                                                        <div class="modal-body">
                                                            <p>Xóa danh mục sẽ ảnh hưởng đến sản phẩm</p>
                                                            <p>Bạn có chắc chắn muốn xóa danh mục này không?</p>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <a type="button"
                                                               class="btn btn-secondary"
                                                               data-dismiss="modal">Hủy
                                                            </a>
                                                            <a href="${contextPath}/admin/category-delete?cateId=${cate.id}"
                                                               type="button" id="confirmDeleteBtn"
                                                               class="btn btn-primary">Xác nhận
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--end confirm delete modal-->

                                            <!-- Product Update Modal -->
                                            <div class="modal" id="categoryUpdateModal${cate.id}" tabindex="-1"
                                                 aria-labelledby="categoryUpdatesModalLabel"
                                                 aria-hidden="true">
                                                <div class="modal-dialog modal-dialog-scrollable modal-xl modal-dialog-centered"
                                                     style="display: block;" data-keyboard="false"
                                                     data-backdrop="static">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="categoryUpdatesModalLabel">Chỉnh
                                                                Sửa Danh Mục</h5>
                                                            <button type="button" class="btn-close" data-dismiss="modal"
                                                                    aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <form id="updateCategoryForm"
                                                                  onsubmit="return validateFileType()"
                                                                  action="${contextPath}/admin/category-update"
                                                                  method="post">
                                                                <div class="row">
                                                                    <div class="col-lg-6">
                                                                        <div class="form-group">
                                                                            <label for="categoryIDUpdate"><strong>Mã
                                                                                danh
                                                                                mục
                                                                                :</strong></label>
                                                                            <input type="text"
                                                                                   class="form-control readonly"
                                                                                   id="categoryIDUpdate"
                                                                                   name="categoryID"
                                                                                   value="${cate.id}" readonly>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="categoryNameUpdate"><strong>Tên
                                                                                danh mục:</strong></label>
                                                                            <input type="text" class="form-control"
                                                                                   id="categoryNameUpdate"
                                                                                   name="categoryName"
                                                                                   value="${cate.categoryName}">
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
<script src="${contextPath}/assets/js/category-manage.js"></script>

</body>

</html>
