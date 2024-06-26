<%--
  Created by IntelliJ IDEA.
  User: MinhDang HE181967
  Date: 6/2/2024
  Time: 4:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!-- ======= Sidebar ======= -->
<aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

        <!-- Dashboard Nav -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="${contextPath}/admin/home">
                <i class="bi bi-grid"></i>
                <span>Dashboard</span>
            </a>
        </li><!-- End Dashboard Nav -->


        <li class="nav-heading">Quản Lý</li>

        <!-- Profile Nav -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="${contextPath}/profile">
                <i class="bi bi-person"></i>
                <span>Profile</span>
            </a>
        </li><!-- End Profile Page Nav -->

        <!-- Products Nav -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="${contextPath}/admin/product-manage">
                <i class="bi bi-laptop"></i>
                <span>Sản Phẩm</span>
            </a>
        </li><!-- End Product Page Nav -->


        <!-- Category Nav -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="${contextPath}/admin/category-manage">
                <i class="bi bi-card-list"></i>
                <span>Danh Mục</span>
            </a>
        </li><!-- End Category Page Nav -->

        <!-- Brand Nav -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="${contextPath}/admin/brand-manage">
                <i class="bi bi-bank2"></i>
                <span>Hãng sản phẩm</span>
            </a>
        </li><!-- End Brand Page Nav -->

        <!-- Orders Nav -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="${contextPath}/admin/order-manage">
                <i class="bi bi-file-post"></i>
                <span>Đơn hàng</span>
            </a>
        </li><!-- End Order Page Nav -->


        <!-- Show Account Nav if it's ADMIN -->
        <c:if test="${account.role == 'ADMIN'}">
            <!-- Accounts Nav -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="${contextPath}/admin/account-manage">
                    <i class="bi bi-people"></i>
                    <span>Tài Khoản</span>
                </a>
            </li><!-- End Account Page Nav -->
        </c:if>
    </ul>

</aside><!-- End Sidebar-->
