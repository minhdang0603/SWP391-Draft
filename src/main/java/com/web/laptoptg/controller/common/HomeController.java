package com.web.laptoptg.controller.common;

import com.web.laptoptg.dto.CartDTO;
import com.web.laptoptg.dto.ItemDTO;
import com.web.laptoptg.model.Product;
import com.web.laptoptg.service.CartDetailsService;
import com.web.laptoptg.service.CartService;
import com.web.laptoptg.service.CategoryService;
import com.web.laptoptg.service.ProductService;
import com.web.laptoptg.service.impl.CartDetailsServiceImpl;
import com.web.laptoptg.service.impl.CartServiceImpl;
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

    private CartService cartService;
    private CartDetailsService cartDetailsService;
    private ProductService productService;
    private CategoryService categoryService;

    @Override
    public void init() throws ServletException {
        cartService = new CartServiceImpl();
        cartDetailsService = new CartDetailsServiceImpl();
        productService = new ProductServiceImpl();
        categoryService = new CategoryServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Cookie[] cookies = req.getCookies();
        List<ItemDTO> items = loadCookies(cookies);
        ArrayList<List<Product>> list = new ArrayList<>();

//        int cateID = Integer.parseInt(req.getParameter("cateID"));
        for(int i = 1; i <= categoryService.getNumOfCategory(); i++){
            list.add(productService.getTop3ByCate(i));
        }
        req.setAttribute("list", list);
        req.setAttribute("checkCart", items.size());
        req.getRequestDispatcher("common/home-index.jsp").forward(req, resp);
    }

    private List<ItemDTO> loadCookies(Cookie[] cookies) {
        StringBuilder cartContent = new StringBuilder();
        List<Product> products = productService.getAllProducts();
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
