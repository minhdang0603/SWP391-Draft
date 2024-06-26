<%--
  Created by IntelliJ IDEA.
  User: MinhDang HE181967
  Date: 6/2/2024
  Time: 1:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<header>
    <!-- MAIN HEADER -->
    <div id="header">
        <!-- container -->
        <div class="container">
            <!-- row -->
            <div class="row">
                <!-- LOGO -->
                <div class="col-md-3">
                    <div class="header-logo">
                        <a href="${contextPath}/home" class="logo">
                            <img src="${contextPath}/assets/home/img/logo1.png" alt="">
                        </a>
                    </div>
                </div>
                <!-- /LOGO -->

                <!-- SEARCH BAR -->
                <div class="col-md-6">
                    <div class="header-search">
                        <form method="get" action="${contextPath}/search">
                            <input class="input" required name="keyword" placeholder="Tìm kiếm sản phẩm" value="${keyword}">
                            <button type="submit" class="search-btn">Tìm kiếm</button>
                        </form>
                    </div>
                </div>
                <!-- /SEARCH BAR -->

                <!-- ACCOUNT -->
                <div class="col-md-3 clearfix">
                    <div class="header-ctn">
                        <!-- Cart -->
                        <div class="cart" style="cursor: pointer">
                            <a href="${contextPath}/cart" class="cart-container">
                                <i class="fa fa-shopping-cart"></i>
                                <span>Giỏ hàng</span>
                                <c:if test="${checkCart > 0}">
                                    <div class="qty check-cart">${checkCart}</div>
                                </c:if>
                            </a>
                        </div>
                        <!-- /Cart -->

                        <!-- Login -->
                        <c:if test="${account == null}">
                            <div>
                                <a href="${contextPath}/login">
                                    <i class="fa fa-sign-in"></i>
                                    <span>Đăng nhập</span>
                                </a>
                            </div>
                        </c:if>

                        <c:if test="${account != null}">
                            <div class="dropdown" style="cursor: pointer">
                                <a class="dropdown-toggle" data-toggle="dropdown">
                                    <i class="fa fa-user-circle"></i>
                                    Tài khoản
                                </a>

                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li class="dropdown-header">
                                        <h5 class="text-center">${account.userName}</h5>
                                        <span>${account.email}</span>
                                    </li>
                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>
                                    <li>
                                        <a class="dropdown-item d-flex align-items-center"
                                           href="${contextPath}/profile">
                                            <span>Thông tin tài khoản</span>
                                        </a>
                                    </li>
                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>
                                    <li>
                                        <a class="dropdown-item d-flex align-items-center" href="${contextPath}/logout">
                                            <span class="text-center">Đăng xuất</span>
                                        </a>
                                    </li>
                                </ul><!-- End Profile Dropdown Items -->
                            </div>
                        </c:if>
                        <!-- /Login -->

                        <!-- Menu Toggle -->
                        <div class="menu-toggle">
                            <a href="#">
                                <i class="fa fa-bars"></i>
                                <span>Menu</span>
                            </a>
                        </div>
                        <!-- /Menu Toggle -->

                    </div>
                </div>
                <!-- /ACCOUNT -->
            </div>
            <!-- row -->
        </div>
        <!-- container -->
    </div>
    <!-- /MAIN HEADER -->
</header>

