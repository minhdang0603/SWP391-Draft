package com.web.laptoptg.controller.customer;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.model.Brand;
import com.web.laptoptg.model.Category;
import com.web.laptoptg.model.Product;
import com.web.laptoptg.service.BrandService;
import com.web.laptoptg.service.CategoryService;
import com.web.laptoptg.service.ProductService;
import com.web.laptoptg.service.impl.BrandServiceImpl;
import com.web.laptoptg.service.impl.CategoryServiceImpl;
import com.web.laptoptg.service.impl.ProductServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/store")
public class StoreController extends HttpServlet {

    private CategoryService categoryService;
    private ProductService productService;
    private BrandService brandService;

    @Override
    public void init() throws ServletException {
        categoryService = new CategoryServiceImpl();
        productService = new ProductServiceImpl();
        brandService = new BrandServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // get category id from request
            int cateID = Integer.parseInt(req.getParameter("id"));
            // get all category and brand from database
            List<Category> categories = categoryService.getAllCategory();
            List<Brand> brands = brandService.getAllBrands();
            // get the category
            Category temp = new Category();
            for (Category category : categories) {
                if(category.getId() == cateID) {
                    temp = category;
                }
            }

            if(cateID == 0) {

            } else {
                // get number of product by category
                List<Product> products = productService.getProductByCate(cateID, 9);
            }


            req.setAttribute("thisCate", temp);
            req.setAttribute("categories", categories);
            req.setAttribute("brands", brands);
            req.setAttribute("products", products);
        } catch (NumberFormatException e) {
            throw new ServletException(e);
        }

        // forward to category page
        req.getRequestDispatcher("customer/categories.jsp").forward(req, resp);
    }

    @Override
    public void destroy() {
        JPAConfig.shutdown();
    }
}
