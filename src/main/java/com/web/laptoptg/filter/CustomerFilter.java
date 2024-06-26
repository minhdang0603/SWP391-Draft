package com.web.laptoptg.filter;

import com.web.laptoptg.dto.UserDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class CustomerFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        Filter.super.init(filterConfig);
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse resp = (HttpServletResponse) servletResponse;
        UserDTO account = (UserDTO) req.getSession().getAttribute("account");

        // skip filter
        if(account == null) {
            filterChain.doFilter(servletRequest, servletResponse);
            return;
        }

        // check user login
        if (!account.getRole().equalsIgnoreCase("member")) {
            resp.sendRedirect(req.getContextPath() + "/admin/home");
            return;
        }

        // skip filter
        filterChain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void destroy() {
        Filter.super.destroy();
    }
}
