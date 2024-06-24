package com.web.laptoptg.controller.customer;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.model.Category;
import com.web.laptoptg.model.Product;
import com.web.laptoptg.service.CategoryService;
import com.web.laptoptg.service.ProductService;
import com.web.laptoptg.service.impl.CategoryServiceImpl;
import com.web.laptoptg.service.impl.ProductServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/search")
public class SearchController extends HttpServlet {

    private ProductService productService;
    private CategoryService categoryService;

    @Override
    public void init() throws ServletException {
        super.init();
        productService = new ProductServiceImpl();
        categoryService = new CategoryServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        List<Product> products = productService.findProduct(keyword);
        List<Category> categories = categoryService.getAllCategory();

        req.setAttribute("keyword", keyword);
        req.setAttribute("products", products);
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("customer/searching-value.jsp").forward(req, resp);
    }

    @Override
    public void destroy() {
        super.destroy();
        JPAConfig.shutdown();
    }
}
