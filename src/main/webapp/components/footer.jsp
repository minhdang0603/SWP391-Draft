<%--
  Created by IntelliJ IDEA.
  User: MinhDang HE181967
  Date: 6/3/2024
  Time: 7:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<footer id="footer">
    <!-- top footer -->
    <div class="section">
        <!-- container -->
        <div class="container">
            <!-- row -->
            <div class="row">
                <div class="col-md-3 col-xs-6">
                    <div class="footer">
                        <h3 class="footer-title">Về chúng tôi</h3>
                        <ul class="footer-links">
                            <li><a href="https://hanoi.fpt.edu.vn/tuyen-sinh-dai-hoc-fpt-2024/?utm_source=FGA&utm_medium=DHF&utm_campaign=FHL&utm_term=Ladi%202&gad_source=1&gclid=Cj0KCQjwv7O0BhDwARIsAC0sjWMd0uSa9Zdd09nTAqVuJBXR5J5hAgRrciOb3G9dCc5MrLZJ3HkDy4kaAqdAEALw_wcB"><i class="fa fa-map-marker"></i>FPT University Hanoi</a></li>
                            <li><a><i class="fa fa-phone"></i>0858173562</a></li>
                            <li><a><i class="fa fa-envelope-o"></i>anhlvhhe182182@fpt.edu.vn</a></li>
                        </ul>
                    </div>
                </div>

                <div class="col-md-3 col-xs-6">
                    <div class="footer">
                        <h3 class="footer-title">Danh mục</h3>
                        <ul class="footer-links">
                            <li><a href="${contextPath}/store?id=1">Laptops</a></li>
                            <li><a href="${contextPath}/store?id=7">Cameras</a></li>
                            <li><a href="${contextPath}/store?id=9">Thiết bị văn phòng</a></li>
                        </ul>
                    </div>
                </div>

                <div class="clearfix visible-xs"></div>

                <div class="col-md-3 col-xs-6">
                    <div class="footer">
                        <h3 class="footer-title">Thông tin</h3>
                        <ul class="footer-links">
                            <li><a href="${contextPath}/terms-and-conditions">Điều khoản & Điều kiện</a></li>
                        </ul>
                    </div>
                </div>

                <div class="col-md-3 col-xs-6">
                    <div class="footer">
                        <h3 class="footer-title">Dịch vụ</h3>
                        <ul class="footer-links">
                            <li><a href="${contextPath}/profile">Tài khoản</a></li>
                            <li><a href="${contextPath}/cart">Giỏ hàng</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- /row -->
        </div>
        <!-- /container -->
    </div>
    <!-- /top footer -->
</footer>
