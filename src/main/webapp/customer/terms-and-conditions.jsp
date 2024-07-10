<%--
  Created by IntelliJ IDEA.
  User: MinhDang HE181967
  Date: 6/18/2024
  Time: 8:56 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <title>Điều Khoản và Điều Kiện</title>

    <!-- Google font -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
    <link href="${contextPath}/assets/home/img/logo1.png" rel="icon">
    <!-- Bootstrap -->
    <link type="text/css" rel="stylesheet" href="${contextPath}/assets/home/css/bootstrap.min.css"/>

    <!-- Slick -->
    <link type="text/css" rel="stylesheet" href="${contextPath}/assets/home/css/slick.css"/>
    <link type="text/css" rel="stylesheet" href="${contextPath}/assets/home/css/slick-theme.css"/>

    <!-- nouislider -->
    <link type="text/css" rel="stylesheet" href="${contextPath}/assets/home/css/nouislider.min.css"/>

    <!-- Font Awesome Icon -->
    <link rel="stylesheet" href="${contextPath}/assets/home/css/font-awesome.min.css">

    <!-- Custom stlylesheet -->
    <link type="text/css" rel="stylesheet" href="${contextPath}/assets/home/css/style.css"/>
    <style>
        .terms-and-conditions {
            max-width: 800px;
            margin: auto;
        }
    </style>
</head>
<body>
<jsp:include page="../components/navbar-customer.jsp"/>

<!-- BREADCRUMB -->
<div id="breadcrumb" class="section">
    <!-- container -->
    <div class="container">
        <!-- row -->
        <div class="row">
            <div class="col-md-12">
                <h3 class="breadcrumb-header">Thanh toán</h3>
                <ul class="breadcrumb-tree">
                    <li><a href="${contextPath}/home">Trang chủ</a></li>
                    <c:set var="fromCart" value="fromCart" scope="session"/>
                    <li><a href="${contextPath}/checkout-page">Thanh toán</a></li>
                    <li class="active">Điều khoản và điều kiện</li>
                </ul>
            </div>
        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
</div>
<!-- /BREADCRUMB -->

<div class="terms-and-conditions">
    <h1>Điều Khoản và Điều Kiện</h1>
    <p><strong>Cập nhật lần cuối: 18/6/2024</strong></p>
    <p>Chào mừng đến với LaptopTG Store! Vui lòng đọc kỹ các điều khoản và điều kiện ("Điều Khoản", "Điều Khoản và Điều
        Kiện") trước khi sử dụng trang web [URL Trang Web] (dịch vụ) được vận hành bởi LaptopTG Store ("chúng tôi",
        "chúng tôi", hoặc "của chúng tôi").</p>

    <h2>1. Chấp Nhận Điều Khoản</h2>
    <p>Bằng việc truy cập hoặc sử dụng dịch vụ của chúng tôi, bạn đồng ý bị ràng buộc bởi các điều khoản này. Nếu bạn
        không đồng ý với bất kỳ phần nào của các điều khoản, thì bạn không có quyền truy cập dịch vụ.</p>

    <h2>2. Mua Hàng</h2>
    <p>Nếu bạn muốn mua bất kỳ sản phẩm hoặc dịch vụ nào được cung cấp thông qua dịch vụ ("Mua Hàng"), bạn có thể được
        yêu cầu cung cấp một số thông tin liên quan đến việc mua hàng của bạn bao gồm, nhưng không giới hạn, số thẻ tín
        dụng của bạn, ngày hết hạn của thẻ tín dụng, địa chỉ thanh toán và thông tin vận chuyển của bạn.</p>
    <p>Bạn cam kết và đảm bảo rằng:</p>
    <ul>
        <li>Bạn có quyền hợp pháp để sử dụng bất kỳ thẻ tín dụng hoặc phương thức thanh toán nào khác liên quan đến bất
            kỳ Mua Hàng nào.
        </li>
        <li>Thông tin bạn cung cấp cho chúng tôi là đúng, chính xác và đầy đủ.</li>
    </ul>

    <h2>3. Giao Hàng</h2>
    <ul>
        <li>Chúng tôi giao hàng trên toàn thế giới. Thời gian giao hàng khác nhau tùy thuộc vào vị trí của bạn và phương
            thức giao hàng được chọn.
        </li>
        <li>Chúng tôi không chịu trách nhiệm cho bất kỳ phí hải quan hoặc thuế nào phát sinh khi giao hàng quốc tế.</li>
        <li>Nếu đơn hàng của bạn bị trì hoãn, vui lòng liên hệ với dịch vụ khách hàng của chúng tôi để được trợ giúp.
        </li>
    </ul>

    <h2>4. Hoàn Trả và Đổi Hàng</h2>
    <ul>
        <li>Sản phẩm có thể được trả lại trong vòng 30 ngày kể từ ngày nhận hàng trong tình trạng ban đầu để được hoàn
            tiền hoặc đổi hàng.
        </li>
        <li>Phí vận chuyển không được hoàn lại.</li>
        <li>Để bắt đầu quy trình trả hàng, vui lòng liên hệ với dịch vụ khách hàng của chúng tôi.</li>
    </ul>

    <h2>5. Bảo Hành</h2>
    <ul>
        <li>Tất cả các laptop đều đi kèm với bảo hành 12 tháng bao gồm các lỗi phần cứng.</li>
        <li>Bảo hành không bao gồm các hư hại do sử dụng sai mục đích, tai nạn hoặc sửa đổi trái phép.</li>
    </ul>

    <h2>6. Tài Khoản Người Dùng</h2>
    <p>Khi bạn tạo tài khoản với chúng tôi, bạn phải cung cấp cho chúng tôi thông tin chính xác, đầy đủ và hiện tại mọi
        lúc. Việc không tuân thủ điều này cấu thành vi phạm Điều Khoản, có thể dẫn đến việc chấm dứt ngay lập tức tài
        khoản của bạn trên dịch vụ của chúng tôi.</p>
    <p>Bạn chịu trách nhiệm bảo mật mật khẩu mà bạn sử dụng để truy cập dịch vụ và cho bất kỳ hoạt động hoặc hành động
        nào dưới mật khẩu của bạn, dù mật khẩu của bạn là với dịch vụ của chúng tôi hoặc dịch vụ của bên thứ ba.</p>

    <h2>7. Chính Sách Bảo Mật</h2>
    <p>Việc sử dụng dịch vụ của bạn cũng bị chi phối bởi Chính Sách Bảo Mật của chúng tôi. Vui lòng xem lại Chính Sách
        Bảo Mật của chúng tôi, cũng chi phối dịch vụ và thông báo cho người dùng về các thực hành thu thập dữ liệu của
        chúng tôi.</p>

    <h2>8. Giới Hạn Trách Nhiệm</h2>
    <p>Trong mọi trường hợp, LaptopTG Store, cũng như các giám đốc, nhân viên, đối tác, đại lý, nhà cung cấp hoặc liên
        kết của chúng tôi, không chịu trách nhiệm về bất kỳ thiệt hại gián tiếp, ngẫu nhiên, đặc biệt, hậu quả hoặc
        trừng phạt nào, bao gồm nhưng không giới hạn, mất lợi nhuận, dữ liệu, sử dụng, thiện chí, hoặc các tổn thất vô
        hình khác, do:</p>
    <ul>
        <li>Việc bạn sử dụng hoặc không thể sử dụng dịch vụ;</li>
        <li>Bất kỳ truy cập trái phép nào vào hoặc sử dụng các máy chủ của chúng tôi và/hoặc bất kỳ thông tin cá nhân
            nào được lưu trữ tại đó;
        </li>
        <li>Bất kỳ sự gián đoạn hoặc ngừng truyền tải tới hoặc từ dịch vụ;</li>
        <li>Bất kỳ lỗi, virus, trojan horse hoặc tương tự nào có thể được truyền tới hoặc thông qua dịch vụ của chúng
            tôi bởi bất kỳ bên thứ ba nào;
        </li>
        <li>Bất kỳ lỗi hoặc thiếu sót nào trong bất kỳ nội dung nào hoặc cho bất kỳ mất mát hoặc thiệt hại nào phát sinh
            do việc sử dụng bất kỳ nội dung nào được đăng, gửi email, truyền tải hoặc cung cấp khác thông qua dịch vụ.
        </li>
    </ul>

    <h2>9. Thay Đổi Điều Khoản</h2>
    <p>Chúng tôi bảo lưu quyền, theo quyết định riêng của chúng tôi, sửa đổi hoặc thay thế các điều khoản này bất kỳ lúc
        nào. Nếu một sửa đổi là quan trọng, chúng tôi sẽ cung cấp ít nhất 30 ngày thông báo trước khi bất kỳ điều khoản
        mới nào có hiệu lực. Điều gì cấu thành một thay đổi quan trọng sẽ được xác định theo quyết định riêng của chúng
        tôi.</p>

    <h2>10. Liên Hệ</h2>
    <p>Nếu bạn có bất kỳ câu hỏi nào về các điều khoản này, vui lòng liên hệ với chúng tôi tại:</p>
    <p>LaptopTG Store<br>
        Email: laptoptg2024@gmail.com</p>
</div>
<jsp:include page="../components/footer.jsp"/>
</body>
</html>
