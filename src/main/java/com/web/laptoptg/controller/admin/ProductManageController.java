package com.web.laptoptg.controller.admin;

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

@WebServlet(urlPatterns = "/admin/product-manage")
public class ProductManageController extends HttpServlet {

    private ProductService productService;
    private CategoryService categoryService;
    private BrandService brandService;

    @Override
    public void init() throws ServletException {
        productService = new ProductServiceImpl();
        categoryService = new CategoryServiceImpl();
        brandService = new BrandServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> list = productService.getAllProducts();
        List<Category> listCate = categoryService.getAllCategory();
        List<Brand> listBrand = brandService.getAllBrands();

        req.setAttribute("listCate", listCate);
        req.setAttribute("list", list);
        req.setAttribute("listBrand", listBrand);
        req.getRequestDispatcher("product-manage.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req,resp);
    }

    @Override
    public void destroy() {
        JPAConfig.shutdown();
    }
}
