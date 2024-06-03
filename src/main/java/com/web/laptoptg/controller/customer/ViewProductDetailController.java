package com.web.laptoptg.controller.customer;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.model.Product;
import com.web.laptoptg.service.ProductService;
import com.web.laptoptg.service.impl.ProductServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(urlPatterns = "/product-detail")
public class ViewProductDetailController extends HttpServlet {

    private ProductService productService;


    @Override
    public void init() throws ServletException {
        super.init();
        productService = new ProductServiceImpl();

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            int id = Integer.parseInt(req.getParameter("pid"));
            Product pro = productService.findProductById(id);
            System.out.println(pro.getCategory().getCategoryName());
            req.setAttribute("proDetail", pro);
            req.getRequestDispatcher("customer/product-detail.jsp").forward(req, resp);
        } catch(Exception e){
            resp.sendRedirect("home");
        }

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
