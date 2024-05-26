<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 5/21/2024
  Time: 5:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/font-awesome.min.css" rel="stylesheet">
    <link href="assets/css/login.css" rel="stylesheet">

    <title>Đăng nhập</title>
</head>
<body>

<!-- HEADER -->
<jsp:include page="../components/navbar-login-register.jsp"/>
<!-- /HEADER -->


<section class="form-02-main">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="_lk_de">
                    <form class="form-03-main" action="login" method="post">
                        <div class="logo">
                            <img src="assets/img/user.png">
                        </div>
                        <c:if test="${accountError != null}">
                            <p class="text-danger font-italic" style="font-size: 14px">${accountError}</p>
                        </c:if>
                        <div class="form-group">
                            <input type="email" name="email" class="form-control _ge_de_ol" type="text" placeholder="Nhập Email" required="" aria-required="true">
                        </div>

                        <div class="form-group">
                            <input type="password" name="password" class="form-control _ge_de_ol" type="text" placeholder="Nhập mật khẩu" required="" aria-required="true">
                            <c:if test="${passwordError != null}">
                                <p class="text-danger font-italic" style="font-size: 14px">${passwordError}</p>
                            </c:if>
                        </div>

                        <div class="form-group">
                            <input type="submit" class="_btn_04" value="Đăng nhập" style="border-color: transparent;">
                        </div>

                        <div class="form-group">
                            <a href="#" class="text-primary">Quên mật khẩu?</a> <br>
                            <span>Chưa có tài khoản? </span><a href="register" class="text-primary">Tạo tài khoản</a>
                        </div>

                        <div class="text-secondary d-flex align-items-center">
                            <div class="flex-grow-1">
                                <hr class="bg-secondary">
                            </div>
                            <p class="mx-2 mb-0">Hoặc tiếp tục bằng</p>
                            <div class="flex-grow-1">
                                <hr class="bg-secondary">
                            </div>
                        </div>

                        <div class="form-group pt-0">
                            <div class="_social_04">
                                <ol>
                                    <li>
                                        <a href="#"><i class="fa fa-google-plus"></i></a>
                                    </li>
                                </ol>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>