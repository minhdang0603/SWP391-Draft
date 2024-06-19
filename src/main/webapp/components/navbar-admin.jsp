<%--
  Created by IntelliJ IDEA.
  User: MinhDang HE181967
  Date: 6/5/2024
  Time: 9:18 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<header id="header" class="header fixed-top d-flex align-items-center">

    <div class="d-flex align-items-center justify-content-around">
        <a href="${contextPath}/home" class="logo d-flex align-items-center">
            <img src="${contextPath}/assets/home/img/logo1.png" alt="">
            <span class="d-none d-lg-block">LaptopTG</span>
        </a>
        <c:if test="${account.role == 'ADMIN' || account.role == 'SALER'}">
            <i class="bi bi-list toggle-sidebar-btn"></i>
        </c:if>
    </div><!-- End Logo -->

    <nav class="header-nav ms-auto">
        <ul class="d-flex align-items-center">

            <li class="nav-item dropdown pe-3">

                <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
                    <c:choose>
                        <c:when test="${account.userName == null}">
                            <span class="d-none d-md-block dropdown-toggle ps-2">Member</span>
                        </c:when>
                        <c:otherwise>
                            <span class="d-none d-md-block dropdown-toggle ps-2">${account.userName}</span>
                        </c:otherwise>
                    </c:choose>
                </a><!-- End Profile Iamge Icon -->

                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
                    <li class="dropdown-header">
                        <c:choose>
                            <c:when test="${account.userName == null}">
                                <h6>Member</h6>
                            </c:when>
                            <c:otherwise>
                                <h6>${account.userName}</h6>
                            </c:otherwise>
                        </c:choose>
                        <span>${account.email}</span>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>
                    <li>
                        <a class="dropdown-item d-flex align-items-center" href="${contextPath}/profile">
                            <span>Thông tin tài khoản</span>
                        </a>
                    </li>
                    <c:if test="${account.role == 'ADMIN' || account.role == 'SALER'}">
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li>
                            <a class="dropdown-item d-flex align-items-center"
                               href="${contextPath}/admin/home">
                                <span>Trang quản lý</span>
                            </a>
                        </li>
                    </c:if>
                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li>
                        <a class="dropdown-item d-flex align-items-center" href="${contextPath}/logout">
                            <span>Đăng xuất</span>
                        </a>
                    </li>

                </ul><!-- End Profile Dropdown Items -->
            </li><!-- End Profile Nav -->

        </ul>
    </nav><!-- End Icons Navigation -->

</header>
