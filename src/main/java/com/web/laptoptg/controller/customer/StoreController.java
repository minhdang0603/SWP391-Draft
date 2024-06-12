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
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

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
            Category temp = null;
            for (Category category : categories) {
                if(category.getId() == cateID) {
                    temp = category;
                }
            }

            List<Product> products = null;
            if(cateID == 0) { // load all product
                List<Product> allProducts = productService.getAllProducts();
                products = allProducts.stream().limit(9).collect(Collectors.toList());
            } else {
                // get number of product by category
                products = productService.getProductByCate(cateID, 9);
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
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String[] brands = req.getParameter("brands").split(",");
        List<Integer> brandIDs = new ArrayList<>();
        try {
            for(String brandID : brands) {
                brandIDs.add(Integer.parseInt(brandID));
            }
        } catch (NumberFormatException e) {
            throw new ServletException(e);
        }
        List<Product> products = productService.getProductByBrandIDs(brandIDs);
    }

    @Override
    public void destroy() {
        JPAConfig.shutdown();
    }
}
