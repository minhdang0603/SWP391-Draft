<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Quản lý sản phẩm</title>
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
        <h1>Quản Lý Sản Phẩm</h1>
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
                        <div class="tab-content">
                            <div class="tab-pane fade show active profile-overview" id="profile-overview">
                                <!-- Products Table -->
                                <div class="table-responsive">
                                    <table id="myTable"
                                           class="table-responsive table-striped datatable align-items-center mb-0"
                                           style="width: 100%;">
                                        <thead>
                                        <tr>
                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2 text-center">
                                                ID
                                            </th>
                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 text-center">
                                                Sản Phẩm
                                            </th>
                                            <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                                Danh Mục
                                            </th>
                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                                Hãng
                                            </th>
                                            <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7"
                                                id="stock">Tồn Kho
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
                                        <c:forEach var="pro" items="${list}">
                                            <tr>
                                                <td class="align-middle text-center">${pro.id}</td>
                                                <td>
                                                    <a href="#"
                                                       onclick="showProductDetails('${pro.category.id}','${pro.id}')">
                                                            ${pro.productName}
                                                    </a>
                                                </td>
                                                <td class="text-sm">${pro.category.categoryName}</td>
                                                <td class="align-middle text-sm"
                                                    style="padding-right: 30px">${pro.brand.brandName}</td>
                                                <td class="align-middle text-sm"
                                                    style="padding-right: 50px">${pro.stockUnit}</td>
                                                <td class="align-middle text-center text-sm mr-2"><a href="#"
                                                                                                     onclick="editModal('${pro.category.id}','${pro.id}')">
                                                    <i
                                                            class="bi bi-pencil-square"
                                                            style="font-size: 20px; color: deepskyblue"></i></a></td>
                                                <td class="align-middle text-center text-sm mr-2"><a href="#"
                                                                                                     onclick="deleteModal('${pro.id}')"><i
                                                        class="bi bi-trash2-fill"
                                                        style="font-size: 20px;color: red"></i></a></td>
                                            </tr>
                                            <!--Confirm Delete Modal-->
                                            <div class="modal fade alert-primary" tabindex="-1"
                                                 data-keyboard="false"
                                                 id="myModal${pro.id}">
                                                <div class="modal-dialog modal-dialog-centered">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Xác Nhận</h5>
                                                        </div>
                                                        <div class="container"></div>
                                                        <div class="modal-body">
                                                            <p>Bạn có chắc chắn muốn xóa sản phẩm này không?</p>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <a type="button"
                                                               class="btn btn-secondary"
                                                               data-dismiss="modal">Hủy
                                                            </a>
                                                            <a href="${contextPath}/admin/product-delete?id=${pro.id}"
                                                               type="button" id="confirmDeleteBtn"
                                                               class="btn btn-primary">Xác nhận
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--end confirm delete modal-->

                                            <!-- Product Details Modal -->
                                            <div class="modal fade" id="productDetailsModal${pro.id}" tabindex="-1"
                                                 aria-labelledby="productDetailsModalLabel"
                                                 aria-hidden="true">
                                                <div class="modal-dialog modal-dialog-scrollable modal-xl modal-dialog-centered">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="productDetailsModalLabel">Chi
                                                                Tiết Sản Phẩm</h5>
                                                            <button type="button" class="btn-close" data-dismiss="modal"
                                                                    aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="row mb-2">
                                                                <div class="col-md-4">
                                                                    <img id="productImage"
                                                                         src="${contextPath}/assets/img/product-img/${pro.image}"
                                                                         class="img-fluid" alt="Product Image"/>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <p><strong>Mã sản phẩm:</strong> <span
                                                                            id="modalID">${pro.id}</span></p>
                                                                    <p><strong>Tên sản phẩm:</strong> <span
                                                                            id="modalProductName">${pro.productName}</span>
                                                                    </p>
                                                                    <p><strong>Trạng thái:</strong> <span
                                                                            id="modalProductStatus">${pro.status}</span>
                                                                    </p>
                                                                    <p><strong>Đơn giá:</strong> <span
                                                                            id="modalUnitPrice">${pro.unitPrice}</span>
                                                                        VND</p>
                                                                    <p><strong>Tồn kho:</strong> <span
                                                                            id="modalStockUnit">${pro.stockUnit}</span>
                                                                    </p>
                                                                    <p><strong>Đã bán:</strong> <span
                                                                            id="modalSoldUnit">${pro.soldUnit}</span>
                                                                    </p>

                                                                    <p><strong>Mô tả:</strong> <span
                                                                            id="modalDescription">${pro.description}</span>
                                                                    </p>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <p><strong>Danh mục:</strong> <span
                                                                            id="modalCategoryName">${pro.category.categoryName}</span>
                                                                    </p>
                                                                    <p><strong>Hãng:</strong> <span
                                                                            id="modalBrandName">${pro.brand.brandName}</span>
                                                                    </p>
                                                                    <div id="technicalDetails"
                                                                         style="display: ${(pro.category.id == 1 || pro.category.id == 2) ? 'block' : 'none'}">
                                                                        <p><strong>Hệ điều hành:</strong> <span
                                                                                id="modalOS">${pro.operatingSystem}</span>
                                                                        </p>
                                                                        <p><strong>CPU:</strong> <span
                                                                                id="modalCPU">${pro.cpu}</span></p>
                                                                        <p><strong>RAM:</strong><span
                                                                                id="modalRAM">${pro.ram}</span></p>
                                                                        <p><strong>Màn hình:</strong> <span
                                                                                id="modalScreen">${pro.monitorScale}</span>
                                                                        </p>
                                                                        <p><strong>Pin:</strong> <span
                                                                                id="modalBattery">${pro.batteryVol}</span>
                                                                        </p>
                                                                        <p><strong>Thiết kế:</strong> <span
                                                                                id="modalDesign">${pro.design}</span>
                                                                        </p>
                                                                    </div>
                                                                    <p><strong>Bảo hành:</strong> <span
                                                                            id="modalWarranty">${pro.maintenance}</span>
                                                                    </p>
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

                                            <!-- Product Update Modal -->
                                            <div class="modal" id="productUpdateModal${pro.id}" tabindex="-1"
                                                 aria-labelledby="productUpdatesModalLabel"
                                                 aria-hidden="true">
                                                <div class="modal-dialog modal-dialog-scrollable modal-xl modal-dialog-centered"
                                                     style="display: block;" data-keyboard="false"
                                                     data-backdrop="static">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="productUpdatesModalLabel">Chỉnh
                                                                Sửa Chi Tiết Sản Phẩm</h5>
                                                            <button type="button" class="btn-close" data-dismiss="modal"
                                                                    aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <form id="updateProductForm"
                                                                  action="${contextPath}/admin/product-update"
                                                                  method="post" enctype="multipart/form-data">
                                                                <div class="row">
                                                                    <div class="col-lg-6">
                                                                        <div class="form-group">
                                                                            <label for="productIDUpdate"><strong>Mã sản
                                                                                phẩm:</strong></label>
                                                                            <input type="text"
                                                                                   class="form-control readonly"
                                                                                   id="productIDUpdate" name="productID"
                                                                                   value="${pro.id}" readonly>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="productNameUpdate${pro.id}"><strong>Tên
                                                                                sản
                                                                                phẩm:</strong></label>
                                                                            <input type="text" class="form-control"
                                                                                   id="productNameUpdate${pro.id}"
                                                                                   name="productName"
                                                                                   value="${pro.productName}" required
                                                                                   oninput="validateProductName(${pro.id})">
                                                                            <div id="productNameUpdateError${pro.id}"
                                                                                 class="error-message"></div>
                                                                        </div>
                                                                        <div class="form-group mt-1">
                                                                            <h6><strong>Trạng thái:</strong></h6>
                                                                            <input type="radio" name="productStatus"
                                                                                   id="activeProduct"
                                                                                   value="active" ${(pro.status=="active"?"checked":"")} >
                                                                            <label for="activeProduct" class="me-5">Active</label>
                                                                            <input type="radio" name="productStatus"
                                                                                   id="inactiveProduct"
                                                                                   value="inactive" ${(pro.status=="inactive"?"checked":"")} >
                                                                            <label for="inactiveProduct">Inactive</label>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="unitPriceUpdate${pro.id}"><strong>Đơn
                                                                                giá (VND):</strong></label>
                                                                            <input type="number" class="form-control"
                                                                                   id="unitPriceUpdate${pro.id}" min="0"
                                                                                   step="1"
                                                                                   name="unitPrice"
                                                                                   value="${pro.unitPrice}" required
                                                                                   oninput="validateUnitPrice(${pro.id})">
                                                                            <div id="unitPriceUpdateError${pro.id}"
                                                                                 class="error-message"></div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="stockUnitUpdate${pro.id}"><strong>Tồn
                                                                                kho:</strong></label>
                                                                            <input name="stockUnit" type="number"
                                                                                   class="form-control"
                                                                                   id="stockUnitUpdate${pro.id}" min="0"
                                                                                   step="1"
                                                                                   value="${pro.stockUnit}" required
                                                                                   oninput="validateStockUnit(${pro.id})">
                                                                            <div id="stockUnitUpdateError${pro.id}"
                                                                                 class="error-message"></div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="soldUnitUpdate${pro.id}"><strong>Đã
                                                                                bán:</strong></label>
                                                                            <input type="number" class="form-control"
                                                                                   id="soldUnitUpdate${pro.id}"
                                                                                   name="soldUnit"
                                                                                   min="0" step="1"
                                                                                   value="${pro.soldUnit}" required
                                                                                   oninput="validateSoldUnit(${pro.id})">
                                                                            <div id="soldUnitUpdateError${pro.id}"
                                                                                 class="error-message"></div>
                                                                        </div>

                                                                        <div class="form-group">
                                                                            <label for="descriptionUpdate"><strong>Mô
                                                                                tả:</strong></label>
                                                                            <textarea class="form-control"
                                                                                      id="descriptionUpdate" cols="10"
                                                                                      rows="5"
                                                                                      name="description">${pro.description}</textarea>
                                                                        </div>
                                                                        <div class="form-group mt-1">
                                                                            <label for="fileUpload${pro.id}"><strong>Ảnh
                                                                                sản
                                                                                phẩm:</strong></label>
                                                                            <input type="file" class="form-control-file"
                                                                                   id="fileUpload${pro.id}"
                                                                                   accept=".jpg, .jpeg, .png, .img"
                                                                                   name="image"
                                                                                   oninput="validateImage(${pro.id})">
                                                                            <div id="imageUpdateError${pro.id}"
                                                                                 class="error-message"></div>
                                                                            <img id="imagePreview${pro.id}"
                                                                                 src="${contextPath}/assets/img/product-img/${pro.image}"
                                                                                 alt="Image Preview"
                                                                                 style="max-width: 50%; margin-top: 10px;">

                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-6">
                                                                        <div class="form-group">
                                                                            <label for="categoryNameUpdate"><strong>Danh
                                                                                mục:</strong></label>
                                                                            <select name="productCategory"
                                                                                    class="form-control"
                                                                                    id="categoryNameUpdate"
                                                                                    onchange="toggleFields()" required>
                                                                                <c:forEach items="${listCate}"
                                                                                           var="category">
                                                                                    <option value="${category.id}" ${category.id == pro.category.id ? 'selected' : ''}>
                                                                                            ${category.categoryName}</option>
                                                                                </c:forEach>
                                                                            </select>
                                                                        </div>
                                                                        <div class="form-group" style="display: none;">
                                                                            <label for="brandNameUpdate"><strong>Hãng:</strong></label>
                                                                            <select name="productBrand"
                                                                                    class="form-control"
                                                                                    id="brandNameUpdate" required>
                                                                                <c:forEach items="${listBrand}"
                                                                                           var="brand">
                                                                                    <option value="${brand.id}" ${brand.id == pro.brand.id ? 'selected' : ''}>
                                                                                            ${brand.brandName}</option>
                                                                                </c:forEach>
                                                                            </select>
                                                                        </div>
                                                                        <div style="display: ${(pro.category.id == 1 || pro.category.id == 2) ? 'block' : 'none'}"
                                                                             id="technicalDetailsUpdate">
                                                                            <div class="form-group">
                                                                                <label for="osUpdate"><strong>Hệ điều
                                                                                    hành:</strong></label>
                                                                                <input type="text" class="form-control"
                                                                                       id="osUpdate"
                                                                                       name="operatingSystem"
                                                                                       value="${pro.operatingSystem}">
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label for="cpuUpdate"><strong>CPU:</strong></label>
                                                                                <input type="text" class="form-control"
                                                                                       id="cpuUpdate" name="cpu"
                                                                                       value="${pro.cpu}">
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label for="ramUpdate"><strong>RAM:</strong></label>
                                                                                <input type="text" class="form-control"
                                                                                       id="ramUpdate" name="ram"
                                                                                       value="${pro.ram}">
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label for="screenUpdate"><strong>Màn
                                                                                    hình:</strong></label>
                                                                                <input type="text" class="form-control"
                                                                                       id="screenUpdate"
                                                                                       name="monitorScale"
                                                                                       value="${pro.monitorScale}">
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label for="batteryUpdate"><strong>Pin:</strong></label>
                                                                                <input type="text" class="form-control"
                                                                                       id="batteryUpdate"
                                                                                       name="batteryVol"
                                                                                       value="${pro.batteryVol}">
                                                                            </div>
                                                                            <div class="form-group h-50">
                                                                                <label for="designUpdate"><strong>Thiết
                                                                                    kế:</strong></label>
                                                                                <input type="text" class="form-control"
                                                                                       id="designUpdate" name="design"
                                                                                       value="${pro.design}">
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="warrantyUpdate"><strong>Bảo
                                                                                hành:</strong></label>
                                                                            <input type="text" class="form-control"
                                                                                   id="warrantyUpdate"
                                                                                   name="maintenance"
                                                                                   value="${pro.maintenance}">
                                                                        </div>

                                                                    </div>
                                                                </div>

                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-secondary"
                                                                            data-dismiss="modal">Đóng
                                                                    </button>
                                                                    <button type="submit"
                                                                            class="btn btn-primary"
                                                                            id="updateButton${pro.id}"
                                                                    >Lưu
                                                                    </button>

                                                                </div>

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


                            <div class="tab-pane fade profile-edit pt-3" id="profile-edit">

                                <!-- Create New Product Form -->
                                <div class="container">
                                    <form id="productForm" method="post" action="${contextPath}/admin/product-add"
                                          enctype="multipart/form-data">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="row mb-3">
                                                    <label for="productName" class="col-md-4 col-form-label">Tên sản
                                                        phẩm</label>
                                                    <div class="col-md-8">
                                                        <input name="productName" type="text" class="form-control"
                                                               id="productName" required>
                                                        <div id="productNameError" class="error-message"></div>
                                                    </div>
                                                </div>

                                                <div class="row mb-3">
                                                    <label class="col-form-label col-md-4">Trạng thái: </label>
                                                    <div class="col-md-4">
                                                        <input type="radio" name="productStatus"
                                                               id="activeProductStatus"
                                                               value="active" checked>
                                                        <label for="activeProductStatus"
                                                               class="col-form-label">Active</label>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <input type="radio" name="productStatus"
                                                               id="inactiveProductStatus"
                                                               value="inactive">
                                                        <label for="inactiveProductStatus" class="col-form-label">Inactive</label>
                                                    </div>
                                                </div>

                                                <div class="row mb-3">
                                                    <label for="productBrand" class="col-md-4 col-form-label">Hãng sản
                                                        phẩm</label>
                                                    <div class="col-md-8">
                                                        <select name="productBrand" class="form-control"
                                                                id="productBrand" required>
                                                            <option value="">Chọn hãng sản phẩm</option>
                                                            <c:forEach items="${listBrand}" var="brand">
                                                                <option value="${brand.id}">${brand.brandName}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>

                                                <div class="row mb-3">
                                                    <label for="productCategory" class="col-md-4 col-form-label">Danh
                                                        mục sản phẩm</label>
                                                    <div class="col-md-8">
                                                        <select name="productCategory" class="form-control"
                                                                id="productCategory" onchange="toggleFields()" required>
                                                            <option value="">Chọn danh mục sản phẩm</option>
                                                            <c:forEach items="${listCate}" var="category">
                                                                <option value="${category.id}">${category.categoryName}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>

                                                <div class="row mb-3">
                                                    <label for="unitPrice" class="col-md-4 col-form-label">Đơn giá
                                                        (VND)</label>
                                                    <div class="col-md-8">
                                                        <input name="unitPrice" type="number" class="form-control"
                                                               id="unitPrice" min="0" step="1" required>
                                                        <div id="unitPriceError" class="error-message"></div>
                                                    </div>
                                                </div>

                                                <div class="row mb-3">
                                                    <label for="stockUnit" class="col-md-4 col-form-label">Số
                                                        lượng</label>
                                                    <div class="col-md-8">
                                                        <input name="stockUnit" type="number" class="form-control"
                                                               id="stockUnit" min="0" step="1" required>
                                                        <div id="stockUnitError" class="error-message"></div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div id="conditionalFields" style="display: none;">
                                                    <div class="row mb-3">
                                                        <label for="os" class="col-md-4 col-form-label">Hệ điều
                                                            hành</label>
                                                        <div class="col-md-8">
                                                            <input name="os" type="text" class="form-control" id="os">
                                                        </div>
                                                    </div>

                                                    <div class="row mb-3">
                                                        <label for="cpu" class="col-md-4 col-form-label">CPU</label>
                                                        <div class="col-md-8">
                                                            <input name="cpu" type="text" class="form-control" id="cpu">
                                                        </div>
                                                    </div>

                                                    <div class="row mb-3">
                                                        <label for="ram" class="col-md-4 col-form-label">RAM</label>
                                                        <div class="col-md-8">
                                                            <input name="ram" type="text" class="form-control" id="ram">
                                                        </div>
                                                    </div>

                                                    <div class="row mb-3">
                                                        <label for="screen" class="col-md-4 col-form-label">Màn
                                                            hình</label>
                                                        <div class="col-md-8">
                                                            <input name="screen" type="text" class="form-control"
                                                                   id="screen">
                                                        </div>
                                                    </div>

                                                    <div class="row mb-3">
                                                        <label for="battery" class="col-md-4 col-form-label">Dung tích
                                                            PIN</label>
                                                        <div class="col-md-8">
                                                            <input name="battery" type="text" class="form-control"
                                                                   id="battery">
                                                        </div>
                                                    </div>

                                                    <div class="row mb-3">
                                                        <label for="design" class="col-md-4 col-form-label">Thiết
                                                            kế</label>
                                                        <div class="col-md-8">
                                                            <input name="design" type="text" class="form-control"
                                                                   id="design">
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row mb-3">
                                                    <label for="warranty" class="col-md-4 col-form-label">Thời gian bảo
                                                        hành</label>
                                                    <div class="col-md-8">
                                                        <input name="warranty" type="text" class="form-control"
                                                               id="warranty">
                                                    </div>
                                                </div>

                                                <div class="row mb-3">
                                                    <label for="description" class="col-md-4 col-form-label">Mô tả sản
                                                        phẩm</label>
                                                    <div class="col-md-8">
        <textarea name="description" class="form-control large-textarea"
                  id="description"></textarea>
                                                    </div>
                                                </div>
                                                <div class="row mb-3">
                                                    <label for="image" class="col-md-4 col-form-label">Ảnh minh
                                                        họa:</label>
                                                    <div class="col-md-8">
                                                        <input type="file" class="form-control-file"
                                                               id="image" accept=".jpg, .jpeg, .png, .img" name="image">
                                                        <div id="imageError" class="error-message"></div>
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

<%--<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>--%>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- Template Main JS File -->
<script src="${contextPath}/assets/js/main.js"></script>
<script src="${contextPath}/assets/js/product-manage.js"></script>

</body>

</html>
