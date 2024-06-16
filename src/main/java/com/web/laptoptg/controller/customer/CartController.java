package com.web.laptoptg.controller.customer;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
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

        // get cookie from request
        Cookie[] cookies = req.getCookies();

        // get all products from database
        List<Product> products = productService.getAllProducts();

        // load cookies to list
        CartDTO cartDTO = loadCookies(cookies, products);

        req.setAttribute("cart", cartDTO.getItems());
        req.setAttribute("total", cartDTO.getTotal());
        req.setAttribute("checkCart", cartDTO.getItems().size());

        // redirect to cart page
        req.getRequestDispatcher("customer/cart.jsp").forward(req, resp);
    }

    private String addToCookie(Cookie[] cookies, String productId, int quantity, HttpServletResponse resp) {
        StringBuilder cartContent = new StringBuilder();
        if (cookies != null) { // check cart's cookie existed
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("cart")) {
                    cartContent.append(cookie.getValue());
                    cookie.setMaxAge(0);
                    resp.addCookie(cookie);
                }
            }
        }

        // add product and quantity to cart
        if (cartContent.length() == 0) {
            cartContent = new StringBuilder(productId + ":" + quantity); // Use a separator to distinguish different products
        } else {
            cartContent.append("/").append(productId).append(":").append(quantity);
        }

        // create new cookie
        Cookie cookie = new Cookie("cart", cartContent.toString());
        cookie.setMaxAge(60 * 60 * 24);

        // add cookie to response
        resp.addCookie(cookie);
        return cartContent.toString();
    }

    private CartDTO loadCookies(Cookie[] cookies, List<Product> products) { // load data from cookie
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
        // read user action from request
        String action = req.getParameter("action");
        // get product id
        String productId = req.getParameter("productId");
        // get cookie from req
        Cookie[] cookies = req.getCookies();
        // get all product from database
        List<Product> products = productService.getAllProducts();

        switch (action) {
            case "process": // do process to update cart quantity
                // get quantity from request
                String quantity = req.getParameter("quantity");
                // do update to cookie and database
                doProcessCart(req, resp, cookies, products, productId, quantity);
                break;
            case "delete": // do delete product from cart
                // do delete in cookie and database
                doDelete(req, resp, cookies, products, productId);
                break;
            case "add": // add product to cart
                addToCart(req, resp, products);
                break;
        }
    }

    private void updateCart(List<ItemDTO> list, List<CartDetails> cartDetailsList, Cart cart) {
        for (ItemDTO item : list) { // read item list
            for (CartDetails cartDetails : cartDetailsList) { // read cart detail list
                // check if product in cookie exist in database
                if (cartDetails.getProduct().getId() == item.getProduct().getId()) {
                    cartDetails.setQuantity(item.getQuantity()); // update quantity
                    cartDetailsService.updateCartDetails(cartDetails); // save to database
                }
            }
        }
    }

    private void doDelete(HttpServletRequest req, HttpServletResponse resp, Cookie[] cookies, List<Product> products, String productId) {
        CartDTO cartDTO = loadCookies(cookies, products); // load cart from cookie
        List<ItemDTO> items = cartDTO.getItems(); // load cookie to list
        UserDTO account = (UserDTO) req.getSession().getAttribute("account"); // get user account
        try {
            // delete product in item list
            Product product = cartDTO.getProductByID(Integer.parseInt(productId), products);
            items.removeIf(item -> item.getProduct().getId() == Integer.parseInt(productId));

            // delete cart details in database if user is logging in
            if (account != null) {
                Cart cart = cartService.getCartByUserId(account.getId());
                CartDetails temp = new CartDetails();
                temp.setCart(cart);
                temp.setProduct(product);
                cartDetailsService.deleteCartDetails(temp);
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        // check cookie
        StringBuilder cartContent = new StringBuilder();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("cart")) {
                    cookie.setMaxAge(0);
                    resp.addCookie(cookie);
                }
            }
        }

        // load new data to cookie
        for (ItemDTO itemDTO : items) {
            if (cartContent.length() == 0) {
                cartContent = new StringBuilder(itemDTO.getProduct().getId() + ":" + itemDTO.getQuantity()); // Use a separator to distinguish different products
            } else {
                cartContent.append("/").append(itemDTO.getProduct().getId()).append(":").append(itemDTO.getQuantity());
            }
        }

        // save cookie
        Cookie cookie = new Cookie("cart", cartContent.toString());
        cookie.setMaxAge(60 * 60 * 24);
        resp.addCookie(cookie);
    }

    private void doProcessCart(HttpServletRequest req, HttpServletResponse resp, Cookie[] cookies, List<Product> products, String productId, String quantity) {
        CartDTO cartDTO = loadCookies(cookies, products); // load item from cookie
        UserDTO account = (UserDTO) req.getSession().getAttribute("account"); // get user account when user is logged in
        List<ItemDTO> items = cartDTO.getItems(); // load cart to list

        // update the quantity in item list
        for (ItemDTO item : items) {
            if (item.getProduct().getId() == Integer.parseInt(productId)) {
                item.setQuantity(Integer.parseInt(quantity));
            }
        }

        // if user is logging in, update cart to database
        if (account != null) {
            Cart cart = cartService.getCartByUserId(account.getId());
            List<CartDetails> listCD = cartDetailsService.getCartDetailsByCart(cart.getId());
            updateCart(items, listCD, cart);
        }


        StringBuilder cartContent = new StringBuilder();
        // check cookie
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("cart")) {
                    cookie.setMaxAge(0);
                    resp.addCookie(cookie);
                }
            }
        }

        // load item list to cookie
        for (ItemDTO itemDTO : cartDTO.getItems()) {
            if (cartContent.length() == 0) {
                cartContent = new StringBuilder(itemDTO.getProduct().getId() + ":" + itemDTO.getQuantity()); // Use a separator to distinguish different products
            } else {
                cartContent.append("/").append(itemDTO.getProduct().getId()).append(":").append(itemDTO.getQuantity());
            }
        }

        // save cookie
        Cookie cookie = new Cookie("cart", cartContent.toString());
        cookie.setMaxAge(60 * 60 * 24);
        resp.addCookie(cookie);
    }

    private void addToCart(HttpServletRequest req, HttpServletResponse resp, List<Product> products) throws IOException {
        // set content to json
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        // get user account from session
        HttpSession session = req.getSession();
        UserDTO account = (UserDTO) session.getAttribute("account");

        // get cookie from request
        Cookie[] cookies = req.getCookies();

        // get product id from request
        String productId = req.getParameter("id");

        // create json object to save return data
        JsonObject jsonObject = new JsonObject();
        Product product = productService.findProductById(Integer.parseInt(productId));
        String productName = product.getProductName();

        // set quantity to 1
        int quantity = 1;
        if (account == null) { // add to cookie if user is not log in
            String cart = addToCookie(cookies, productId, quantity, resp);

            // get cart size after add to cart and send back to client
            CartDTO cartDTO = new CartDTO(cart, products);
            jsonObject.addProperty("checkCart", cartDTO.getItems().size());
            jsonObject.addProperty("successMsg", "Thêm sản phẩm " + productName + " vào giỏ hàng thành công!");
            String json = new Gson().toJson(jsonObject);
            resp.getWriter().write(json);
            return;
        }

        // add to cookie and database
        addToCookie(cookies, productId, quantity, resp);
        Cart cart = cartService.getCartByUserId(account.getId());
        // get list cart details from database
        List<CartDetails> listCD = cartDetailsService.getCartDetailsByCart(cart.getId());
        try {
            productName = product.getProductName();
            // update database if it has product
            for (CartDetails cartDetails : listCD) {
                if (cartDetails.getProduct().getId() == product.getId()) {
                    cartDetails.setQuantity(quantity + cartDetails.getQuantity());
                    cartDetailsService.updateCartDetails(cartDetails);
                    // send success message to client
                    jsonObject.addProperty("checkCart", listCD.size());
                    jsonObject.addProperty("successMsg", "Thêm sản phẩm " + productName + " vào giỏ hàng thành công!");
                    String json = new Gson().toJson(jsonObject);
                    resp.getWriter().write(json);
                    return;
                }
            }

            // add new to database if it does not have product
            CartDetails cartDetails = new CartDetails();
            cartDetails.setQuantity(quantity);
            cartDetails.setProduct(product);
            cartDetails.setCart(cart);
            // save to database
            cartDetailsService.saveCartDetails(cartDetails);

            // send success message and cart size to client
            jsonObject.addProperty("checkCart", listCD.size() + 1);
            jsonObject.addProperty("successMsg", "Thêm sản phẩm " + productName + " vào giỏ hàng thành công!");
            String json = new Gson().toJson(jsonObject);
            resp.getWriter().write(json);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void destroy() {
        // shut down jpa config when servlet is destroyed
        JPAConfig.shutdown();
    }
}
