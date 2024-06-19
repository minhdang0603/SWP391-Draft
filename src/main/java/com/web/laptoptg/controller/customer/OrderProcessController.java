package com.web.laptoptg.controller.customer;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.config.Status;
import com.web.laptoptg.dto.CartDTO;
import com.web.laptoptg.dto.ItemDTO;
import com.web.laptoptg.dto.UserDTO;
import com.web.laptoptg.model.*;
import com.web.laptoptg.service.*;
import com.web.laptoptg.service.impl.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

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
        super.doGet(req, resp);
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

        // add payment and update order
        if(paymentMethod.equals("cash-on-delivery")) {
            payment.setAmount(cartDTO.getTotal());
            payment.setStatus(Status.UNPAID);
            payment.setMethod(Status.COD);
            paymentService.savePayment(payment);
        } else {
            
        }

    }

    // get order date time
    private String getOrderDate(){
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
