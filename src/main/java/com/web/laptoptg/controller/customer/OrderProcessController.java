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
        String action = req.getParameter("action");

        if (action.equals("cancel")) {
            // do cancel order
            doCancel(req, resp);
        } else if(action.equals("receive")){
            // do update order status
            doUpdateStatus(req, resp);
        } else {
            // back to profile page
            resp.sendRedirect(req.getContextPath() + "/profile");
        }
    }

    private void doUpdateStatus(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // do update order
        HttpSession session = req.getSession();
        UserDTO account = (UserDTO) session.getAttribute("account");
        String orderId = req.getParameter("orderId");
        Orders order = orderService.getOrderById(Integer.parseInt(orderId));

        // check order status
        if(!order.getOrderStatus().equals(Status.PROCESSING)) {
            session.setAttribute("error", "Đơn hàng không trong trạng thái giao hàng!");
            resp.sendRedirect(req.getContextPath() + "/profile");
            return;
        }

        // check order owner and redirect to profile page
        if(order.getCustomer().getId() != account.getId()){
            session.setAttribute("error", "Đơn hàng không tồn tại!");
            resp.sendRedirect(req.getContextPath() + "/profile");
            return;
        }

        // change order's status to receiced
        order.setOrderStatus(Status.RECEIVED);
        order.setReceiveDate(LocalDateTime.now());
        orderService.updateOrder(order);

        // send success message to profile page
        session.setAttribute("success", "Xin cảm ơn vì đã sử dụng dịch vụ của chúng tôi!");
        resp.sendRedirect(req.getContextPath() + "/profile");
    }

    private void doCancel(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // do cancel order
        HttpSession session = req.getSession();
        UserDTO account = (UserDTO) session.getAttribute("account");
        String orderId = req.getParameter("orderId");
        Orders order = orderService.getOrderById(Integer.parseInt(orderId));

        //  check payment status and redirect to profile page
        if(order.getPayment().getStatus().equals(Status.PAID)) {
            session.setAttribute("error", "Không thể hủy đơn hàng đã thanh toán!");
            resp.sendRedirect(req.getContextPath() + "/profile");
            return;
        }

        // check order status
        if(order.getOrderStatus().equals(Status.PROCESSING) || order.getOrderStatus().equals(Status.RECEIVED)) {
            session.setAttribute("error", "Không thể hủy đơn hàng đã được xác nhận!");
            resp.sendRedirect(req.getContextPath() + "/profile");
            return;
        }

        // check order owner and redirect to profile page
        if(order.getCustomer().getId() != account.getId()){
            session.setAttribute("error", "Đơn hàng không tồn tại!");
            resp.sendRedirect(req.getContextPath() + "/profile");
            return;
        }

        // change order's status to cancel
        order.setOrderStatus(Status.CANCELLED);
        orderService.updateOrder(order);

        // send success message to profile page
        session.setAttribute("success", "Hủy đơn hàng thành công!");
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
        order.setOrderDate(LocalDateTime.now());
        order.setCustomer(user);
        order = orderService.saveOrder(order);

        // add to order details
        for (ItemDTO item : items) {
            OrderDetails orderDetails = new OrderDetails();
            orderDetails.setRated(false);
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
        HttpSession session = req.getSession();
        session.setAttribute("order", order);

        resp.sendRedirect(req.getContextPath() + "/online-payment");
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
