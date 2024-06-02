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
                        <a href="home" class="logo">
                            <img src="${contextPath}/assets/home/img/logo1.png" alt="">
                        </a>
                    </div>
                </div>
                <!-- /LOGO -->

                <!-- SEARCH BAR -->
                <div class="col-md-6">
                    <div class="header-search">
                        <form>
                            <select class="input-select">
                                <option value="0">All Categories</option>
                                <option value="1">Category 01</option>
                                <option value="1">Category 02</option>
                            </select>
                            <input class="input" placeholder="Search here">
                            <button class="search-btn">Search</button>
                        </form>
                    </div>
                </div>
                <!-- /SEARCH BAR -->

                <!-- ACCOUNT -->
                <div class="col-md-3 clearfix">
                    <div class="header-ctn">
                        <!-- Cart -->
                        <div class="" style="cursor: pointer">
                            <a href="${contextPath}/cart">
                                <i class="fa fa-shopping-cart"></i>
                                <span>Your Cart</span>
                                <c:if test="${checkCart > 0}">
                                    <div class="qty">${checkCart}</div>
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
                                    My Account
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
                                            <span>User Profile</span>
                                        </a>
                                    </li>
                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>
                                    <li>
                                        <a class="dropdown-item d-flex align-items-center" href="${contextPath}/logout">
                                            <span class="text-center">Sign Out</span>
                                        </a>
                                    </li>
                                </ul><!-- End Profile Dropdown Items -->
                            </div>
                        </c:if>
                        <!-- /Login -->

                        <!-- Menu Toogle -->
                        <div class="menu-toggle">
                            <a href="#">
                                <i class="fa fa-bars"></i>
                                <span>Menu</span>
                            </a>
                        </div>
                        <!-- /Menu Toogle -->

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
