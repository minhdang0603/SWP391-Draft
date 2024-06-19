package com.web.laptoptg.controller.customer;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.config.Status;
import com.web.laptoptg.config.VNPayConfig;
import com.web.laptoptg.dto.CartDTO;
import com.web.laptoptg.dto.ItemDTO;
import com.web.laptoptg.dto.UserDTO;
import com.web.laptoptg.model.*;
import com.web.laptoptg.service.*;
import com.web.laptoptg.service.impl.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@WebServlet(urlPatterns = "/order-process")
public class OrderProcessController extends HttpServlet {
    private CartService cartService;
    private CartDetailsService cartDetailsService;
    private OrderService orderService;
    private OrderDetailService orderDetailService;
    private ProductService productService;
    private PaymentService paymentService;

    @Override
    public void init() throws ServletException {
        super.init();
        cartService = new CartServiceImpl();
        cartDetailsService = new CartDetailsServiceImpl();
        orderService = new OrderServiceImpl();
        orderDetailService = new OrderDetailServiceImpl();
        productService = new ProductServiceImpl();
        paymentService = new PaymentServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // do cancel order
        HttpSession session = req.getSession();
        UserDTO account = (UserDTO) session.getAttribute("account");
        String orderId = req.getParameter("orderId");
        Orders order = orderService.getOrderById(Integer.parseInt(orderId));

        //  check payment status and redirect to profile page
        if(order.getPayment().getStatus().equals(Status.PAID)) {
            session.setAttribute("cancelError", "Không thể hủy đơn hàng đã thanh toán!");
            resp.sendRedirect(req.getContextPath() + "/profile");
            return;
        }

        // check order status
        if(order.getOrderStatus().equals(Status.PROCESSING) || order.getOrderStatus().equals(Status.RECEIVED)) {
            session.setAttribute("cancelError", "Không thể hủy đơn hàng đã được xác nhận!");
            resp.sendRedirect(req.getContextPath() + "/profile");
            return;
        }

        // check order owner and redirect to profile page
        if(order.getCustomer().getId() != account.getId()){
            session.setAttribute("cancelError", "Đơn hàng không tồn tại!");
            resp.sendRedirect(req.getContextPath() + "/profile");
            return;
        }

        // change order's status to cancel
        order.setOrderStatus(Status.CANCELLED);
        orderService.updateOrder(order);

        // send success message to profile page
        session.setAttribute("cancelSuccess", "Hủy đơn hàng thành công!");
        resp.sendRedirect(req.getContextPath() + "/profile");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // load and delete cart cookie
        List<Product> products = productService.getAllProducts();
        Cookie[] cookies = req.getCookies();
        CartDTO cartDTO = loadCookies(cookies, products);
        deleteCookie(cookies, resp);
        List<ItemDTO> items = cartDTO.getItems();

        // get order info
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String address = req.getParameter("address");
        String phone = req.getParameter("phone");
        String note = req.getParameter("order-note");

        // get order account
        UserDTO account = (UserDTO) req.getSession().getAttribute("account");
        User user = account.toUser();

        //get user's cart
        Cart cart = cartService.getCartByUserId(user.getId());

        // add to order
        Orders order = new Orders();
        order.setAddress(address);
        order.setNote(note);
        order.setUserName(username);
        order.setPhoneNumber(phone);
        order.setOrderStatus(Status.PENDING);
        order.setOrderDate(getOrderDate());
        order.setCustomer(user);
        order = orderService.saveOrder(order);

        // add to order details
        for (ItemDTO item : items) {
            OrderDetails orderDetails = new OrderDetails();
            orderDetails.setOrder(order);
            orderDetails.setProduct(item.getProduct());
            orderDetails.setQuantity(item.getQuantity());
            orderDetails.setUnitPrice(item.getProduct().getUnitPrice());
            orderDetails.setProductName(item.getProduct().getProductName());
            orderDetails.setMaintenance(item.getProduct().getMaintenance());
            orderDetails.setImage(item.getProduct().getImage());
            orderDetailService.saveOrderDetail(orderDetails);
        }

        // delete cart details
        cartDetailsService.deleteAll(cart.getId());

        // check payment method
        String paymentMethod = req.getParameter("payment");
        Payment payment = new Payment();
        payment.setAmount(cartDTO.getTotal());

        // add payment and update order
        if(paymentMethod.equals("cash-on-delivery")) {
            payment.setStatus(Status.UNPAID);
            payment.setMethod(Status.COD);
            payment = paymentService.savePayment(payment);
            order.setPayment(payment);
            orderService.updateOrder(order);
            req.getSession().setAttribute("order", order);
            resp.sendRedirect(req.getContextPath() + "/complete-order?payment=cod");
            return;
        }

        // process online payment
        payment.setStatus(Status.UNPAID);
        payment.setMethod(Status.ONLINE);
        payment = paymentService.savePayment(payment);
        order.setPayment(payment);
        order = orderService.updateOrder(order);
        String url = paymentUrl(order, req);
        HttpSession session = req.getSession();
        session.setAttribute("order", order);

        resp.sendRedirect(req.getContextPath() + "/online-payment");
    }

    // get payment url
    private String paymentUrl(Orders order, HttpServletRequest req) throws ServletException {
        String vnp_Version = "2.1.0";
        String vnp_Command = "pay";
        String orderType = "other";
        long amount = order.getPayment().getAmount()*100;

        String vnp_TxnRef = VNPayConfig.getRandomNumber(8);
        String vnp_IpAddr = VNPayConfig.getIpAddress(req);

        String vnp_TmnCode = VNPayConfig.vnp_TmnCode;

        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", vnp_Version);
        vnp_Params.put("vnp_Command", vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amount));
        vnp_Params.put("vnp_CurrCode", "VND");
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang:" + vnp_TxnRef);
        vnp_Params.put("vnp_OrderType", orderType);

        String locate = req.getParameter("language");
        if (locate != null && !locate.isEmpty()) {
            vnp_Params.put("vnp_Locale", locate);
        } else {
            vnp_Params.put("vnp_Locale", "vn");
        }
        vnp_Params.put("vnp_ReturnUrl", VNPayConfig.vnp_ReturnUrl);
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

        cld.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

        List fieldNames = new ArrayList(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        Iterator itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = (String) itr.next();
            String fieldValue = (String) vnp_Params.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                //Build hash data
                hashData.append(fieldName);
                hashData.append('=');
                hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII));
                //Build query
                query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII));
                query.append('=');
                query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII));
                if (itr.hasNext()) {
                    query.append('&');
                    hashData.append('&');
                }
            }
        }
        String queryUrl = query.toString();
        String vnp_SecureHash = VNPayConfig.hmacSHA512(VNPayConfig.secretKey, hashData.toString());
        queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
        return VNPayConfig.vnp_PayUrl + "?" + queryUrl;
    }

    // get order date time
    private String getOrderDate() {
        LocalDateTime date = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return date.format(formatter);
    }

    // load cart from cookie
    private CartDTO loadCookies(Cookie[] cookies, List<Product> products) { // load data from cookie
        StringBuilder cartContent = new StringBuilder();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("cart")) {
                    cartContent.append(cookie.getValue());
                }
            }
        }
        return new CartDTO(cartContent.toString(), products);
    }

    // delete cookie
    private void deleteCookie(Cookie[] cookies, HttpServletResponse resp) {
        if(cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("cart")) {
                    cookie.setMaxAge(0);
                    resp.addCookie(cookie);
                }
            }
        }
    }

    @Override
    public void destroy() {
        super.destroy();
        JPAConfig.shutdown();
    }
}
