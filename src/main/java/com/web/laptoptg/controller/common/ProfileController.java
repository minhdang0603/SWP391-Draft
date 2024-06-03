package com.web.laptoptg.controller.common;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dto.UserDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(urlPatterns = "/profile")
public class ProfileController extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
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
        super.doPost(req, resp);
    }

    @Override
    public void destroy() {
        JPAConfig.shutdown();
    }
}
