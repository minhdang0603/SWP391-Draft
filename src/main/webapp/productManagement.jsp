<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 6/4/2024
  Time: 8:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="apple-touch-icon" sizes="76x76" href="assets/admin/img/apple-icon.png">
    <link rel="icon" type="image/png" href="assets/admin/img/favicon.png">
    <title>
        Product Management
    </title>
    <!--     Fonts and icons     -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet"/>
    <!-- Nucleo Icons -->
    <link href="assets/admin/css/nucleo-icons.css" rel="stylesheet"/>
    <link href="assets/admin/css/nucleo-svg.css" rel="stylesheet"/>
    <!-- Font Awesome Icons -->
    <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
    <link href="assets/admin/css/nucleo-svg.css" rel="stylesheet"/>
    <!-- CSS Files -->
    <link id="pagestyle" href="assets/admin/css/argon-dashboard.css?v=2.0.4" rel="stylesheet"/>
    <link href="https://cdn.datatables.net/v/bs5/jq-3.7.0/dt-2.0.8/sc-2.4.3/datatables.css" rel="stylesheet">
</head>

<body class="g-sidenav-show   bg-gray-100">
<div class="min-height-300 bg-primary position-absolute w-100"></div>
<aside
        class="sidenav bg-white navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 fixed-start ms-4 "
        id="sidenav-main">
    <div class="sidenav-header">
        <i class="fas fa-times p-3 cursor-pointer text-secondary opacity-5 position-absolute end-0 top-0 d-none d-xl-none"
           aria-hidden="true" id="iconSidenav"></i>
        <a class="navbar-brand m-0" href=" ../pages/dashboard.html " target="_blank">
            <img src="assets/admin/img/logo-ct-dark.png" class="navbar-brand-img h-100" alt="main_logo">
            <span class="ms-1 font-weight-bold">Admin</span>
        </a>
    </div>
    <hr class="horizontal dark mt-0">
    <div class="collapse navbar-collapse  w-auto " id="sidenav-collapse-main">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link " href="../pages/dashboard.html">
                    <div
                            class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="ni ni-tv-2 text-primary text-sm opacity-10"></i>
                    </div>
                    <span class="nav-link-text ms-1">Dashboard</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link " href="../pages/salemanagement.html">
                    <div
                            class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="ni ni-money-coins text-warning text-sm opacity-10"></i>
                    </div>
                    <span class="nav-link-text ms-1">Sales</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link " href="../pages/accountmanagement.html">
                    <div
                            class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="ni ni-world-2 text-warning text-sm opacity-10"></i>
                    </div>
                    <span class="nav-link-text ms-1">Account Management</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link " href="../pages/productmanagement.html">
                    <div
                            class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="ni ni-cart text-warning text-sm opacity-10"></i>
                    </div>
                    <span class="nav-link-text ms-1">Product Management</span>
                </a>
            </li>
        </ul>
    </div>
</aside>
<main class="main-content position-relative border-radius-lg ">
    <!-- Navbar -->
    <nav class="navbar navbar-main navbar-expand-lg px-0 mx-4 shadow-none border-radius-xl " id="navbarBlur"
         data-scroll="false">
        <div class="container-fluid py-1 px-3">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb bg-transparent mb-0 pb-0 pt-1 px-0 me-sm-6 me-5">
                    <li class="breadcrumb-item text-sm"><a class="opacity-5 text-white"
                                                           href="javascript:;">Pages</a></li>
                    <li class="breadcrumb-item text-sm text-white active" aria-current="page">Product Management
                    </li>
                </ol>
                <h6 class="font-weight-bolder text-white mb-0">Product Management</h6>
            </nav>
            <div class="collapse navbar-collapse mt-sm-0 mt-2 me-md-0 me-sm-4" id="navbar">
                <div class="ms-md-auto pe-md-3 d-flex align-items-center">
                    <div class="input-group">
                            <span class="input-group-text text-body"><i class="fas fa-search"
                                                                        aria-hidden="true"></i></span>
                        <input type="text" class="form-control" placeholder="Type here...">
                    </div>
                </div>
                <ul class="navbar-nav  justify-content-end">
                    <li class="nav-item d-flex align-items-center">
                        <a href="javascript:;" class="nav-link text-white font-weight-bold px-0">
                            <i class="fa fa-user me-sm-1"></i>
                            <span class="d-sm-inline d-none">Sign In</span>
                        </a>
                    </li>
                    <li class="nav-item d-xl-none ps-3 d-flex align-items-center">
                        <a href="javascript:;" class="nav-link text-white p-0" id="iconNavbarSidenav">
                            <div class="sidenav-toggler-inner">
                                <i class="sidenav-toggler-line bg-white"></i>
                                <i class="sidenav-toggler-line bg-white"></i>
                                <i class="sidenav-toggler-line bg-white"></i>
                            </div>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <!-- End Navbar -->
    <div class="container-fluid py-4">
        <div class="row">
            <div class="col-12">
                <div class="card mb-4">
                    <div class="card-header pb-0">
                        <h6>Product Management</h6>
                    </div>
                    <div class="d-flex">
                        <a href="#" class="btn btn-sm btn-info mb-0 d-none d-lg-block" data-bs-toggle="modal"
                           data-bs-target="#addBookModal" style="margin: 0 auto;">Add Book</a>
                    </div>
                    <div class="card-body px-0 pt-0 pb-2">
                        <div class="table-responsive p-0">
                            <table id="myTable" class="table-responsive table-striped datatable align-items-center mb-0">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Sản Phẩm</th>
                                    <th>Danh Mục</th>
                                    <th scope="col">Hãng</th>
                                    <th>Tồn Kho</th>
                                    <th>Sửa</th>
                                    <th>Xóa</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="pro" items="${list}">
                                    <tr>
                                        <td>${pro.id}</td>
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
                </div>
            </div>
        </div>
    </div>

    <!-- pop up add book -->
    <div class="modal fade" id="addBookModal" tabindex="-1" aria-labelledby="addBookModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addBookModalLabel">Add New Book</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- Form fields go here -->
                    <form>
                        <div class="mb-3">
                            <label for="bookName" class="form-label">Name</label>
                            <input type="text" class="form-control" id="bookName" aria-describedby="bookNameHelp">
                        </div>
                        <div class="mb-3">
                            <label for="bookDescription" class="form-label">Description</label>
                            <textarea class="form-control" id="bookDescription" rows="3"></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="bookPublishedDate" class="form-label">Published Date</label>
                            <input type="date" class="form-control" id="bookPublishedDate">
                        </div>
                        <div class="mb-3">
                            <label for="bookAuthorName" class="form-label">Author Name</label>
                            <input type="text" class="form-control" id="bookAuthorName">
                        </div>
                        <div class="mb-3">
                            <label for="bookCategoryName" class="form-label">Category Name</label>
                            <input type="text" class="form-control" id="bookCategoryName">
                        </div>
                        <div class="mb-3">
                            <label for="bookNumberOfPages" class="form-label">Number of Pages</label>
                            <input type="number" class="form-control" id="bookNumberOfPages">
                        </div>
                        <div class="mb-3">
                            <label for="bookPrice" class="form-label">Price</label>
                            <input type="number" class="form-control" id="bookPrice">
                        </div>
                        <div class="mb-3">
                            <label for="bookSummary" class="form-label">Summary</label>
                            <textarea class="form-control" id="bookSummary" rows="3"></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save Book</button>
                </div>
            </div>
        </div>
    </div>

    <!-- popup view book -->
    <div class="modal fade" id="bookModal" tabindex="-1" aria-labelledby="bookModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="bookModalLabel">Book Details</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="mb-3">
                            <label for="name" class="form-label">Name</label>
                            <input type="text" class="form-control" id="name" value="Name" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" id="description" rows="3" readonly>Description</textarea>
                        </div>
                        <div class="mb-3">
                            <label for="publishedDate" class="form-label">Published Date</label>
                            <input type="text" class="form-control" id="publishedDate" value="Published Date"
                                   readonly>
                        </div>
                        <div class="mb-3">
                            <label for="authorName" class="form-label">Author Name</label>
                            <input type="text" class="form-control" id="authorName" value="Author Name" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="categoryName" class="form-label">Category Name</label>
                            <input type="text" class="form-control" id="categoryName" value="Category Name"
                                   readonly>
                        </div>
                        <div class="mb-3">
                            <label for="numOfPages" class="form-label">Number of Pages</label>
                            <input type="text" class="form-control" id="numOfPages" value="200" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="price" class="form-label">Price</label>
                            <input type="text" class="form-control" id="price" value="100000" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="summary" class="form-label">Summary</label>
                            <textarea class="form-control" id="summary" rows="3" readonly>Summary</textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- popup Update book -->
    <div class="modal fade" id="productModal" tabindex="-1" aria-labelledby="productModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="productModalLabel">Update Product</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="mb-3">
                            <label for="name" class="form-label">Name</label>
                            <input type="text" class="form-control" id="name" aria-describedby="nameHelp"
                                   placeholder="Enter name">
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" id="description" rows="3"
                                      placeholder="Enter description"></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="publishedDate" class="form-label">Published Date</label>
                            <input type="date" class="form-control" id="publishedDate">
                        </div>
                        <div class="mb-3">
                            <label for="authorName" class="form-label">Author Name</label>
                            <input type="text" class="form-control" id="authorName" placeholder="Enter author name">
                        </div>
                        <div class="mb-3">
                            <label for="categoryName" class="form-label">Category Name</label>
                            <input type="text" class="form-control" id="categoryName"
                                   placeholder="Enter category name">
                        </div>
                        <div class="mb-3">
                            <label for="numberOfPages" class="form-label">Number of Pages</label>
                            <input type="number" class="form-control" id="numberOfPages"
                                   placeholder="Enter number of pages">
                        </div>
                        <div class="mb-3">
                            <label for="price" class="form-label">Price</label>
                            <input type="number" class="form-control" id="price" placeholder="Enter price">
                        </div>
                        <div class="mb-3">
                            <label for="summary" class="form-label">Summary</label>
                            <textarea class="form-control" id="summary" rows="3"
                                      placeholder="Enter summary"></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save</button>
                </div>
            </div>
        </div>
    </div>

</main>
<!--   Core JS Files   -->
<script src="assets/admin/js/core/popper.min.js"></script>
<script src="assets/admin/js/core/bootstrap.min.js"></script>
<script src="assets/admin/js/plugins/perfect-scrollbar.min.js"></script>
<script src="assets/admin/js/plugins/smooth-scrollbar.min.js"></script>
<!-- Github buttons -->
<script async defer src="https://buttons.github.io/buttons.js"></script>
<!-- Control Center for Soft Dashboard: parallax effects, scripts for the example pages etc -->
<script src="assets/admin/js/argon-dashboard.min.js?v=2.0.4"></script>

<!-- Delete -->
<script>
    function confirmDelete(deleteUrl) {
        if (confirm("Are you sure you want to delete?")) {
            window.location.href = deleteUrl;
        }
    }
</script>
<script src="https://cdn.datatables.net/v/bs5/jq-3.7.0/dt-2.0.8/sc-2.4.3/datatables.js"></script>

<script>
    new DataTable('#myTable');
</script>
</body>

</html>
