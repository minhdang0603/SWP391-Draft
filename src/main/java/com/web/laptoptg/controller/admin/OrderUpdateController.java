package com.web.laptoptg.controller.admin;

import com.web.laptoptg.model.Orders;
import com.web.laptoptg.service.OrderService;
import com.web.laptoptg.service.UserService;
import com.web.laptoptg.service.impl.OrderServiceImpl;
import com.web.laptoptg.service.impl.UserServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeFormatterBuilder;


@WebServlet(urlPatterns = "/admin/order-update")
public class OrderUpdateController extends HttpServlet {

    private OrderService orderService;
    private UserService userService;

    public void init() throws ServletException {
        orderService = new OrderServiceImpl();
        userService = new UserServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int orderID = Integer.parseInt(req.getParameter("orderId"));
        int salerID = Integer.parseInt(req.getParameter("saler"));
        String orderStatus = req.getParameter("orderStatus");
        String paymentStatus = req.getParameter("paymentStatus");
        String paymentMethod = req.getParameter("paymentMethod");
        String deliverDateStr = req.getParameter("deliverDate").isEmpty() ? null : req.getParameter("deliverDate");
        String receiveDateStr = req.getParameter("receiveDate").isEmpty() ? null : req.getParameter("receiveDate");
        String paymentDateStr = req.getParameter("paymentDate").isEmpty() ? null : req.getParameter("paymentDate");
        Orders orderOld = orderService.getOrderById(orderID);
        orderOld.getPayment().setMethod(paymentMethod);
        if(paymentDateStr != null && !paymentDateStr.isEmpty()){
            LocalDate paymentDate = LocalDate.parse(paymentDateStr);
            orderOld.getPayment().setPayDate(paymentDate.atStartOfDay());
        }

        orderOld.getPayment().setStatus(paymentStatus);
        orderOld.setSaler(userService.findUserById(salerID));
        orderOld.setOrderStatus(orderStatus);
        if(deliverDateStr != null && !deliverDateStr.isEmpty()){
            LocalDate deliverDate = LocalDate.parse(deliverDateStr);
            orderOld.setDeliverDate(deliverDate.atStartOfDay());
        }
        if(receiveDateStr != null && !receiveDateStr.isEmpty()){
            LocalDate receiveDate = LocalDate.parse(receiveDateStr);
            orderOld.setReceiveDate(receiveDate.atStartOfDay());
        }
        orderOld = orderService.updateOrder(orderOld);
        String msg;
        msg = "Chỉnh Sửa Thành Công Đơn Hàng ID" + orderOld.getId();
        req.getSession().setAttribute("msg", msg);
        resp.sendRedirect(req.getContextPath() + "/admin/order-manage");
    }
}
