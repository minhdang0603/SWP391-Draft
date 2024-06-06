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
                        <li><a href="${contextPath}/store?id=${thisCate.id}">${thisCate.categoryName}</a></li>
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
                    <h3 class="aside-title">Categories</h3>
                    <div class="checkbox-filter">

                        <c:forEach var="category" items="${categories}">
                            <div class="input-radio">
                                <input type="checkbox" id="category-${category.id}">
                                <label for="category-${category.id}">
                                    <span></span>
                                        ${category.categoryName}
                                </label>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <!-- /aside Widget -->

                <!-- aside Widget -->
                <div class="aside">
                    <h3 class="aside-title">Price</h3>
                    <div class="price-filter">
                        <div id="price-slider"></div>
                        <div class="input-number price-min">
                            <input id="price-min" type="number">
                            <span class="qty-up">+</span>
                            <span class="qty-down">-</span>
                        </div>
                        <span>-</span>
                        <div class="input-number price-max">
                            <input id="price-max" type="number">
                            <span class="qty-up">+</span>
                            <span class="qty-down">-</span>
                        </div>
                    </div>
                </div>
                <!-- /aside Widget -->

                <!-- aside Widget -->
                <div class="aside">
                    <h3 class="aside-title">Brand</h3>
                    <div class="checkbox-filter">
                        <c:forEach var="brand" items="${brands}">
                            <div class="input-checkbox">
                                <input type="checkbox" id="brand-${brand.id}">
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
                            Sort By:
                            <select class="input-select">
                                <option value="0">Popular</option>
                                <option value="1">Position</option>
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
                                    <h4 class="product-price price-${product.id}">${product.unitPrice}</h4>
                                    <div class="product-rating">
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                    </div>
                                </div>
                                <div class="add-to-cart">
                                    <button class="add-to-cart-btn"
                                            data-servlet-url="cart"
                                            data-product-id="${product.id}"
                                            data-action="add">
                                        <i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng
                                    </button>
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
                <c:if test="${cnt >= 9}">
                    <div class="store-filter clearfix">
                        <div class="text-center">
                            <c:choose>
                                <c:when test="${thisCate != null}">
                                    <button id="load-more-btn" data-cate-id="${thisCate.id}"
                                            data-cate-name="${thisCate.categoryName}" class="btn-lg btn-outline-danger">
                                        Xem thêm
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <button id="load-more-btn" data-cate-id="0"
                                            data-cate-name="" class="btn-lg btn-outline-danger">
                                        Xem thêm
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:if>
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
<script>

    function updateCheckCart(cartCount) {
        let checkCart = document.querySelector('.check-cart');
        if (!checkCart) {
            // Create the check-cart element if it does not exist
            checkCart = document.createElement('div');
            checkCart.className = 'qty check-cart';
            // Find the container where it should be appended, e.g., a parent div
            let parentElement = document.querySelector('.cart-container'); // Adjust this selector as needed
            parentElement.appendChild(checkCart);
        }
        checkCart.textContent = cartCount;
    }

    function showToast(message) {
        const toastContainer = document.getElementById('toast-container');
        const toast = document.createElement('div');
        toast.className = 'toast';
        toast.textContent = message;

        toastContainer.appendChild(toast);

        // Show the toast
        setTimeout(() => {
            toast.classList.add('show');
        }, 100); // Delay to trigger the CSS transition

        // Hide the toast after 3 seconds
        setTimeout(() => {
            toast.classList.remove('show');
            toast.classList.add('hide');

            // Remove the toast from DOM after the hide animation
            setTimeout(() => {
                toastContainer.removeChild(toast);
            }, 500);
        }, 3000);
    }

    // Hàm định dạng số tiền VND
    function formatVND(n) {
        return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + ' đ';
    }

    // Iterate over each product price element and format it to VND
    document.querySelectorAll('.product-price').forEach(function (element) {
        var price = parseFloat(element.textContent.replace(/[^\d.-]/g, '')); // Extract the numerical value from the price element
        element.textContent = formatVND(price); // Format the price and set it back to the element
    });

    $(document).ready(function () {

        // Event delegation for "Add to Cart" button
        $('.product-list').on('click', '.add-to-cart-btn', function (event) {
            event.preventDefault();
            var $button = $(this);
            var productId = $button.data('product-id');
            var servletUrl = $button.data('servlet-url');
            var action = $button.data('action');

            $.ajax({
                type: "POST",
                url: servletUrl,
                data: {id: productId, action: action},
                success: function (data) {
                    showToast(data.successMsg);
                    updateCheckCart(data.checkCart);
                },
                error: function () {
                    // Handle error
                    alert("An error occurred while processing the request.");
                }
            });
        });

        $('#load-more-btn').click(function (event) {
            event.preventDefault();

            var ammout = document.getElementsByClassName('product').length;
            var cateId = $(this).data('cate-id');
            var cateName = $(this).data('cate-name');

            // Add your AJAX request or other logic here to load more products
            $.ajax({
                url: 'load', // Replace with your URL
                method: 'GET',
                data: {
                    existedProduct: ammout,
                    cateId: cateId
                },
                success: function (data) {
                    var productList = $('.product-list');

                    if (data.trim() === '') {
                        // Hide the Load More button and notify the user
                        $('#load-more-btn').hide();
                        showToast('LaptopTG đã hết sản phẩm ' + cateName);
                    } else {
                        productList.append(data); // Append new products to the product list
                    }
                },
                error: function (error) {
                    console.log(error);
                }
            });
        });
    });

</script>

</body>
</html>
