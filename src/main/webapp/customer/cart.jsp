<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 5/24/2024
  Time: 9:04 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Shopping Cart</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <title>Electro - HTML Ecommerce Template</title>

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

    <!-- custom cart -->
    <link type="text/css" rel="stylesheet" href="${contextPath}/assets/home/css/cart.css"/>

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

        .btn-default {
            border: none;
        }

        .change-quantity {
            display: flex;
            justify-content: space-around;
        }

        .input-group .input-number {
            width: 45px;
            text-align: center; /* Center text within input */
        }

        .input-group-addon,
        .input-group-btn {
            width: 40%;
        }

        .delete-item {
            font-size: 16px;
            cursor: pointer;
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

<!-- Cart -->
<main class="page">
    <section class="shopping-cart dark">
        <div class="container">
            <div class="block-heading">
                <h2>Shopping Cart</h2>
            </div>
            <div class="content">
                <div class="row">
                    <c:if test="${requestScope.cart.isEmpty()}">
                        <div class="col-md-6 col-lg-8 col-md-offset-3 col-lg-offset-2">
                            <div class="text-center">
                                <p style="font-size: 24px; padding: 10px; font-weight: bold; color: #D10024">Chưa có sản
                                    phẩm nào trong giỏ hàng</p>
                                <p class="text-muted" style="font-size: 18px; padding: 10px;">Cùng mua sắm hàng ngàn sản
                                    phẩm với LaptopTG nhé</p>
                                <div class="col-md-3 col-md-offset-5" style="padding: 10px;">
                                    <a type="button" class="btn btn-primary btn-lg btn-block" href="${contextPath}/home"
                                       style="margin-top: 20px; background: #D10024;">
                                        Mua hàng</a>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${!requestScope.cart.isEmpty()}">
                        <div class="col-md-12 col-lg-8">
                            <div class="items">
                                <c:forEach var="item" items="${requestScope.cart}">
                                    <div class="product">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <img class="img-responsive img-center"
                                                     src="${contextPath}/assets/img/product-img/${item.product.image}">
                                            </div>
                                            <div class="col-md-9">
                                                <div class="info">
                                                    <div class="row">
                                                        <div class="col-md-4 product-name">
                                                            <div class="product-name">
                                                                <a href="#"
                                                                   class="product-name-a">${item.product.productName}</a>
                                                            </div>
                                                            <div class="product-info">
                                                                <a href="#">${item.product.brand.brandName}</a>
                                                            </div>
                                                            <div class="product-info">
                                                                <a class="delete-item" href=""
                                                                   data-product-id="${item.product.id}"
                                                                   data-servlet-url="cart"
                                                                   data-action="delete">
                                                                    <i class="fa fa-trash"></i> Delete
                                                                </a>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4 quantity">
                                                            <label for="quantity-${item.product.id}">Quantity:</label>
                                                            <div class="input-group">
                                                                <span class="input-group-btn">
                                                                    <button class="btn btn-default btn-number"
                                                                            data-type="minus"
                                                                            data-field="quant[${item.product.id}]"
                                                                            data-product-id="${item.product.id}"
                                                                            data-servlet-url="cart"
                                                                            data-action="process">
                                                                        <span class="glyphicon glyphicon-minus"></span>
                                                                    </button>
                                                                </span>
                                                                <input id="quantity-${item.product.id}" type="text"
                                                                       name="quant[${item.product.id}]"
                                                                       class="text-center form-control input-number"
                                                                       value="${item.quantity}" min="1"
                                                                       max="${item.product.stockUnit}"/>
                                                                <span class="input-group-btn">
                                                                    <button class="btn btn-default btn-number"
                                                                            data-type="plus"
                                                                            data-field="quant[${item.product.id}]"
                                                                            data-product-id="${item.product.id}"
                                                                            data-servlet-url="cart"
                                                                            data-action="process"
                                                                            data-max="${item.product.stockUnit}">
                                                                        <span class="glyphicon glyphicon-plus"></span>
                                                                    </button>
                                                                </span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4 price">
                                                            <p id="price-${item.product.id}"
                                                               class="price">${item.product.unitPrice}</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <div class="col-md-12 col-lg-4">
                            <div class="summary">
                                <h3>Summary</h3>
                                <div class="summary-item"><span class="text">Total</span><span class="price"
                                                                                               id="total">${total}</span>
                                </div>
                                <a type="button" class="btn btn-primary btn-lg btn-block" href="checkout.jsp">Checkout
                                    <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </section>
</main>

<!-- /Cart -->


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
<script>
    // Hàm định dạng số tiền VND
    function formatVND(n) {
        return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".") + ' đ';
    }

    // Iterate over each product to format the price
    <c:forEach var="item" items="${requestScope.cart}">
    document.getElementById("price-${item.product.id}").innerText = formatVND(${item.product.unitPrice});
    </c:forEach>
    document.getElementById('total').innerHTML = formatVND(${total});
</script>
<script>
    $(document).ready(function () {

        function updateTotal() {
            var total = 0;
            $(".product").each(function () {
                var quantity = parseInt($(this).find('.input-number').val());
                var price = parseFloat($(this).find('.price').text().replace(/\./g, '').replace(' đ', ''));
                total += quantity * price;
            });
            $("#total").text(formatVND(total));
        }

        function updateCheckCart() {
            const checkCart = document.querySelector('.check-cart');
            checkCart.textContent = parseInt(checkCart.textContent) - 1;
            if (parseInt(checkCart.textContent) === 0) {
                location.reload();
            }
        }

        $(".btn-number").on('click', function () {
            var $button = $(this);
            var oldValue = $button.closest('.input-group').find("input").val();
            var newVal = 0;
            var productId = $button.data('product-id');
            var servletUrl = $button.data('servlet-url');
            var action = $button.data('action');
            var productName = $button.closest('.product').find('.product-name-a').text();
            var maxUnit = $button.data('max');
            if(parseInt(oldValue) === maxUnit){
                window.alert('Số lượng sản phẩm không đủ!')
                return;
            }

            if ($button.data('type') === "minus") {
                newVal = parseInt(oldValue) - 1;
            } else if ($button.data('type') === "plus") {
                newVal = parseInt(oldValue) + 1;
            }

            if (newVal < 1) {
                var confirm = window.confirm("Bạn có muốn xóa sản phẩm '" + productName + "' không?");
                if (!confirm) {
                    newVal += 1;
                }
            }

            if (confirm) {
                $.ajax({
                    type: "POST",
                    url: servletUrl,
                    data: {productId: productId, action: 'delete'},
                    success: function (data) {
                        // Remove the product element from the DOM
                        $button.closest('.product').remove();
                        updateTotal();
                        updateCheckCart();
                    },
                    error: function () {
                        // Handle error
                        alert("An error occurred while processing the request.");
                    }
                });
                return;
            }
            // Make AJAX request to servlet
            $.ajax({
                type: "POST",
                url: servletUrl,
                data: {productId: productId, quantity: newVal, action: action},
                success: function (data) {
                    $button.closest('.input-group').find("input").val(newVal);
                    updateTotal();
                },
                error: function () {
                    // Handle error
                    alert("An error occurred while processing the request.");
                }
            });

        });

        $(".delete-item").click(function (event) {
            event.preventDefault();
            var $link = $(this);
            var productId = $link.data('product-id');
            var servletUrl = $link.data('servlet-url');
            var productName = $link.closest('.product').find('.product-name-a').text();
            var action = $link.data('action');

            // Display a confirmation dialog
            var confirmed = window.confirm("Bạn có muốn xóa sản phẩm '" + productName + "' không?");

            if (confirmed) {
                // Make AJAX request to delete item
                $.ajax({
                    type: "POST",
                    url: servletUrl,
                    data: {productId: productId, action: action},
                    success: function (data) {
                        // Remove the product element from the DOM
                        $link.closest('.product').remove();
                        updateTotal();
                        updateCheckCart();
                    },
                    error: function () {
                        // Handle error
                        alert("An error occurred while processing the request.");
                    }
                });
            }
        });
    });
</script>
</body>
</html>