<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 5/21/2024
  Time: 5:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Đăng ký</title>
    <link href="${contextPath}/assets/home/img/logo1.png" rel="icon">
    <link href="${contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="${contextPath}/assets/css/font-awesome.min.css" rel="stylesheet">
    <link href="${contextPath}/assets/css/login.css" rel="stylesheet">

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
                    <form class="form-03-main" id="myform" method="post" action="register">
                        <div class="logo">
                            <img src="${contextPath}/assets/img/user.png">
                        </div>

                        <%--Cannot add user to database error--%>
                        <c:if test="${systemAlert != null}">
                            <div class="alert alert-danger alert-dismissible ri-alert-line fade show" role="alert">
                                <span style="font-size: 14px">${systemAlert}</span>
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                                        aria-hidden="true">&times;</span></button>
                            </div>
                        </c:if>

                        <%--Exceeded the limit for entering otp--%>
                        <c:if test="${verifyError != null}">
                            <div class="alert alert-danger alert-dismissible ri-alert-line fade show" role="alert">
                                <span style="font-size: 14px">${verifyError}</span>
                                <c:remove var="verifyError" scope="session"/>
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                                        aria-hidden="true">&times;</span></button>
                            </div>
                        </c:if>
                        <div class="form-group">
                            <input name="first_name" class="form-control _ge_de_ol" type="text" placeholder="* Nhập họ"
                                   value="${first_name}" required="" aria-required="true">
                        </div>

                        <div class="form-group">
                            <input name="last_name" class="form-control _ge_de_ol" type="text" placeholder="* Nhập tên"
                                   value="${last_name}" required="" aria-required="true">
                        </div>

                        <div class="form-group">
                            <input name="email" class="form-control _ge_de_ol" type="text" placeholder="* Nhập Email"
                                   value="${email}" required="" aria-required="true">
                            <c:if test="${emailAlert != null}">
                                <p class="text-danger font-italic" style="font-size: 14px">${emailAlert}</p>
                            </c:if>
                        </div>

                        <div class="form-group">
                            <input name="password" class="password-1 form-control _ge_de_ol" type="password"
                                   placeholder="* Nhập mật khẩu" required="" aria-required="true">
                            <p class="msg1 text-danger font-italic" style="font-size: 14px"></p>
                        </div>

                        <div class="form-group">
                            <input name="confirm_password" class="password-2 form-control _ge_de_ol" type="password"
                                   placeholder="* Xác nhận mật khẩu" required="" aria-required="true">
                            <p class="msg2 text-danger font-italic" style="font-size: 14px"></p>
                        </div>
                        <div class="g-recaptcha" data-sitekey="6LcUuewpAAAAACoUC5A46utS4D4YAOA1sJ9GB-Ja"></div>
                        <p class="msg3 text-danger font-italic" style="font-size: 14px"></p>
                        <div class="form-group">
                            <input type="submit" class="_btn_04 btn" disabled value="Đăng ký"
                                   style="border-color: transparent;">
                        </div>

                        <div class="mb-3">
                            <span>Đã có tài khoản?</span>
                            <a href="${contextPath}/login" class="text-primary">Đăng nhập</a>
                        </div>

                        <div class="text-secondary d-flex align-items-center">
                            <div class="flex-grow-1">
                                <hr class="bg-secondary">
                            </div>
                            <p class="mx-2 mb-0">Hoặc</p>
                            <div class="flex-grow-1">
                                <hr class="bg-secondary">
                            </div>
                        </div>

                        <div class="form-group">
                            <a href=""
                               class="btn bsb-btn-xl btn-outline-dark rounded-0 d-flex align-items-center col-md-10 offset-1">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor"
                                     class="bi bi-google text-danger" viewBox="0 0 16 16">
                                    <path d="M15.545 6.558a9.42 9.42 0 0 1 .139 1.626c0 2.434-.87 4.492-2.384 5.885h.002C11.978 15.292 10.158 16 8 16A8 8 0 1 1 8 0a7.689
                                                7.689 0 0 1 5.352 2.082l-2.284 2.284A4.347 4.347 0 0 0 8 3.166c-2.087 0-3.86 1.408-4.492 3.304a4.792 4.792 0 0 0 0 3.063h.003c.635 1.893
                                                2.405 3.301 4.492 3.301 1.078 0 2.004-.276 2.722-.764h-.003a3.702 3.702 0 0 0 1.599-2.431H8v-3.08h7.545z"/>
                                </svg>
                                <span class="ms-2 fs-6 flex-grow-1">Tiếp tục bằng Google</span>
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<script src="${contextPath}/assets/js/check-recaptcha.js"></script>
<script src="${contextPath}/assets/js/register-password.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>