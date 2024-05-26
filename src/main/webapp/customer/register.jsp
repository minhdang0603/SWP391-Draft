<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 5/21/2024
  Time: 5:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
                    <form class="form-03-main" method="post" action="register">
                        <div class="logo">
                            <img src="assets/img/user.png">
                            <c:if test="${systemAlert != null}">
                                <div class="alert alert-danger" role="alert">
                                    ${systemAlert}
                                </div>
                            </c:if>
                        </div>
                        <div class="form-group">
                            <input name="first_name" class="form-control _ge_de_ol" type="text" placeholder="Nhập họ" value="${first_name}" required="" aria-required="true">
                        </div>

                        <div class="form-group">
                            <input name="last_name" class="form-control _ge_de_ol" type="text" placeholder="Nhập tên" value="${last_name}" required="" aria-required="true">
                        </div>

                        <div class="form-group">
                            <input name="email" class="form-control _ge_de_ol" type="text" placeholder="Nhập Email" value="${email}" required="" aria-required="true">
                            <c:if test="${emailAlert != null}">
                                <p class="text-danger font-italic" style="font-size: 14px">${emailAlert}</p>
                            </c:if>
                        </div>

                        <div class="form-group">
                            <input name="password" class="form-control _ge_de_ol" type="password" placeholder="Nhập mật khẩu" required="" aria-required="true">
                            <c:if test="${passwordAlert != null}">
                                <p class="text-danger font-italic" style="font-size: 14px">${passwordAlert}</p>
                            </c:if>
                        </div>

                        <div class="form-group">
                            <input name="confirm_password" class="form-control _ge_de_ol" type="password" placeholder="Xác nhận mật khẩu" required="" aria-required="true">
                            <c:if test="${confirmPasswordAlert != null}">
                                <p class="text-danger font-italic" style="font-size: 14px">${confirmPasswordAlert}</p>
                            </c:if>
                        </div>

                        <div class="form-group">
                            <input type="submit" class="_btn_04" value="Đăng ký" style="border-color: transparent;">
                        </div>

                        <div class="mb-3">
                            <span>Đã có tài khoản?</span>
                            <a href="login" class="text-primary">Đăng nhập</a>
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
                                    <li><i class="fa fa-google-plus"></i></li>
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