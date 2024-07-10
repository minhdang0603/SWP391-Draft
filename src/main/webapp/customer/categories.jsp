<%--
  Created by IntelliJ IDEA.
  User: MinhDang HE181967
  Date: 6/6/2024
  Time: 2:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <title>Sản phẩm</title>

    <!-- Google font -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
    <link href="${contextPath}/assets/home/img/logo1.png" rel="icon">
    <!-- Bootstrap -->
    <link type="text/css" rel="stylesheet" href="${contextPath}/assets/home/css/bootstrap.min.css"/>

    <!-- Slick -->
    <link type="text/css" rel="stylesheet" href="${contextPath}/assets/home/css/slick.css"/>
    <link type="text/css" rel="stylesheet" href="${contextPath}/assets/home/css/slick-theme.css"/>

    <!-- nouislider -->
    <link type="text/css" rel="stylesheet" href="${contextPath}/assets/home/css/nouislider.min.css"/>

    <!-- Font Awesome Icon -->
    <link rel="stylesheet" href="${contextPath}/assets/home/css/font-awesome.min.css">

    <!-- Custom stlylesheet -->
    <link type="text/css" rel="stylesheet" href="${contextPath}/assets/home/css/style.css"/>

    <link type="text/css" rel="stylesheet" href="${contextPath}/assets/css/account-toast.css">

    <style>
        #load-more-btn {
            transition: background-color 0.3s, color 0.3s, border-color 0.3s;
        }

        #load-more-btn:hover {
            background-color: #D10024;
            color: #fff;
            border-color: #D10024;
        }
    </style>
</head>
<body>
<!-- HEADER -->
<jsp:include page="../components/navbar-customer.jsp"/>
<!-- /HEADER -->

<!-- BREADCRUMB -->
<div id="breadcrumb" class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div class="row">
            <div class="col-md-12">
                <ul class="breadcrumb-tree">
                    <li><a href="home">TRANG CHỦ</a></li>
                    <li><a href="${contextPath}/store?id=0">DANH MỤC</a></li>
                    <c:if test="${thisCate != null}">
                        <li>
                            <a href="${contextPath}/store?id=${thisCate.id}">${thisCate.categoryName}</a>
                            <span class="hide category-id">${thisCate.id}</span>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /BREADCRUMB -->

<!-- SECTION -->
<div class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div class="row">
            <!-- ASIDE -->
            <div id="aside" class="col-md-3">
                <!-- aside Widget -->
                <div class="aside">
                    <h3 class="aside-title">Danh mục</h3>
                    <form class="checkbox-filter category-form" action="${contextPath}/store" method="GET">

                        <c:forEach var="category" items="${categories}">
                            <div class="input-radio">
                                <c:choose>
                                    <c:when test="${thisCate.id == category.id}">
                                        <input type="radio" name="id" checked id="category-${category.id}"
                                               value="${category.id}">
                                    </c:when>
                                    <c:otherwise>
                                        <input type="radio" name="id" id="category-${category.id}"
                                               value="${category.id}" onclick="submitForm()">
                                    </c:otherwise>
                                </c:choose>
                                <label for="category-${category.id}" class="d-flex align-items-center">
                                    <span></span>
                                        ${category.categoryName}
                                </label>
                            </div>
                        </c:forEach>
                    </form>
                </div>
                <!-- /aside Widget -->

                <!-- aside Widget -->
                <div class="aside">
                    <h3 class="aside-title">Thương hiệu</h3>
                    <div class="checkbox-filter">
                        <c:forEach var="brand" items="${brands}">
                            <div class="input-checkbox">
                                <input type="checkbox" id="brand-${brand.id}"
                                       class="brand-checkbox"/>
                                <label for="brand-${brand.id}">
                                    <span></span>
                                        ${brand.brandName}
                                </label>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <!-- /aside Widget -->
            </div>
            <!-- /ASIDE -->

            <!-- STORE -->
            <div id="store" class="col-md-9">
                <!-- store top filter -->
                <div class="store-filter clearfix">
                    <div class="store-sort">
                        <label>
                            Sắp xếp:
                            <select class="input-select">
                                <option value="0" selected>Nổi bật nhất</option>
                                <option value="1">Giá thấp -> cao</option>
                                <option value="2">Giá cao -> thấp</option>
                            </select>
                        </label>
                    </div>
                </div>
                <!-- /store top filter -->

                <!-- store products -->
                <c:set var="cnt" value="0"/>
                <div class="row product-list">
                    <!-- product -->
                    <c:forEach var="product" items="${products}">
                        <div class="col-md-4 col-xs-6">
                            <div class="product">
                                <div class="product-img">
                                    <img src="${contextPath}/assets/img/product-img/${product.image}" alt="">
                                </div>
                                <div class="product-body">
                                    <p class="product-category">${product.category.categoryName}</p>
                                    <h3 class="product-name"><a
                                            href="${contextPath}/product-detail?pid=${product.id}">${product.productName}</a>
                                    </h3>
                                    <h4 class="product-price">${product.unitPrice}</h4>
                                </div>
                                <div class="add-to-cart">
                                    <c:choose>
                                        <c:when test="${product.stockUnit == 0}">
                                            <button class="disabled-btn" disabled>
                                                <i class="fa fa-phone"></i> Liên hệ cửa hàng
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="add-to-cart-btn"
                                                    data-servlet-url="cart"
                                                    data-product-id="${product.id}"
                                                    data-action="add">
                                                <i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                        <c:set var="cnt" value="${cnt + 1}"/>
                        <c:if test="${cnt % 3 == 0}">
                            <div class="clearfix"></div>
                        </c:if>
                    </c:forEach>
                    <!-- /product -->
                </div>
                <!-- /store products -->

                <!-- store bottom filter -->
                <div class="store-filter clearfix">
                    <div class="text-center">
                        <c:choose>
                            <c:when test="${thisCate != null}">
                                <button id="load-more-btn" data-cate-id="${thisCate.id}"
                                        data-cate-name="${thisCate.categoryName}"
                                        class="btn-lg btn-outline-danger btn">
                                    Xem thêm
                                </button>
                            </c:when>
                            <c:otherwise>
                                <button id="load-more-btn" data-cate-id="0"
                                        data-cate-name="" class="btn-lg btn-outline-danger btn">
                                    Xem thêm
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <!-- /store bottom filter -->
            </div>
            <!-- /STORE -->
        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /SECTION -->

<a href="javascript:void(0);" id="back-to-top" class="btn btn-lg back-to-top" role="button"
   title="Click to return on the top page" data-toggle="tooltip" data-placement="right">
    <span class="fa fa-chevron-up"></span>
</a>
<div id="toast-container" class="toast-container"></div>

<!-- FOOTER -->
<jsp:include page="../components/footer.jsp"/>
<!-- /FOOTER -->

<!-- jQuery Plugins -->
<script src="${contextPath}/assets/home/js/jquery.min.js"></script>
<script src="${contextPath}/assets/home/js/bootstrap.min.js"></script>
<script src="${contextPath}/assets/home/js/slick.min.js"></script>
<script src="${contextPath}/assets/home/js/nouislider.min.js"></script>
<script src="${contextPath}/assets/home/js/jquery.zoom.min.js"></script>
<script src="${contextPath}/assets/home/js/main.js"></script>
<script src="${contextPath}/assets/js/main.js"></script>
<script src="${contextPath}/assets/js/back-to-top-button.js"></script>
<script src="${contextPath}/assets/js/category.js"></script>

</body>
</html>
