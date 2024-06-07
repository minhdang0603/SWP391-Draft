package com.web.laptoptg.controller.admin;

import com.web.laptoptg.model.Product;
import com.web.laptoptg.service.ProductService;
import com.web.laptoptg.service.impl.ProductServiceImpl;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/product-manage")
public class ProductManageController extends HttpServlet {
    private ProductService productService; ;

    public void init() throws ServletException {
        productService = new ProductServiceImpl();
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> list = productService.getAllProducts();
        req.setAttribute("list", list);

        req.getRequestDispatcher("admin/productManagement.jsp").forward(req, resp);
    }
}