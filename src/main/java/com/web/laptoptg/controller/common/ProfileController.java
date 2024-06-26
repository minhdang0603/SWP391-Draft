package com.web.laptoptg.controller.common;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.config.Status;
import com.web.laptoptg.dto.UserDTO;
import com.web.laptoptg.model.OrderDetails;
import com.web.laptoptg.model.Orders;
import com.web.laptoptg.model.User;
import com.web.laptoptg.service.OrderDetailService;
import com.web.laptoptg.service.OrderService;
import com.web.laptoptg.service.UserService;
import com.web.laptoptg.service.impl.OrderDetailServiceImpl;
import com.web.laptoptg.service.impl.OrderServiceImpl;
import com.web.laptoptg.service.impl.UserServiceImpl;
import com.web.laptoptg.util.PasswordUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Enumeration;
import java.util.List;

@WebServlet(urlPatterns = "/profile")
public class ProfileController extends HttpServlet {

    private UserService userService;
    private OrderService orderService;


    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
        orderService = new OrderServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        UserDTO account = (UserDTO) session.getAttribute("account");

        if(account.getRole().equals("MEMBER")) {
            List<Orders> pendingOrders = orderService.getOrdersByUserIDAndStatus(account.getId(), Status.PENDING);
            List<Orders> processingOrders = orderService.getOrdersByUserIDAndStatus(account.getId(), Status.PROCESSING);
            List<Orders> receivedOrders = orderService.getOrdersByUserIDAndStatus(account.getId(), Status.RECEIVED);
            List<Orders> cancelledOrders = orderService.getOrdersByUserIDAndStatus(account.getId(), Status.CANCELLED);
            req.setAttribute("pendingOrders", pendingOrders);
            req.setAttribute("processingOrders", processingOrders);
            req.setAttribute("receivedOrders", receivedOrders);
            req.setAttribute("cancelledOrders", cancelledOrders);
        }

        req.getRequestDispatcher("common/users-profile.jsp").forward(req, resp);
        // remove error session
        session.removeAttribute("updateSuccess");
        session.removeAttribute("passwordChangeSuccess");
        session.removeAttribute("passwordChangeFailure");
        session.removeAttribute("ratingSuccess");
        session.removeAttribute("error");
        session.removeAttribute("success");
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String formType = req.getParameter("formType");
        HttpSession session = req.getSession();
        UserDTO account = (UserDTO) session.getAttribute("account");
        if ("form1".equals(formType)) {
            handleProfileEdit(req, resp, account, session);
        } else if ("form2".equals(formType)) {
            handleChangePassword(req, resp, account, session);
        }
    }

    private void handleProfileEdit(HttpServletRequest req, HttpServletResponse resp, UserDTO userDTO, HttpSession session) throws ServletException, IOException {
        // Lấy dữ liệu từ form
        String fullName = req.getParameter("fullName");
        String address = req.getParameter("address");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");

        userDTO.setUserName(fullName);
        userDTO.setAddress(address);
        userDTO.setPhoneNumber(phone);
        userDTO.setEmail(email);

        userService.updateUser(userDTO);
        session.setAttribute("account", userDTO);
        session.setAttribute("updateSuccess", "success");
        resp.sendRedirect(req.getContextPath() + "/profile");
    }


    private void handleChangePassword(HttpServletRequest req, HttpServletResponse resp, UserDTO userDTO, HttpSession session) throws ServletException, IOException {
        String password = req.getParameter("currentPassword");
        String newPass = req.getParameter("newPassword");

        try {
            if (PasswordUtils.verify(password, userDTO.getPassword())) {
                String hashPass = PasswordUtils.hash(newPass);
                userDTO.setPassword(hashPass);
                userService.updateUser(userDTO);
                session.setAttribute("account", userDTO);
                session.setAttribute("passwordChangeSuccess", "success");
                resp.sendRedirect(req.getContextPath() + "/profile");
                return;
            }

            session.setAttribute("passwordChangeFailure", "success");
            resp.sendRedirect(req.getContextPath() + "/profile");
        } catch (Exception e) {
            System.err.println("Error during password change: " + e.getMessage());
        }
    }

    @Override
    public void destroy() {
        JPAConfig.shutdown();
    }
}