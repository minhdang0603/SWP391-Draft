package com.web.laptoptg.controller.admin;

import com.web.laptoptg.dto.UserDTO;
import com.web.laptoptg.model.User;
import com.web.laptoptg.service.UserService;
import com.web.laptoptg.service.impl.UserServiceImpl;
import jakarta.mail.Session;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/account-manage")
public class AccountManagement extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("aid");
        if (action != null) {
            // Xử lý yêu cầu xóa người dùng
            int deleAcc = Integer.parseInt(action);
            userService.deleteById(deleAcc);
            resp.sendRedirect(req.getContextPath() + "/account-manage");

        }
        else{
                // Xử lý yêu cầu lấy danh sách người dùng
                HttpSession session = req.getSession();
                UserDTO account = (UserDTO) session.getAttribute("account");
//            if (account == null) {
//                resp.sendRedirect(req.getContextPath() + "/home");
//                return;
//            }
                List<User> listUser = userService.findAllUsers();
                req.setAttribute("listUser", listUser);
                req.getRequestDispatcher("accountManagement.jsp").forward(req, resp);
            }
        }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.sendRedirect(request.getContextPath() + "/account-manage");

    }
}
