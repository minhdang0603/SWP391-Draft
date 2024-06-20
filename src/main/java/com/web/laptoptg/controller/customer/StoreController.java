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
import java.io.PrintWriter;
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
                if (category.getId() == cateID) {
                    temp = category;
                }
            }

            List<Product> products = null;
            if (cateID == 0) { // load all product
                List<Product> allProducts = productService.getAllProducts();
                products = allProducts.stream().limit(9).collect(Collectors.toList());
            } else {
                // get number of product by category
                products = productService.getProductByCate(cateID, 9);
            }

            req.setAttribute("size", products.size());
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
        // get parameter from ajax
        String sortValue = req.getParameter("price");
        String brands = req.getParameter("brands");
        String categoryId = req.getParameter("category");

        List<Integer> brandIDs = null; // list to save brand id
        try {
            // check if user choose any brand
            if (!brands.isEmpty() && !brands.isBlank()) {
                brandIDs = new ArrayList<>();
                String[] brandArray = brands.split(",");
                for (String brandID : brandArray) {
                    brandIDs.add(Integer.parseInt(brandID));
                }
            }
            int cateID = Integer.parseInt(categoryId);

            // call service to get product list
            List<Product> products = productService.getProductBySorting(brandIDs, sortValue, cateID);
            /* send success data to client */
            resp.setContentType("text/html");
            resp.setCharacterEncoding("UTF-8");
            PrintWriter out = resp.getWriter();
            int cnt = 0;
            if (products.isEmpty()) {
                out.println("<div class=\"col-md-12\">\n" +
                        "                <div class=\"alert alert-info text-center\">\n" +
                        "                    Không có sản phẩm. Xin vui lòng quay lại sau!.\n" +
                        "                </div>\n" +
                        "            </div>");
                return;
            }

            // write html code
            for (Product product : products) {
                cnt++;
                // make the list layout follow the rule
                if (cnt % 3 == 0) {
                    if (product.getStockUnit() == 0) {
                        out.println("<div class=\"col-md-4 col-xs-6\">\n" +
                                "                            <div class=\"product\">\n" +
                                "                                <div class=\"product-img\">\n" +
                                "                                    <img src=\"" + req.getContextPath() + "/assets/img/product-img/" + product.getImage() + "\"alt=\"\">\n" +
                                "                                </div>\n" +
                                "                                <div class=\"product-body\">\n" +
                                "                                    <p class=\"product-category\">" + product.getCategory().getCategoryName() + "</p>\n" +
                                "                                    <h3 class=\"product-name\"><a href=\"" + req.getContextPath() + "/product-detail?pid=" + product.getId() + "\">" + product.getProductName() + "</a></h3>\n" +
                                "                                    <h4 class=\"product-price\">" + product.getUnitPrice() + "</h4>\n" +
                                "                                </div>\n" +
                                "                                <div class=\"add-to-cart\">\n" +
                                "                                    <button class=\"disabled-btn\" disabled>\n" +
                                "                                        <i class=\"fa fa-phone\"></i> Liên hệ cửa hàng\n" +
                                "                                    </button>\n" +
                                "                                </div>\n" +
                                "                            </div>\n" +
                                "                        </div>" +
                                "<div class=\"clearfix\"></div>");
                    } else {
                        out.println("<div class=\"col-md-4 col-xs-6\">\n" +
                                "                            <div class=\"product\">\n" +
                                "                                <div class=\"product-img\">\n" +
                                "                                    <img src=\"" + req.getContextPath() + "/assets/img/product-img/" + product.getImage() + "\"alt=\"\">\n" +
                                "                                </div>\n" +
                                "                                <div class=\"product-body\">\n" +
                                "                                    <p class=\"product-category\">" + product.getCategory().getCategoryName() + "</p>\n" +
                                "                                    <h3 class=\"product-name\"><a href=\"" + req.getContextPath() + "/product-detail?pid=" + product.getId() + "\">" + product.getProductName() + "</a></h3>\n" +
                                "                                    <h4 class=\"product-price\">" + product.getUnitPrice() + "</h4>\n" +
                                "                                </div>\n" +
                                "                                <div class=\"add-to-cart\">\n" +
                                "                                    <button class=\"add-to-cart-btn\"\n" +
                                "                                            data-servlet-url=\"cart\"\n" +
                                "                                            data-product-id=\"" + product.getId() + "\"\n" +
                                "                                            data-action=\"add\">\n" +
                                "                                        <i class=\"fa fa-shopping-cart\"></i> Thêm vào giỏ hàng\n" +
                                "                                    </button>\n" +
                                "                                </div>\n" +
                                "                            </div>\n" +
                                "                        </div>" +
                                "<div class=\"clearfix\"></div>");
                    }
                } else {
                    if (product.getStockUnit() == 0) {
                        out.println("<div class=\"col-md-4 col-xs-6\">\n" +
                                "                            <div class=\"product\">\n" +
                                "                                <div class=\"product-img\">\n" +
                                "                                    <img src=\"" + req.getContextPath() + "/assets/img/product-img/" + product.getImage() + "\"alt=\"\">\n" +
                                "                                </div>\n" +
                                "                                <div class=\"product-body\">\n" +
                                "                                    <p class=\"product-category\">" + product.getCategory().getCategoryName() + "</p>\n" +
                                "                                    <h3 class=\"product-name\"><a href=\"" + req.getContextPath() + "/product-detail?pid=" + product.getId() + "\">" + product.getProductName() + "</a></h3>\n" +
                                "                                    <h4 class=\"product-price\">" + product.getUnitPrice() + "</h4>\n" +
                                "                                </div>\n" +
                                "                                <div class=\"add-to-cart\">\n" +
                                "                                    <button class=\"disabled-btn\" disabled>\n" +
                                "                                        <i class=\"fa fa-phone\"></i> Liên hệ cửa hàng\n" +
                                "                                    </button>\n" +
                                "                                </div>\n" +
                                "                            </div>\n" +
                                "                        </div>");
                    } else {
                        out.println("<div class=\"col-md-4 col-xs-6\">\n" +
                                "                            <div class=\"product\">\n" +
                                "                                <div class=\"product-img\">\n" +
                                "                                    <img src=\"" + req.getContextPath() + "/assets/img/product-img/" + product.getImage() + "\"alt=\"\">\n" +
                                "                                </div>\n" +
                                "                                <div class=\"product-body\">\n" +
                                "                                    <p class=\"product-category\">" + product.getCategory().getCategoryName() + "</p>\n" +
                                "                                    <h3 class=\"product-name\"><a href=\"" + req.getContextPath() + "/product-detail?pid=" + product.getId() + "\">" + product.getProductName() + "</a></h3>\n" +
                                "                                    <h4 class=\"product-price\">" + product.getUnitPrice() + "</h4>\n" +
                                "                                </div>\n" +
                                "                                <div class=\"add-to-cart\">\n" +
                                "                                    <button class=\"add-to-cart-btn\"\n" +
                                "                                            data-servlet-url=\"cart\"\n" +
                                "                                            data-product-id=\"" + product.getId() + "\"\n" +
                                "                                            data-action=\"add\">\n" +
                                "                                        <i class=\"fa fa-shopping-cart\"></i> Thêm vào giỏ hàng\n" +
                                "                                    </button>\n" +
                                "                                </div>\n" +
                                "                            </div>\n" +
                                "                        </div>");
                    }
                }
            }
        } catch (NumberFormatException e) {
            throw new ServletException(e);
        }
    }

    @Override
    public void destroy() {
        JPAConfig.shutdown();
    }
}
