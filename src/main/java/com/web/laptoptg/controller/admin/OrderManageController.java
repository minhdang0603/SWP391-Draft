package com.web.laptoptg.controller.admin;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dto.UserDTO;
import com.web.laptoptg.model.*;
import com.web.laptoptg.service.*;
import com.web.laptoptg.service.impl.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
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
        HttpSession session = req.getSession();
        UserDTO user = (UserDTO) session.getAttribute("account");
        List<Orders> ordersListforSaler = orderService.searchOrdersByCusID(user.getId());
        List<Orders> listOrder = orderService.getAllOrders();
        List<User> salerList = userService.findUserByRole("SALER");
        if (user.getRole().equals("SALER")){
            req.setAttribute("list", ordersListforSaler);
        } else req.setAttribute("list", listOrder);
        //req.setAttribute("list", listOrder);
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
