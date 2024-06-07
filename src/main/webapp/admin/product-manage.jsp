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
    <link rel="stylesheet" href="https://cdn.datatables.net/2.0.8/css/dataTables.dataTables.css">


    <%--    <link href="${contextPath}/assets/vendor/simple-datatables/style.css" rel="stylesheet">--%>

    <!-- Template Main CSS File -->
    <link href="${contextPath}/assets/css/style.css" rel="stylesheet">

    <style>

        .form-control-lg {
            font-size: 1.25rem;
            padding: .5rem 1rem;
        }

        .large-textarea {
            min-height: 200px;
            font-size: 1.25rem;
            padding: .75rem;
        }

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
<jsp:include page="../components/navbar-admin.jsp"/>
<!-- End Header -->
<c:if test="${account.role == 'ADMIN' || account.role == 'SALER'}">
    <jsp:include page="../components/sidebar.jsp"/>
</c:if>

<main id="main" class="main">

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

                            <li class="nav-item">
                                <button class="nav-link active" data-bs-toggle="tab"
                                        data-bs-target="#profile-overview">
                                    Danh Sách Sản Phẩm
                                </button>
                            </li>

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
                                           class="table-responsive table-striped datatable align-items-center mb-0">
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
                                                    <%--                                                <td class="align-middle text-center"><img--%>
                                                    <%--                                                        style="width: 100px; height: 100px"--%>
                                                    <%--                                                        src="${contextPath}/assets/img/product-img/${pro.image}">--%>
                                                    <%--                                                </td>--%>
                                                <td class="align-middle text-center"
                                                    style="width: 50%">
                                                    <a href="#"
                                                       onclick="showProductDetails(
                                                               '${pro.id}',
                                                               '${pro.productName}',
                                                               '${pro.category.categoryName}',
                                                               '${pro.brand.brandName}',
                                                               '${pro.description}',
                                                               '${pro.unitPrice}',
                                                               '${pro.stockUnit}',
                                                               '${pro.operatingSystem}',
                                                               '${pro.cpu}',
                                                               '${pro.ram}',
                                                               '${pro.monitorScale}',
                                                               '${pro.batteryVol}',
                                                               '${pro.design}',
                                                               '${pro.maintenance}',
                                                               '${pro.category.id}',
                                                               '${pro.soldUnit}',

                                                           <%--'${pro.image}'--%>
                                                               )">
                                                            ${pro.productName}
                                                    </a>
                                                </td>
                                                <td class="align-middle text-sm">${pro.category.categoryName}</td>
                                                <td class="align-middle text-sm"
                                                    style="padding-right: 30px">${pro.brand.brandName}</td>
                                                <td class="align-middle text-sm"
                                                    style="padding-right: 50px">${pro.stockUnit}</td>
                                                <td class="align-middle text-center text-sm mr-2"><i
                                                        class="bi bi-pencil-square"
                                                        style="font-size: 20px; color: deepskyblue"></i></td>
                                                <td class="align-middle text-center text-sm mr-2"><i
                                                        class="bi bi-trash2-fill"
                                                        style="font-size: 20px;color: red"></i></td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>


                            <div class="tab-pane fade profile-edit pt-3" id="profile-edit">

                                <!-- Create New Product Form -->
                                <div class="container">
                                    <form id="productForm" action="${contextPath}/admin/product-add" method="post"
                                          oninput="validateForm()">
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

<!-- Product Details Modal -->
<div class="modal fade" id="productDetailsModal" tabindex="-1" aria-labelledby="productDetailsModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="productDetailsModalLabel">Chi Tiết Sản Phẩm</h5>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-6">
                        <img id="productImage" src="" class="img-fluid" alt="Product Image">
                    </div>
                    <div class="col-md-6">
                        <p><strong>Mã sản phẩm:</strong> <span id="modalID"></span></p>
                        <p><strong>Tên sản phẩm:</strong> <span id="modalProductName"></span></p>
                        <p><strong>Danh mục:</strong> <span id="modalCategoryName"></span></p>
                        <p><strong>Hãng:</strong> <span id="modalBrandName"></span></p>
                        <p><strong>Mô tả:</strong> <span id="modalDescription"></span></p>
                        <p><strong>Đơn giá:</strong> <span id="modalUnitPrice"></span> VND</p>
                        <p><strong>Tồn kho:</strong> <span id="modalStockUnit"></span></p>
                        <p><strong>Đã bán:</strong> <span id="modalSoldUnit"></span></p>
                        <div id="technicalDetails">
                            <p><strong>Hệ điều hành:</strong> <span id="modalOS"></span></p>
                            <p><strong>CPU:</strong> <span id="modalCPU"></span></p>
                            <p><strong>RAM:</strong> <span id="modalRAM"></span></p>
                            <p><strong>Màn hình:</strong> <span id="modalScreen"></span></p>
                            <p><strong>Pin:</strong> <span id="modalBattery"></span></p>
                            <p><strong>Thiết kế:</strong> <span id="modalDesign"></span></p>
                        </div>
                        <p><strong>Bảo hành:</strong> <span id="modalWarranty"></span></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


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
<script>
    $(document).ready(function () {
        $('#myTable').DataTable({
            columnDefs: [
                {width: "50%", targets: 1} // Set width of second column (index 1) to 50%
            ]
        });
    });

    function escapeHtml(unsafe) {
        return unsafe.replace(/[&<>"'\/]/g, function (m) {
            return {
                '&': '&amp;',
                '<': '&lt;',
                '>': '&gt;',
                '"': '&quot;',
                "'": '&#39;',
                '/': '&#x2F;'
            }[m];
        });
    }

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

    function toggleFields() {
        const category = document.getElementById('productCategory').value;
        const conditionalFields = document.getElementById('conditionalFields');

        if (category === '1' || category === '2') {
            conditionalFields.style.display = 'block';
        } else {
            conditionalFields.style.display = 'none';
        }
    }


    function resetForm() {
        document.getElementById('productForm').reset();
        document.getElementById('createButton').disabled = true;
        document.getElementById('productNameError').textContent = '';
        document.getElementById('unitPriceError').textContent = '';
        document.getElementById('conditionalFields').style.display = 'none';
    }

    function removeControlCharacters(inputString) {
        // Sử dụng biểu thức chính quy để tìm và thay thế các ký tự điều khiển
        return inputString.replace(/[\x00-\x1F\x7F-\x9F]/g, '');
    }

    function removeSlash(input) {
        return input.replace(/\//g, "");
    }

    function showProductDetails(id, productName, categoryName, brandName, description, unitPrice, stockUnit, operatingSystem, cpu, ram, monitorScale, batteryVol, design, maintenance, categoryId, soldUnit) {

// Sử dụng hàm removeControlCharacters() để loại bỏ các ký tự điều khiển


        document.getElementById('modalID').innerHTML = id;
        document.getElementById('modalProductName').innerHTML = productName;
        document.getElementById('modalCategoryName').innerHTML = categoryName;
        document.getElementById('modalBrandName').innerHTML = brandName;
        document.getElementById('modalDescription').innerHTML = description;
        document.getElementById('modalUnitPrice').innerHTML = unitPrice;
        document.getElementById('modalStockUnit').innerHTML = stockUnit;
        document.getElementById('modalOS').innerHTML = operatingSystem;
        document.getElementById('modalCPU').innerHTML = cpu;
        document.getElementById('modalRAM').innerHTML = ram;
        document.getElementById('modalScreen').innerHTML = monitorScale;
        document.getElementById('modalBattery').innerHTML = batteryVol;
        document.getElementById('modalDesign').innerHTML = design;
        document.getElementById('modalWarranty').innerHTML = maintenance;
        document.getElementById('modalSoldUnit').innerHTML = soldUnit;
        console.log(description);

        // Hiển thị hoặc ẩn các trường kỹ thuật dựa trên categoryId
        const technicalDetails = document.getElementById('technicalDetails');
        if (categoryId === '1' || categoryId === '2') {
            technicalDetails.style.display = 'block';
        } else {
            technicalDetails.style.display = 'none';
        }

        var productDetailsModal = new bootstrap.Modal(document.getElementById('productDetailsModal'));
        productDetailsModal.show();
    }
</script>

</body>

</html>
