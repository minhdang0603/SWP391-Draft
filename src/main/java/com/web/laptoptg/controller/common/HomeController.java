package com.web.laptoptg.controller.common;

import com.web.laptoptg.dto.CartDTO;
import com.web.laptoptg.dto.ItemDTO;
import com.web.laptoptg.model.Category;
import com.web.laptoptg.model.Product;
import com.web.laptoptg.service.CategoryService;
import com.web.laptoptg.service.ProductService;
import com.web.laptoptg.service.impl.CategoryServiceImpl;
import com.web.laptoptg.service.impl.ProductServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = "/home")
public class HomeController extends HttpServlet {

    private ProductService productService;
    private CategoryService categoryService;

    @Override
    public void init() throws ServletException {
        productService = new ProductServiceImpl();
        categoryService = new CategoryServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Cookie[] cookies = req.getCookies();
        List<Product> products = productService.getAllProducts();

        List<Category> categories = categoryService.getAllCategory();
        List<ItemDTO> items = loadCookies(cookies, products);
        ArrayList<List<Product>> list = new ArrayList<>();
        for (Category category : categories) {
            if(category.getId() == 1 || category.getId() == 3 || category.getId() == 4) {
                list.add(productService.getTop4ByCate(category.getId()));
            }
        }
        req.setAttribute("list", list);
        req.setAttribute("checkCart", items.size());
        req.getRequestDispatcher("common/home-index.jsp").forward(req, resp);
    }

    private List<ItemDTO> loadCookies(Cookie[] cookies, List<Product> products) {
        StringBuilder cartContent = new StringBuilder();
        if(cookies != null) {
            for(Cookie cookie : cookies) {
                if(cookie.getName().equals("cart")) {
                    cartContent.append(cookie.getValue());
                }
            }
        }
        CartDTO cart = new CartDTO(cartContent.toString(), products);
        return cart.getItems();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
