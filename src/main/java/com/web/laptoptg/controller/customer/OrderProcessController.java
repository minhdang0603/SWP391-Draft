package com.web.laptoptg.controller.customer;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dto.CartDTO;
import com.web.laptoptg.dto.ItemDTO;
import com.web.laptoptg.dto.UserDTO;
import com.web.laptoptg.model.Orders;
import com.web.laptoptg.model.Product;
import com.web.laptoptg.model.User;
import com.web.laptoptg.service.*;
import com.web.laptoptg.service.impl.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

public class OrderProcessController extends HttpServlet {
    private CartService cartService;
    private CartDetailsService cartDetailsService;
    private OrderService orderService;
    private OrderDetailService orderDetailService;
    private ProductService productService;

    @Override
    public void init() throws ServletException {
        super.init();
        cartService = new CartServiceImpl();
        cartDetailsService = new CartDetailsServiceImpl();
        orderService = new OrderServiceImpl();
        orderDetailService = new OrderDetailServiceImpl();
        productService = new ProductServiceImpl();
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

        // add to order
        Orders order = new Orders();
        order.setAddress(address);
        order.setNote(note);
        order.setUserName(username);
        order.setPhoneNumber(phone);
        order.setOrderStatus("pending");
        order.setOrderDate(getOrderDate());
        order.setCustomer(user);
        

        String payment = req.getParameter("payment");

        if(payment.equals("vnpay")) {

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
