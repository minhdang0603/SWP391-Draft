package com.web.laptoptg.controller.admin;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.model.Orders;
import com.web.laptoptg.model.Payment;
import com.web.laptoptg.service.OrderService;
import com.web.laptoptg.service.PaymentService;
import com.web.laptoptg.service.impl.OrderServiceImpl;
import com.web.laptoptg.service.impl.PaymentServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(urlPatterns = "/admin/order-delete")
public class OrderDeleteController extends HttpServlet {
    private OrderService orderService;
    private PaymentService paymentService;

    @Override
    public void init() throws ServletException{
        orderService = new OrderServiceImpl();
        paymentService = new PaymentServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int orderID = Integer.parseInt(req.getParameter("orderId"));
        Orders order = orderService.getOrderById(orderID);
        paymentService.deleteById(order.getPayment().getId());
        orderService.deleteOrder(order);
        String msg;
        msg = "Đơn hàng đã xóa thành công!";
        req.getSession().setAttribute("msg", msg);
        resp.sendRedirect(req.getContextPath() + "/admin/order-manage");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }

    @Override
    public void destroy() {
        JPAConfig.shutdown();
    }
}
