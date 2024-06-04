package com.web.laptoptg.controller.customer;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dto.CartDTO;
import com.web.laptoptg.dto.ItemDTO;
import com.web.laptoptg.dto.UserDTO;
import com.web.laptoptg.model.Cart;
import com.web.laptoptg.model.CartDetails;
import com.web.laptoptg.model.Product;
import com.web.laptoptg.service.CartDetailsService;
import com.web.laptoptg.service.CartService;
import com.web.laptoptg.service.ProductService;
import com.web.laptoptg.service.impl.CartDetailsServiceImpl;
import com.web.laptoptg.service.impl.CartServiceImpl;
import com.web.laptoptg.service.impl.ProductServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(urlPatterns = "/cart")
public class CartController extends HttpServlet {

    private ProductService productService;
    private CartDetailsService cartDetailsService;
    private CartService cartService;

    @Override
    public void init() throws ServletException {
        productService = new ProductServiceImpl();
        cartDetailsService = new CartDetailsServiceImpl();
        cartService = new CartServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action.equals("view")) {
            Cookie[] cookies = req.getCookies();
            List<Product> products = productService.getAllProducts();
            CartDTO cartDTO = loadCookies(cookies, products);
            req.setAttribute("cart", cartDTO.getItems());
            req.setAttribute("total", cartDTO.getTotal());
            req.setAttribute("checkCart", cartDTO.getItems().size());
            req.getRequestDispatcher("customer/cart.jsp").forward(req, resp);
        }
    }

    private void addToCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("text/plain; charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        UserDTO account = (UserDTO) session.getAttribute("account");
        Cookie[] cookies = req.getCookies();
        String productId = req.getParameter("id");
        int quantity = 1;
        if (account == null) { // add to cookie if user is not log in
            addToCookie(cookies, productId, quantity, resp);
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        // add to cookie and database
        addToCookie(cookies, productId, quantity, resp);
        Cart cart = cartService.getCartByUserId(account.getId());
        List<CartDetails> listCD = cartDetailsService.getCartDetailsByCart(cart.getId());
        String productName = "";
        try {
            Product product = productService.findProductById(Integer.parseInt(productId));
            productName = product.getProductName();
            // update database if it has product
            for (CartDetails cartDetails : listCD) {
                if (cartDetails.getProduct().getId() == product.getId()) {
                    cartDetails.setQuantity(quantity + cartDetails.getQuantity());
                    cartDetailsService.updateCartDetails(cartDetails);
                    resp.sendRedirect(req.getContextPath() + "/home");
                    return;
                }
            }

            // add new to database if it does not have product in it
            CartDetails cartDetails = new CartDetails();
            cartDetails.setQuantity(quantity);
            cartDetails.setProduct(product);
            cartDetails.setCart(cart);
            cartDetailsService.saveCartDetails(cartDetails);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        resp.getWriter().println("Thêm sản phẩm " + productName + "thành công");
    }

    private void addToCookie(Cookie[] cookies, String productId, int quantity, HttpServletResponse resp) {
        StringBuilder cartContent = new StringBuilder();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("cart")) {
                    cartContent.append(cookie.getValue());
                    cookie.setMaxAge(0);
                    resp.addCookie(cookie);
                }
            }
        }

        if (cartContent.length() == 0) {
            cartContent = new StringBuilder(productId + ":" + quantity); // Use a separator to distinguish different products
        } else {
            cartContent.append("/").append(productId).append(":").append(quantity);
        }
        Cookie cookie = new Cookie("cart", cartContent.toString());
        cookie.setMaxAge(60 * 60 * 24);
        resp.addCookie(cookie);
    }

    private CartDTO loadCookies(Cookie[] cookies, List<Product> products) {
        StringBuilder cartContent = new StringBuilder();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("cart")) {
                    cartContent.append(cookie.getValue());
                }
            }
        }
        return new CartDTO(cartContent.toString(), products);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String productId = req.getParameter("productId");
        Cookie[] cookies = req.getCookies();
        List<Product> products = productService.getAllProducts();
        if (action.equals("process")) {
            String quantity = req.getParameter("quantity");
            doProcessCart(req, resp, cookies, products, productId, quantity);
        } else if (action.equals("delete")) {
            doDelete(req, resp, cookies, products, productId);
        } else if (action.equals("add")) {
            addToCart(req, resp);
        }
    }

    // update cart when user login
    private void updateCart(List<ItemDTO> list, List<CartDetails> cartDetailsList, Cart cart) {
        for (ItemDTO item : list) {
            for (CartDetails cartDetails : cartDetailsList) {
                if (cartDetails.getProduct().getId() == item.getProduct().getId()) {
                    cartDetails.setQuantity(item.getQuantity());
                    cartDetailsService.updateCartDetails(cartDetails);
                }
            }
        }
    }

    private void doDelete(HttpServletRequest req, HttpServletResponse resp, Cookie[] cookies, List<Product> products, String productId) {
        CartDTO cartDTO = loadCookies(cookies, products);
        List<ItemDTO> items = cartDTO.getItems();
        UserDTO account = (UserDTO) req.getSession().getAttribute("account");
        try {
            Product product = cartDTO.getProductByID(Integer.parseInt(productId), products);
            items.removeIf(item -> item.getProduct().getId() == Integer.parseInt(productId));

            if(account != null) {
                Cart cart = cartService.getCartByUserId(account.getId());
                CartDetails temp = new CartDetails();
                temp.setCart(cart);
                temp.setProduct(product);
                cartDetailsService.deleteCartDetails(temp);
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        StringBuilder cartContent = new StringBuilder();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("cart")) {
                    cookie.setMaxAge(0);
                    resp.addCookie(cookie);
                }
            }
        }

        for (ItemDTO itemDTO : items) {
            if (cartContent.length() == 0) {
                cartContent = new StringBuilder(itemDTO.getProduct().getId() + ":" + itemDTO.getQuantity()); // Use a separator to distinguish different products
            } else {
                cartContent.append("/").append(itemDTO.getProduct().getId()).append(":").append(itemDTO.getQuantity());
            }
        }

        Cookie cookie = new Cookie("cart", cartContent.toString());
        cookie.setMaxAge(60 * 60 * 24);
        resp.addCookie(cookie);
    }

    private void doProcessCart(HttpServletRequest req, HttpServletResponse resp, Cookie[] cookies, List<Product> products, String productId, String quantity) {
        CartDTO cartDTO = loadCookies(cookies, products);
        UserDTO account = (UserDTO) req.getSession().getAttribute("account");
        List<ItemDTO> items = cartDTO.getItems();
        for (ItemDTO item : items) {
            if (item.getProduct().getId() == Integer.parseInt(productId)) {
                item.setQuantity(Integer.parseInt(quantity));
            }
        }

        if(account != null) {
            Cart cart = cartService.getCartByUserId(account.getId());
            List<CartDetails> listCD = cartDetailsService.getCartDetailsByCart(cart.getId());
            updateCart(items, listCD, cart);
        }

        StringBuilder cartContent = new StringBuilder();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("cart")) {
                    cookie.setMaxAge(0);
                    resp.addCookie(cookie);
                }
            }
        }

        for (ItemDTO itemDTO : cartDTO.getItems()) {
            if (cartContent.length() == 0) {
                cartContent = new StringBuilder(itemDTO.getProduct().getId() + ":" + itemDTO.getQuantity()); // Use a separator to distinguish different products
            } else {
                cartContent.append("/").append(itemDTO.getProduct().getId()).append(":").append(itemDTO.getQuantity());
            }
        }

        Cookie cookie = new Cookie("cart", cartContent.toString());
        cookie.setMaxAge(60 * 60 * 24);
        resp.addCookie(cookie);
    }

    @Override
    public void destroy() {
        JPAConfig.shutdown();
    }
}
