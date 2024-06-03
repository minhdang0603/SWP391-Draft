package com.web.laptoptg.controller.customer;

import com.web.laptoptg.dto.UserDTO;
import com.web.laptoptg.model.Cart;
import com.web.laptoptg.model.Product;
import com.web.laptoptg.service.CartDetailsService;
import com.web.laptoptg.service.CartService;
import com.web.laptoptg.service.ProductService;
import com.web.laptoptg.service.UserService;
import com.web.laptoptg.service.impl.CartDetailsServiceImpl;
import com.web.laptoptg.service.impl.CartServiceImpl;
import com.web.laptoptg.service.impl.ProductServiceImpl;
import com.web.laptoptg.service.impl.UserServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(urlPatterns = "/cart")
public class CartController extends HttpServlet {

    private ProductService productService;
    private CartDetailsService cartDetailsService;

    @Override
    public void init() throws ServletException {
        productService = new ProductServiceImpl();
        cartDetailsService = new CartDetailsServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action.equals("add")) {
            addToCart(req, resp);
        }
        req.getRequestDispatcher("customer/cart.jsp").forward(req, resp);
    }

    private void addToCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        UserDTO account = (UserDTO) session.getAttribute("account");
        Cookie[] cookies = req.getCookies();
        String productId = req.getParameter("id");
        String quantity = req.getParameter("num");

        if (account == null) { // add to cookie if user is not log in
            addToCookie(cookies, productId, quantity, resp);
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        // add to cookie and database
        addToCookie(cookies, productId, quantity, resp);
        Cart cart = (Cart) session.getAttribute("cart");

    }

    private void addToCookie(Cookie[] cookies, String productId, String quantity, HttpServletResponse resp) {
        StringBuilder cartContent = new StringBuilder();
        if(cookies != null) {
            for(Cookie cookie : cookies) {
                if(cookie.getName().equals("cart")) {
                    cartContent.append(cookie.getValue());
                    cookie.setMaxAge(0);
                    resp.addCookie(cookie);
                }
            }
        }

        if (cartContent.length() == 0) {
            cartContent = new StringBuilder(productId + ":" + quantity); // Use a separator to distinguish different products
        } else {
            cartContent.append("/").append(productId).append(":").append(productId);
        }
        Cookie cookie = new Cookie("cart", cartContent.toString());
        resp.addCookie(cookie);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
