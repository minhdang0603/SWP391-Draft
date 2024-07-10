<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 6/10/2024
  Time: 4:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thành toán thành công</title>
    <!-- Google font -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link href="${contextPath}/assets/home/img/logo1.png" rel="icon">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link type="text/css" rel="stylesheet" href="${contextPath}/assets/home/css/style.css"/>
    <link type="text/css" rel="stylesheet" href="${contextPath}/assets/css/account-toast.css"/>
    <style>
        .confirmation-message {
            margin: 30px auto;
            padding: 50px;
            border-radius: 5px;
            border: none;
            text-align: center;
            position: relative;
        }
        .confirmation-message h4 {
            font-size: 50px;
            margin: 30px 0 -15px;
        }
        .confirmation-message p {
            font-size: 30px;
            margin: 20px 0;
        }
        .confirmation-message .icon-box {
            color: #fff;
            margin: 0 auto 15px;
            width: 95px;
            height: 95px;
            border-radius: 50%;
            padding: 15px;
            text-align: center;
            box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.1);
        }
        .confirmation-message .icon-box i {
            font-size: 58px;
            position: relative;
            top: 3px;
        }
        .confirmation-message .btn {
            color: #fff;
            border-radius: 4px;
            background: #D10024;
            text-decoration: none;
            transition: all 0.4s;
            line-height: normal;
            border: none;
            padding: 10px 20px;
            display: inline-block;
            font-size: 20px;
        }
        .confirmation-message .btn:hover, .confirmation-message .btn:focus {
            background: #D10024;
            outline: none;
        }
        .confirmation-message .btn-transparent {
            background: transparent;
            color: #D10024;
            border: 2px solid #D10024;
        }
    </style>
</head>
<body>
<!-- HEADER -->
<jsp:include page="../components/navbar-customer.jsp"/>
<!-- /HEADER -->
<div class="text-center">
    <!-- Confirmation Message HTML -->
    <c:if test="${orderSuccess != null}">
        <div class="confirmation-message" id="confirmationMessage">
            <div class="icon-box" style="background: #82ce34;">
                <i class="material-icons">&#xE876;</i>
            </div>
            <h4>Thông báo</h4>
            <p>${orderSuccess}</p>
            <a href="${contextPath}/home" class="btn">Tiếp tục mua hàng</a>
        </div>
    </c:if>
    <c:if test="${paymentError != null}">
        <div class="confirmation-message" id="confirmationMessage">
            <div class="icon-box" style="background-color: #D10024;">
                <i class="material-icons">&#xE000;</i>
            </div>
            <h4>Thông báo</h4>
            <p>${paymentError}</p>
            <a href="${contextPath}/home" class="btn">Tiếp tục mua hàng</a>
        </div>
    </c:if>
</div>

<!-- FOOTER -->
<jsp:include page="../components/footer.jsp"/>
<!-- /FOOTER -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="${contextPath}/assets/js/main.js"></script>
<script src="${contextPath}/assets/js/add-to-cart.js"></script>
</body>
</html>
