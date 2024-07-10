<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 5/16/2024
  Time: 9:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <title>Thanh toán</title>

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
    <link type="text/css" rel="stylesheet" href="${contextPath}/assets/css/account-toast.css"/>

    <style>
        .disabled-btn {
            background-color: #ccc; /* Darker background color for disabled state */
            cursor: not-allowed; /* Change cursor to indicate disabled state */
        }

        .msg{
            color: #D10024;
            font-style: italic;
            font-size: 12px;
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
<jsp:include page="../components/navigation.jsp"/>
<!-- /NAVIGATION -->

<!-- BREADCRUMB -->
<div id="breadcrumb" class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div class="row">
            <div class="col-md-12">
                <h3 class="breadcrumb-header">Thanh toán</h3>
                <ul class="breadcrumb-tree">
                    <li><a href="${contextPath}/home">Trang chủ</a></li>
                    <li class="active">Thanh toán</li>
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
            <form method="post" action="${contextPath}/order-process">
                <div class="col-md-7">
                    <!-- Billing Details -->
                    <div class="billing-details">
                        <div class="section-title text-center">
                            <h3 class="title">Địa chỉ giao hàng</h3>
                        </div>
                        <div class="form-group">
                            <input class="input" type="text" required name="username" placeholder="Tên người nhận"
                                   value="${account.userName}">
                        </div>
                        <div class="form-group">
                            <input class="input" type="email" required name="email" placeholder="Email"
                                   value="${account.email}">
                        </div>
                        <div class="form-group">
                            <input class="input" type="text" required name="address" placeholder="Địa chỉ"
                                   value="${account.address}">
                        </div>
                        <div class="form-group">
                            <input class="input phone-number" type="tel" required name="phone" placeholder="Số điện thoại"
                                   value="${account.phoneNumber}">
                            <p class="msg text-danger"></p>
                        </div>
                        <!-- /Billing Details -->

                        <!-- Order notes -->
                        <div class="order-notes">
                        <textarea class="input" placeholder="Ghi chú" name="order-note"
                                  style="min-height: 180px; resize: vertical;"></textarea>
                        </div>
                        <!-- /Order notes -->
                    </div>
                </div>
                <!-- Order Details -->
                <div class="col-md-5 order-details">
                    <div class="section-title text-center">
                        <h3 class="title">Đơn hàng của bạn</h3>
                    </div>
                    <div class="order-summary">
                        <div class="order-col">
                            <div><strong>Sản phẩm</strong></div>
                            <div><strong>Giá tiền</strong></div>
                        </div>
                        <div class="order-products">
                            <c:forEach items="${cart}" var="item">
                                <div class="order-col">
                                    <div>
                                            ${item.product.productName}
                                        <br>
                                        Số lượng: ${item.quantity}
                                    </div>
                                    <div class="price">${item.product.unitPrice}</div>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="order-col">
                            <div>Shiping</div>
                            <div><strong>Miễn phí</strong></div>
                        </div>
                        <div class="order-col">
                            <div><strong>Tổng tiền</strong></div>
                            <div><strong class="order-total price" style="font-size: 20px">${total}</strong></div>
                        </div>
                    </div>

                    <div class="payment-method">
                        <div class="input-radio">
                            <input type="radio" name="payment" id="payment-1" value="vnpay">
                            <label for="payment-1">
                                <span></span>
                                Thanh toán bằng VNPay
                            </label>
                        </div>
                        <div class="input-radio">
                            <input type="radio" checked name="payment" id="payment-2" value="cash-on-delivery">
                            <label for="payment-2">
                                <span></span>
                                Thanh toán khi nhận hàng
                            </label>
                        </div>

                    </div>
                    <div class="input-checkbox">
                        <input type="checkbox" name="terms" required id="terms">
                        <label for="terms">
                            <span></span>
                            Tôi đã đọc và chấp nhận các <a href="${contextPath}/terms-and-conditions" target="_blank">điều khoản và điều kiện</a>
                        </label>
                    </div>
                    <input type="submit" class="primary-btn order-submit" value="Đặt hàng"
                           style="width: 100%;" disabled/>
                </div>
                <!-- /Order Details -->
            </form>
        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /SECTION -->

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
<script src="${contextPath}/assets/js/checkout.js"></script>
</body>
</html>
