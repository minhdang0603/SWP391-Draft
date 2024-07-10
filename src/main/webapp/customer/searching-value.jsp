<%--
  Created by IntelliJ IDEA.
  User: MinhDang HE181967
  Date: 6/23/2024
  Time: 11:42 AM
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

    <title>LaptopTG Store</title>

    <!-- Google font -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

    <!-- Bootstrap -->
    <link type="text/css" rel="stylesheet" href="${contextPath}/assets/home/css/bootstrap.min.css"/>
    <link href="${contextPath}/assets/home/img/logo1.png" rel="icon">
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
        .no-result{
            margin: 50px 0px;
            text-align: center;
        }

        .no-result img{
            width: 180px;
            height: 180px;
        }

        .no-result p {
            font-size: 18px;
            font-weight: bold;
            color: #4f5867;
        }

        .text-h3 {
            font-weight: normal;
            font-size: 30px;
        }

        .text-h3 span {
            font-weight: 500;
            font-style: italic;
        }
    </style>
</head>
<body>
<!-- HEADER -->
<jsp:include page="../components/navbar-customer.jsp"/>
<!-- /HEADER -->

<!-- BREADCRUMB -->
<jsp:include page="../components/navigation.jsp"/>
<!-- /BREADCRUMB -->

<!-- SECTION -->
<div class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div class="row">
            <div>
                <h1 class="text-h3">Kết quả tìm kiếm cho <span>"${keyword}"</span></h1>
                <p class="mt-2 text-md">Tìm thấy ${products.isEmpty() ? 0 : products.size()} sản phẩm</p>
            </div>
            <!-- store products -->
            <div class="row product-list">
                <c:choose>
                    <c:when test="${products.isEmpty()}">
                        <div class="no-result">
                            <img src="https://frontend.tikicdn.com/_desktop-next/static/img/account/empty-order.png"
                                 class="no-order-img">
                            <p>Không có kết quả</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- product -->
                        <c:set var="cnt" value="0"/>
                        <c:forEach var="product" items="${products}">
                            <div class="col-md-3 col-xs-6">
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
                            <c:if test="${cnt % 4 == 0}">
                                <div class="clearfix"></div>
                            </c:if>
                        </c:forEach>
                        <!-- /product -->
                    </c:otherwise>
                </c:choose>
            </div>
            <!-- /store products -->
        </div>
        <!-- /STORE -->
    </div>
    <!-- /row -->
</div>
<!-- /container -->
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
