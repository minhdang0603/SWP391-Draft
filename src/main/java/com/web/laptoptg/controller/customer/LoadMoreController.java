package com.web.laptoptg.controller.customer;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.web.laptoptg.model.Product;
import com.web.laptoptg.service.ProductService;
import com.web.laptoptg.service.impl.ProductServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(urlPatterns = "/load")
public class LoadMoreController extends HttpServlet {

    private ProductService productService;

    @Override
    public void init() throws ServletException {
        productService = new ProductServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // get number of product on page
            int existed = Integer.parseInt(req.getParameter("existedProduct"));
            int categoryId = Integer.parseInt(req.getParameter("cateId"));
            // get next 6 product by category
            List<Product> products = productService.getNextProduct(existed, 6, categoryId);

            // response to client
            resp.setContentType("text/html");
            resp.setCharacterEncoding("UTF-8");
            PrintWriter out = resp.getWriter();
            int cnt = 0;
            if (products.isEmpty()) {
                return;
            }
            // write html code
            for (Product product : products) {
                cnt++;
                // make the list layout follow the rule
                if(cnt % 3 == 0) {
                    out.println("<div class=\"col-md-4 col-xs-6\">\n" +
                            "                            <div class=\"product\">\n" +
                            "                                <div class=\"product-img\">\n" +
                            "                                    <img src=\"" + req.getContextPath() + "/assets/img/product-img/" + product.getImage() + "\"alt=\"\">\n" +
                            "                                </div>\n" +
                            "                                <div class=\"product-body\">\n" +
                            "                                    <p class=\"product-category\">"+product.getCategory().getCategoryName()+"</p>\n" +
                            "                                    <h3 class=\"product-name\"><a href=\""+req.getContextPath() + "/product-detail?pid="+ product.getId() +"\">" + product.getProductName() + "</a></h3>\n" +
                            "                                    <h4 class=\"product-price\">" + product.getUnitPrice() + "</h4>\n" +
                            "                                    <div class=\"product-rating\">\n" +
                            "                                        <i class=\"fa fa-star\"></i>\n" +
                            "                                        <i class=\"fa fa-star\"></i>\n" +
                            "                                        <i class=\"fa fa-star\"></i>\n" +
                            "                                        <i class=\"fa fa-star\"></i>\n" +
                            "                                        <i class=\"fa fa-star\"></i>\n" +
                            "                                    </div>\n" +
                            "                                </div>\n" +
                            "                                <div class=\"add-to-cart\">\n" +
                            "                                    <button class=\"add-to-cart-btn\"\n" +
                            "                                            data-servlet-url=\"cart\"\n" +
                            "                                            data-product-id=\""+product.getId()+"\"\n" +
                            "                                            data-action=\"add\">\n" +
                            "                                        <i class=\"fa fa-shopping-cart\"></i> Thêm vào giỏ hàng\n" +
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
                            "                                    <p class=\"product-category\">"+product.getCategory().getCategoryName()+"</p>\n" +
                            "                                    <h3 class=\"product-name\"><a href=\""+req.getContextPath() + "/product-detail?pid="+ product.getId() +"\">" + product.getProductName() + "</a></h3>\n" +
                            "                                    <h4 class=\"product-price\">" + product.getUnitPrice() + "</h4>\n" +
                            "                                    <div class=\"product-rating\">\n" +
                            "                                        <i class=\"fa fa-star\"></i>\n" +
                            "                                        <i class=\"fa fa-star\"></i>\n" +
                            "                                        <i class=\"fa fa-star\"></i>\n" +
                            "                                        <i class=\"fa fa-star\"></i>\n" +
                            "                                        <i class=\"fa fa-star\"></i>\n" +
                            "                                    </div>\n" +
                            "                                </div>\n" +
                            "                                <div class=\"add-to-cart\">\n" +
                            "                                    <button class=\"add-to-cart-btn\"\n" +
                            "                                            data-servlet-url=\"cart\"\n" +
                            "                                            data-product-id=\""+product.getId()+"\"\n" +
                            "                                            data-action=\"add\">\n" +
                            "                                        <i class=\"fa fa-shopping-cart\"></i> Thêm vào giỏ hàng\n" +
                            "                                    </button>\n" +
                            "                                </div>\n" +
                            "                            </div>\n" +
                            "                        </div>");
                }
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void destroy() {
        super.destroy();
    }
}
