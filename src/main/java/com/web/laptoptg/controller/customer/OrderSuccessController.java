package com.web.laptoptg.controller.customer;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.config.Status;
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
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet(urlPatterns = "/complete-order")
public class OrderSuccessController extends HttpServlet {

    private OrderService orderService;
    private PaymentService paymentService;

    @Override
    public void init() throws ServletException {
        super.init();
        orderService = new OrderServiceImpl();
        paymentService = new PaymentServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //get order from session
        HttpSession session = req.getSession();
        Orders order = (Orders) session.getAttribute("order");

        String paymentMethod = req.getParameter("payment");
        // go to home page if no payment and order is null
        if(paymentMethod == null || order == null) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }
        // remove session
        session.removeAttribute("order");

        // return to order success page
        if (paymentMethod.equals("cod")) {
            req.setAttribute("orderSuccess", "Đơn hàng " + order.getId() + " đã được đặt hàng thành công!");
            req.getRequestDispatcher("customer/order-success.jsp").forward(req, resp);
            req.removeAttribute("orderSuccess");
            return;
        }


        //get transaction status
        String tranStatus = req.getParameter("vnp_TransactionStatus");
        String respCode = req.getParameter("vnp_ResponseCode");

        //check if transaction success and order is paid
        if(tranStatus.equals("00") && respCode.equals("00")) {
            Payment payment = paymentService.findPaymentByID(order.getPayment().getId());
            payment.setStatus(Status.PAID);
            payment.setPayDate(getPayDate());
            payment = paymentService.updatePayment(payment);
            order.setPayment(payment);
            orderService.updateOrder(order);
            req.setAttribute("orderSuccess", "Đơn hàng " + order.getId() + " đã được thanh toán thành công! Xin vui lòng kiểm tra lại đơn hàng");
            req.getRequestDispatcher("customer/order-success.jsp").forward(req, resp);
            req.removeAttribute("orderSuccess");
            return;
        }

        req.setAttribute("paymentError", "Thanh toán đơn hàng thất bại. <br/>Xin vui lòng kiểm tra đơn hàng và thực hiện thanh toán lại trong vòng 15 phút.");
        req.getRequestDispatcher("customer/order-success.jsp").forward(req, resp);
        req.removeAttribute("paymentError");
    }

    // get order date time
    private String getPayDate() {
        LocalDateTime date = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return date.format(formatter);
    }

    @Override
    public void destroy() {
        super.destroy();
        JPAConfig.shutdown();
    }
}
