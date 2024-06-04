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

    <style>
        .dropdown-menu {
            border-radius: 4px;
            padding: 10px 0;
            animation-name: dropdown-animate;
            animation-duration: 0.2s;
            animation-fill-mode: both;
            border: 0;
            box-shadow: 0 5px 30px 0 rgba(82, 63, 105, 0.2);
        }

        .dropdown-menu .dropdown-header,
        .dropdown-menu .dropdown-footer {
            text-align: center;
            font-size: 15px;
            padding: 10px 25px;
        }

        .dropdown-menu .dropdown-footer a {
            color: #444444;
            text-decoration: underline;
        }

        .dropdown-menu .dropdown-footer a:hover {
            text-decoration: none;
        }

        .dropdown-menu .dropdown-divider {
            color: #a5c5fe;
            margin: 0;
        }

        .dropdown-menu .dropdown-item {
            font-size: 14px;
            padding: 10px 15px;
            transition: 0.3s;
        }

        .dropdown-menu .dropdown-item i {
            margin-right: 10px;
            font-size: 18px;
            line-height: 0;
        }

        .dropdown-menu .dropdown-item:hover {
            background-color: #f6f9ff;
        }

        @media (min-width: 768px) {
            .dropdown-menu-arrow::before {
                content: "";
                width: 13px;
                height: 13px;
                background: #fff;
                position: absolute;
                top: -7px;
                right: 20px;
                transform: rotate(45deg);
                border-top: 1px solid #eaedf1;
                border-left: 1px solid #eaedf1;
            }
        }

        @keyframes dropdown-animate {
            0% {
                opacity: 0;
            }

            100% {
                opacity: 1;
            }

            0% {
                opacity: 0;
            }
        }
    </style>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<body>
<!-- HEADER -->
<jsp:include page="../components/navbar-customer.jsp"/>
<!-- /HEADER -->

<!-- NAVIGATION -->
<nav id="navigation">
    <!-- container -->
    <div class="container">
        <!-- responsive-nav -->
        <div id="responsive-nav">
            <!-- NAV -->
            <ul class="main-nav nav navbar-nav">
                <li class="active"><a href="#">Home</a></li>
                <li><a href="#">Categories</a></li>
                <li><a href="#">Laptops</a></li>
                <li><a href="#">Cameras</a></li>
                <li><a href="#">Accessories</a></li>
            </ul>
            <!-- /NAV -->
        </div>
        <!-- /responsive-nav -->
    </div>
    <!-- /container -->
</nav>
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
                        <img src="assets/home/img/shop01.png" alt="">
                    </div>
                    <div class="shop-body">
                        <h3>Laptop<br>Collection</h3>
                        <a href="#" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
                    </div>
                </div>
            </div>
            <!-- /shop -->

            <!-- shop -->
            <div class="col-md-4 col-xs-6">
                <div class="shop">
                    <div class="shop-img">
                        <img src="assets/home/img/shop03.png" alt="">
                    </div>
                    <div class="shop-body">
                        <h3>Accessories<br>Collection</h3>
                        <a href="#" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
                    </div>
                </div>
            </div>
            <!-- /shop -->

            <!-- shop -->
            <div class="col-md-4 col-xs-6">
                <div class="shop">
                    <div class="shop-img">
                        <img src="assets/home/img/shop02.png" alt="">
                    </div>
                    <div class="shop-body">
                        <h3>Cameras<br>Collection</h3>
                        <a href="#" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
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
                    <h3 class="title">Top selling</h3>
                    <div class="section-nav">
                        <ul class="section-tab-nav tab-nav">
                            <li class="active"><a data-toggle="tab" href="#tab2">Laptops</a></li>
                            <li><a data-toggle="tab" href="#tab2">Cameras</a></li>
                            <li><a data-toggle="tab" href="#tab2">Accessories</a></li>
                        </ul>
                    </div>
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
                                            <h3 class="product-name"><a href="#">${product.productName}</a></h3>
                                            <h4 class="product-price">${product.unitPrice}</h4>
                                            <div class="product-btns">
                                                <button class="add-to-wishlist"><i class="fa fa-heart-o"></i><span
                                                        class="tooltipp">add to wishlist</span></button>
                                                <button class="add-to-compare"><i class="fa fa-exchange"></i><span
                                                        class="tooltipp">add to compare</span></button>
                                                <button class="quick-view"><i class="fa fa-eye"></i><span
                                                        class="tooltipp">quick view</span></button>
                                            </div>
                                        </div>
                                        <div class="add-to-cart">
                                            <a href="${contextPath}/cart?id=${product.id}&action=add">
                                                <button class="add-to-cart-btn"
                                                        data-servlet-url="cart"
                                                        data-product-id="${product.id}"
                                                        data-action="add">
                                                    <i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng
                                                </button>
                                            </a>
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
                        <div class="products-slick" data-nav="#slick-nav-2">
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
                                        <h4 class="product-price" id="price-${product.id}">${product.unitPrice}</h4>
                                        <div class="product-rating">
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                        </div>
                                    </div>
                                    <div class="add-to-cart">
                                            <%--                                        <a href="${contextPath}/cart?id=${product.id}&action=add">--%>
                                        <button class="add-to-cart-btn"
                                                data-servlet-url="cart"
                                                data-product-id="${product.id}"
                                                data-action="add">
                                            <i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng
                                        </button>
                                            <%--                                        </a>--%>
                                    </div>
                                </div>
                                <!-- /product -->
                            </c:forEach>
                        </div>
                        <div id="slick-nav-2" class="products-slick-nav"></div>
                            <%--                    <div class="clearfix visible-sm visible-xs"></div>--%>

                    </div>
                    <!-- /store products -->
                        <%--                <div class="btn-load">--%>
                        <%--                    <button onclick="loadMore()" class="btn btn-primary">Load More</button>--%>
                        <%--                </div>--%>
                </div>
                <!-- row -->
            </div>

            <!-- /container -->

        </div>
        <!-- /SECTION -->
    </div>
</c:forEach>

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
<script src="${contextPath}/assets/js/add-to-cart.js"></script>
<script>
    // Hàm định dạng số tiền VND
    function formatVND(n) {
        return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".") + ' đ';
    }

    // Iterate over each product to format the price
    <c:forEach var="listP" items="${list}">
    <c:forEach var="product" items="${listP}">
    document.getElementById("price-${product.id}").innerText = formatVND(${product.unitPrice});
    </c:forEach>
    </c:forEach>
</script>
<%--<script>--%>
<%--    function loadMore() {--%>
<%--        var amount = document.getElementsByClassName("product").length;--%>
<%--        $.ajax({--%>
<%--            url: "/laptop_tg/load",--%>
<%--            type: "get",--%>
<%--            data: {--%>
<%--                exits: amount--%>
<%--            },--%>
<%--            success: function (data) {--%>
<%--                var row = document.getElementById("content");--%>
<%--                row.innerHTML += data;--%>
<%--            },--%>
<%--            error: function (xhr) {--%>

<%--            }--%>
<%--        });--%>
<%--    }--%>
<%--</script>--%>

</body>
</html>