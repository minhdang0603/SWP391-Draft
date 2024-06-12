package com.web.laptoptg.controller.common;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dto.UserDTO;
import com.web.laptoptg.model.User;
import com.web.laptoptg.service.UserService;
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

    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        UserDTO account = (UserDTO) session.getAttribute("account");

        if (account == null) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        req.getRequestDispatcher("common/users-profile.jsp").forward(req, resp);
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