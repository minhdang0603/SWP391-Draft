package com.web.laptoptg.controller.admin;

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
    private PaymentService paymentService;
    private UserService userService;

    public void init() throws ServletException {
        orderService = new OrderServiceImpl();
        orderDetails = new OrderDetailServiceImpl();
        userService = new UserServiceImpl();
        paymentService = new PaymentServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Orders> listOrder = orderService.getAllOrders();
        List<OrderDetails> orderDetailsList = orderDetails.getAllOrderDetail();
        List<User> salerList = userService.findUserByRole("SALER");
        req.setAttribute("list", listOrder);
        req.setAttribute("detailList",orderDetailsList);
        req.setAttribute("salerList",salerList);
        req.getRequestDispatcher("order-manage.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req,resp);
    }
}
