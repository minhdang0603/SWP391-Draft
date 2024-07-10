<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags must come first in the head; any other head content must come after these tags -->

    <title>LaptopTG Store</title>
    <link href="${contextPath}/assets/home/img/logo1.png" rel="icon">
    <!-- Google font -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

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


    <!-- Custom stlylesheet -->
    <link type="text/css" rel="stylesheet" href="${contextPath}/assets/css/account-toast.css"/>

</head>
<body>

<!-- HEADER -->
<jsp:include page="../components/navbar-customer.jsp"/>
<!-- /HEADER -->

<!-- NAVIGATION -->
<jsp:include page="../components/navigation.jsp"/>
<!-- /NAVIGATION -->

<!-- SECTION -->
<div class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div class="row">
            <!-- shop -->
            <div class="col-md-4 col-xs-6">
                <div class="shop">
                    <div class="shop-img">
                        <img src="${contextPath}/assets/home/img/shop01.png" alt="">
                    </div>
                    <div class="shop-body">
                        <h3>Laptop</h3>
                        <a href="${contextPath}/store?id=1" class="cta-btn">Mua sắm ngay <i
                                class="fa fa-arrow-circle-right"></i></a>
                    </div>
                </div>
            </div>
            <!-- /shop -->

            <!-- shop -->
            <div class="col-md-4 col-xs-6">
                <div class="shop">
                    <div class="shop-img">
                        <img src="${contextPath}/assets/home/img/shop03.png" alt="">
                    </div>
                    <div class="shop-body">
                        <h3>Thiết bị<br>Nghe nhìn</h3>
                        <a href="${contextPath}/store?id=3" class="cta-btn">Mua sắm ngay <i
                                class="fa fa-arrow-circle-right"></i></a>
                    </div>
                </div>
            </div>
            <!-- /shop -->

            <!-- shop -->
            <div class="col-md-4 col-xs-6">
                <div class="shop">
                    <div class="shop-img">
                        <img src="${contextPath}/assets/home/img/shop02.png" alt="">
                    </div>
                    <div class="shop-body">
                        <h3>Cameras</h3>
                        <a href="${contextPath}/store?id=7" class="cta-btn">Mua sắm ngay <i
                                class="fa fa-arrow-circle-right"></i></a>
                    </div>
                </div>
            </div>
            <!-- /shop -->
        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /SECTION -->


<!-- SECTION -->
<div class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div class="row">

            <!-- section title -->
            <div class="col-md-12">
                <div class="section-title">
                    <h3 class="title">Sản phẩm bán chạy</h3>
                </div>
            </div>
            <!-- /section title -->

            <!-- Products tab & slick -->
            <div class="col-md-12">
                <div class="row">
                    <div class="products-tabs">
                        <!-- tab -->
                        <div id="tab2" class="tab-pane fade in active">
                            <div class="products-slick" data-nav="#slick-nav">
                                <!-- Iterate over the product list -->
                                <c:forEach var="product" items="${listSoldUnit}">
                                    <div class="product">
                                        <div class="product-img">
                                            <img src="${pageContext.request.contextPath}/assets/img/product-img/${product.image}"
                                                 alt="">
                                        </div>
                                        <div class="product-body">
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

                                </c:forEach>

                            </div>
                            <div id="slick-nav" class="products-slick-nav"></div>
                        </div>
                        <!-- /tab -->
                    </div>
                </div>
            </div>
            <!-- /Products tab & slick -->
        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /SECTION -->
<c:forEach var="listP" items="${list}">
    <!-- SECTION -->
    <div class="section">
        <!-- container -->
        <div class="container">
            <!-- row -->
            <div class="row">
                <!-- section title -->
                <div class="col-md-12">
                    <div class="section-title">
                        <h3 class="title">${listP.get(0).category.categoryName}</h3>
                        <div class="section-nav">
                            <ul class="section-tab-nav tab-nav">
                                <li><a data-toggle="tab" href="categories">Xem Tất Cả</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- /section title -->


                <div class="col-md-12">
                    <div class="row">
                        <div class="products-slick" data-nav="#slick-nav-${listP.get(0).category.id}">
                            <c:forEach var="product" items="${listP}">
                                <div class="product product-cart">
                                    <div class="product-img">
                                        <img src="${contextPath}/assets/img/product-img/${product.image}"
                                             alt="">
                                    </div>
                                    <div class="product-body">

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
                                <!-- /product -->
                            </c:forEach>
                        </div>
                        <div class="clearfix visible-sm visible-xs"></div>

                        <div id="slick-nav-${listP.get(0).category.id}" class="products-slick-nav"></div>
                    </div>
                </div>
                <!-- row -->
            </div>

            <!-- /container -->

        </div>
        <!-- /SECTION -->
    </div>
</c:forEach>
<!-- Back to Top Button -->
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
<script src="${contextPath}/assets/js/back-to-top-button.js"></script>
<script src="${contextPath}/assets/home/js/main.js"></script>
<script src="${contextPath}/assets/js/main.js"></script>
<script src="${contextPath}/assets/js/add-to-cart.js"></script>
<script>
    // Hàm định dạng số tiền VND
    function formatVND(n) {
        return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + ' đ';
    }

    // Iterate over each product to format the price
    document.querySelectorAll('.product-price').forEach(function (element) {
        var price = parseFloat(element.textContent.replace(/[^\d.-]/g, '')); // Extract the numerical value from the price element
        element.textContent = formatVND(price); // Format the price and set it back to the element
    });
</script>

</body>
</html>