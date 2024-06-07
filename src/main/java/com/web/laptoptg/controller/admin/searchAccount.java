package com.web.laptoptg.controller.admin;

import com.web.laptoptg.service.UserService;
import com.web.laptoptg.service.impl.UserServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(urlPatterns = "/search-account")
public class searchAccount extends HttpServlet {


    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String searchAcc = req.getParameter("searchAcc");
        userService.findUserByEmail(searchAcc);

        req.setAttribute("listUser",searchAcc);
        req.getRequestDispatcher("accountManagement.jsp").forward(req, resp);
    }


}
