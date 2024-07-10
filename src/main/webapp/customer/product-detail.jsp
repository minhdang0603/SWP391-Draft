<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <title>${proDetail.productName}</title>

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

    <!-- Custom stlylesheet -->
    <link type="text/css" rel="stylesheet" href="${contextPath}/assets/css/account-toast.css"/>

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

<div id="toast-container" class="toast-container"></div>

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
                    <li>
                        <a href="${contextPath}/store?id=${proDetail.category.id}">${proDetail.category.categoryName}</a>
                    </li>
                    <li class="active">${proDetail.productName}</li>
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
            <!-- Product main img -->
            <div class=" col-lg-4 col-md-5">
                <div id="product-main-img">
                    <div class="product-preview">
                        <img src="${contextPath}/assets/img/product-img/${proDetail.image}" alt="">
                    </div>
                </div>
            </div>
            <!-- /Product main img -->


            <!-- Product details -->
            <div class="col-lg-6 col-md-6 col-md-push-1">
                <div class="product-details product-cart">
                    <h2 class="product-name">${proDetail.productName}</h2>
                    <div>
                        <div class="product-rating" data-average-rating="${averageRating}">
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star-o"></i>
                        </div>
                        <a class="review-link" data-toggle="tab" href="#tab3">${!ratings.isEmpty() ? ratings.size() : 0}
                            Đánh giá | Thêm đánh giá</a>
                    </div>
                    <div>
                        <h3 class="product-price" id="formattedMoney">${proDetail.unitPrice}</h3>
                    </div>
                    <p>${proDetail.description}</p>
                    <div class="add-to-cart">
                        <c:choose>
                            <c:when test="${proDetail.stockUnit == 0}">
                                <button class="disabled-btn" disabled>
                                    <i class="fa fa-phone"></i> Liên hệ cửa hàng
                                </button>
                            </c:when>
                            <c:otherwise>
                                <button class="add-to-cart-btn"
                                        data-servlet-url="cart"
                                        data-product-id="${proDetail.id}"
                                        data-action="add">
                                    <i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <ul class="product-links">
                        <li>DANH MỤC</li>
                        <li>
                            <a href="${contextPath}/store?id=${proDetail.category.id}">${proDetail.category.categoryName}</a>
                        </li>
                    </ul>
                    <ul class="product-links">
                        <li>NHÀ SẢN XUẤT:</li>
                        <li>${proDetail.brand.brandName}</li>
                    </ul>
                    <ul class="product-links">
                        <li>THỜI GIAN BẢO HÀNH</li>
                        <li>${proDetail.maintenance}</li>
                    </ul>

                </div>
            </div>
            <!-- /Product details -->

            <!-- Product tab -->
            <div class="col-md-12">
                <div id="product-tab">
                    <!-- product tab nav -->
                    <ul class="tab-nav">
                        <c:if test="${proDetail.category.categoryName == 'Laptop'}">
                            <li><a data-toggle="tab" href="#tab2">Chi tiết</a></li>
                        </c:if>
                        <li><a data-toggle="tab" href="#tab3">Phản hồi</a></li>
                    </ul>
                    <!-- /product tab nav -->

                    <!-- product tab content -->
                    <div class="tab-content">
                        <!-- tab2  -->
                        <div id="tab2" class="tab-pane fade in">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="container">
                                        <h2 class="text-center">Thông Số Kỹ Thuật</h2>
                                        <table class="table table-bordered">
                                            <thead>
                                            <tr>
                                                <th>Thông Số</th>
                                                <th>Chi Tiết</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr>
                                                <td>CPU</td>
                                                <td>${proDetail.cpu}</td>
                                            </tr>
                                            <tr>
                                                <td>RAM</td>
                                                <td>${proDetail.ram}</td>
                                            </tr>
                                            <tr>
                                                <td>Hệ điều hành</td>
                                                <td>${proDetail.operatingSystem}</td>
                                            </tr>
                                            <tr>
                                                <td>Dung lượng pin</td>
                                                <td>${proDetail.batteryVol}</td>
                                            </tr>
                                            <tr>
                                                <td>Màn hình</td>
                                                <td>${proDetail.monitorScale}</td>
                                            </tr>
                                            <tr>
                                                <td>Thiết kế</td>
                                                <td>${proDetail.design}</td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /tab2  -->

                        <!-- tab3  -->
                        <div id="tab3" class="tab-pane fade in">
                            <div class="row">
                                <!-- Rating -->
                                <div class="col-md-3">
                                    <div id="rating">
                                        <div class="rating-avg">
                                            <span id="avg-rating">${averageRating}</span>
                                            <div class="rating-stars" id="avg-stars">
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star-o"></i>
                                            </div>
                                        </div>
                                        <ul class="rating">
                                            <li data-rating="5">
                                                <div class="rating-stars">
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                </div>
                                                <div class="rating-progress">
                                                    <div style="width: 0%;"></div>
                                                </div>
                                                <span class="sum">${fiveStar}</span>
                                            </li>
                                            <li data-rating="4">
                                                <div class="rating-stars">
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star-o"></i>
                                                </div>
                                                <div class="rating-progress">
                                                    <div style="width: 0%;"></div>
                                                </div>
                                                <span class="sum">${fourStar}</span>
                                            </li>
                                            <li data-rating="3">
                                                <div class="rating-stars">
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star-o"></i>
                                                    <i class="fa fa-star-o"></i>
                                                </div>
                                                <div class="rating-progress">
                                                    <div style="width: 0%;"></div>
                                                </div>
                                                <span class="sum">${threeStar}</span>
                                            </li>
                                            <li data-rating="2">
                                                <div class="rating-stars">
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star-o"></i>
                                                    <i class="fa fa-star-o"></i>
                                                    <i class="fa fa-star-o"></i>
                                                </div>
                                                <div class="rating-progress">
                                                    <div style="width: 0%;"></div>
                                                </div>
                                                <span class="sum">${twoStar}</span>
                                            </li>
                                            <li data-rating="1">
                                                <div class="rating-stars">
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star-o"></i>
                                                    <i class="fa fa-star-o"></i>
                                                    <i class="fa fa-star-o"></i>
                                                    <i class="fa fa-star-o"></i>
                                                </div>
                                                <div class="rating-progress">
                                                    <div style="width: 0%;"></div>
                                                </div>
                                                <span class="sum">${oneStar}</span>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <!-- /Rating -->

                                <!-- Reviews -->
                                <div class="col-md-9">
                                    <div id="reviews">
                                        <c:choose>
                                            <c:when test="${ratings.isEmpty()}">
                                                <div class="text-center text-muted" style="font-weight: bold; font-size: 16px;">Chưa có đánh giá</div>
                                            </c:when>
                                            <c:otherwise>
                                                <ul class="reviews">
                                                    <c:forEach var="rating" items="${ratings}">
                                                        <li>
                                                            <div class="review-heading">
                                                                <h5 class="name">${rating.user.userName}</h5>
                                                                <p class="date">${rating.getFormattedCreateTime()}</p>
                                                                <div class="review-rating-${rating.id} review-rating"
                                                                     data-rating-score="${rating.ratingScore}">
                                                                    <i class="fa fa-star"></i>
                                                                    <i class="fa fa-star"></i>
                                                                    <i class="fa fa-star"></i>
                                                                    <i class="fa fa-star"></i>
                                                                    <i class="fa fa-star-o empty"></i>
                                                                </div>
                                                            </div>
                                                            <div class="review-body">
                                                                <p>${rating.content}</p>
                                                            </div>
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <!-- /Reviews -->
                            </div>
                        </div>
                        <!-- /tab3  -->
                    </div>
                    <!-- /product tab content  -->
                </div>
            </div>
            <!-- /product tab -->
        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /SECTION -->

<!-- Section -->
<div class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div class="row">

            <div class="col-md-12">
                <div class="section-title text-center">
                    <h3 class="title">Sản Phẩm Tương Tự</h3>
                </div>
            </div>

            <!-- product -->
            <c:forEach items="${relatedProducts}" var="related">
                <div class="col-md-3 col-xs-6">
                    <div class="product">
                        <div class="product-img">
                            <img src="${contextPath}/assets/img/product-img/${related.image}" alt="">
                        </div>
                        <div class="product-body">
                            <p class="product-category">${related.category.categoryName}</p>
                            <h3 class="product-name"><a
                                    href="${contextPath}/product-detail?pid=${related.id}">${related.productName}</a>
                            </h3>
                            <h4 class="product-price">
                                    ${related.unitPrice}
                            </h4>
                        </div>
                        <div class="add-to-cart">
                            <c:choose>
                                <c:when test="${related.stockUnit == 0}">
                                    <button class="disabled-btn" disabled>
                                        <i class="fa fa-phone"></i> Liên hệ cửa hàng
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <button class="add-to-cart-btn"
                                            data-servlet-url="cart"
                                            data-product-id="${related.id}"
                                            data-action="add">
                                        <i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <!-- /product -->

            <div class="clearfix visible-sm visible-xs"></div>

        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /Section -->


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
<script src="${contextPath}/assets/js/add-to-cart.js"></script>
<script src="${contextPath}/assets/js/product-detail.js"></script>

</body>
</html>
