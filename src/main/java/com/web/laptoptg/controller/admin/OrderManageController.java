package com.web.laptoptg.controller.admin;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.model.*;
import com.web.laptoptg.service.*;
import com.web.laptoptg.service.impl.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/admin/order-manage")
public class OrderManageController extends HttpServlet {

    private OrderService orderService;
    private OrderDetailService orderDetails;
    private UserService userService;

    @Override
    public void init() throws ServletException {
        orderService = new OrderServiceImpl();
        orderDetails = new OrderDetailServiceImpl();
        userService = new UserServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Orders> listOrder = orderService.getAllOrders();
        List<User> salerList = userService.findUserByRole("SALER");
        req.setAttribute("list", listOrder);
        req.setAttribute("salerList",salerList);
        req.getRequestDispatcher("order-manage.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req,resp);
    }

    @Override
    public void destroy() {
        JPAConfig.shutdown();
    }
}
