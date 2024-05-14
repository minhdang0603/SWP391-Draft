<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<c:forEach begin="1" end="10">
    <h1><%= "Hello World!" %></h1>
</c:forEach>
<br/>
<a href="hello-servlet">Hello Servlet</a>
</body>
</html>