package com.web.laptoptg.filter;

import com.web.laptoptg.dto.UserDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class LoginFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        Filter.super.init(filterConfig);
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("account"); // get user from session
        if (user != null){ // check user exist
            if (user.getRole().equals("ADMIN")){ // check role and redirect to appropriate page
                response.sendRedirect(request.getContextPath() + "/admin/home");
            } else if(user.getRole().equals("SALER")){
                response.sendRedirect(request.getContextPath() + "/saler/home");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else { // else redirect to login page
            request.getRequestDispatcher("common/login.jsp").forward(request, response);
        }
    }

    @Override
    public void destroy() {
        Filter.super.destroy();
    }
}
