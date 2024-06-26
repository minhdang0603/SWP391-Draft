package com.web.laptoptg.filter;

import com.web.laptoptg.dto.UserDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class URLFilter implements Filter {
    FilterConfig config;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.config = filterConfig;
    }

    // filter all bad url
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpSession session = request.getSession();
        UserDTO account = (UserDTO) session.getAttribute("account");
        if (account == null || account.getRole().equalsIgnoreCase("member")) {
            request.getRequestDispatcher("common/page-error-404.jsp").forward(request, response);
            return;
        }

        filterChain.doFilter(servletRequest, servletResponse);

    }

    @Override
    public void destroy() {
        Filter.super.destroy();
    }
}
