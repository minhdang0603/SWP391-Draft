<%--
  Created by IntelliJ IDEA.
  User: MinhDang HE181967
  Date: 6/6/2024
  Time: 4:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<nav id="navigation">
    <div class="container">
        <div id="responsive-nav">
            <ul class="main-nav nav navbar-nav">
                <li><a href="${contextPath}/home">Trang chủ</a></li>
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                        Danh mục <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu">
                        <c:forEach var="category" items="${categories}">
                            <li><a href="${contextPath}/store?id=${category.id}">${category.categoryName}</a></li>
                        </c:forEach>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
