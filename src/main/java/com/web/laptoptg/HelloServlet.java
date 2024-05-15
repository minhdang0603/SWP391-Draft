package com.web.laptoptg;

import java.io.*;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "helloServlet", value = "/hello-servlet")
public class HelloServlet extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String salt = request.getServletContext().getInitParameter("salt");
        System.out.println(salt);
        request.getRequestDispatcher("index.jsp").forward(request,response);
    }

    public void destroy() {
    }
}