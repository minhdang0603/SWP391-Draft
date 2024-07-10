<%--
  Created by IntelliJ IDEA.
  User: MinhDang HE181967
  Date: 5/28/2024
  Time: 5:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="${contextPath}/assets/home/img/logo1.png" rel="icon">
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/login.css" rel="stylesheet">

    <title>Quên mật khẩu</title>
</head>
<body>
<section class="form-02-main">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="_lk_de">
                    <form class="form-03-main" action="forgot-password" method="post">
                        <input type="hidden" name="index" value="2">
                        <input type="hidden" name="code" value="${code}">
                        <div class="form-group">
                            <input name="password" class="password-1 form-control _ge_de_ol" type="password"
                                   placeholder="Nhập mật khẩu mới" required="" aria-required="true">
                            <p class="msg1 text-danger font-italic" style="font-size: 14px"></p>
                        </div>

                        <div class="form-group">
                            <input name="confirm_password" class="password-2 form-control _ge_de_ol" type="password"
                                   placeholder="Xác nhận mật khẩu mới" required="" aria-required="true">
                            <p class="msg2 text-danger font-italic" style="font-size: 14px"></p>
                        </div>

                        <div class="form-group">
                            <input type="submit" class="_btn_04 btn" disabled value="Đổi mật khẩu" style="border-color: transparent;">
                        </div>
                    </form>

                </div>
            </div>

        </div>
    </div>
</section>

<script src="assets/js/register-password.js"></script>

</body>
</html>
