package com.web.laptoptg.filter;

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
import jakarta.servlet.*;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class AuthorizeFilter implements Filter {
    private CartService cartService = new CartServiceImpl();
    private CartDetailsService cartDetailsService =  new CartDetailsServiceImpl();
    private ProductService productService = new ProductServiceImpl();

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        Filter.super.init(filterConfig);
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("loginUser"); // get user from session
        session.removeAttribute("loginUser");
        if (user != null) { // check user exist
            session.setAttribute("account", user);
            if (user.getRole().equals("ADMIN") || user.getRole().equals("SALER")) { // check role and redirect to appropriate page
                response.sendRedirect(request.getContextPath() + "/admin/home");
                return;
            }

            // check cookie and update user's cart in database
            Cookie[] cookies = request.getCookies();
            List<ItemDTO> itemList = loadCookies(cookies);
            Cart cart = cartService.getCartByUserId(user.getId());
            List<CartDetails> listCD = cartDetailsService.getCartDetailsByCart(cart.getId());

            // check both cookie and database don't have product
            if(itemList.isEmpty() && listCD.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }

            if (itemList.isEmpty()) {
                // add list product to cookie if cookie is not exist
                addProductToCookie(cookies, listCD, response);
            } else {
                updateCart(itemList, listCD, cart);
                List<CartDetails> tempList = cartDetailsService.getCartDetailsByCart(cart.getId());
                // add list product to cookie if cookie is not exist
                addProductToCookie(cookies, tempList, response);
            }

            // redirect to home page
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // else redirect to login page
        response.sendRedirect(request.getContextPath() + "/home");
    }

    private void updateCart(List<ItemDTO> list, List<CartDetails> cartDetailsList, Cart cart) {

        // Create a map to quickly find CartDetails by product ID
        Map<Integer, CartDetails> cartDetailsMap = cartDetailsList.stream()
                .collect(Collectors.toMap(cd -> cd.getProduct().getId(), cd -> cd));

        // Iterator to safely remove items from the list
        Iterator<ItemDTO> iterator = list.iterator();
        while (iterator.hasNext()) {
            ItemDTO item = iterator.next();
            CartDetails cartDetails = cartDetailsMap.get(item.getProduct().getId());

            if (cartDetails != null) {
                cartDetails.setQuantity(item.getQuantity() + cartDetails.getQuantity());
                cartDetailsService.updateCartDetails(cartDetails);
                iterator.remove();
            }
        }

        // Add remaining new products to the cart
        for (ItemDTO item : list) {
            CartDetails newCartDetails = new CartDetails();
            newCartDetails.setQuantity(item.getQuantity());
            newCartDetails.setProduct(item.getProduct());
            newCartDetails.setCart(cart);
            cartDetailsService.saveCartDetails(newCartDetails);
        }
    }

    private void addProductToCookie(Cookie[] cookies, List<CartDetails> cartDetailsList, HttpServletResponse response) {
        // add product to cookie
        StringBuilder cartContent = new StringBuilder();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("cart")) {
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
            }
        }

        // Update cart content with new product ID and quantity
        for (CartDetails cartDetails : cartDetailsList) {
            if (cartContent.isEmpty()) {
                cartContent = new StringBuilder(cartDetails.getProduct().getId() + ":" + cartDetails.getQuantity()); // Use a separator to distinguish different products
            } else {
                cartContent.append("/").append(cartDetails.getProduct().getId()).append(":").append(cartDetails.getQuantity());
            }
        }
        // Create a new cookie with the updated cart content
        Cookie cartCookie = new Cookie("cart", cartContent.toString());
        cartCookie.setMaxAge(60 * 60 * 24); // Set the cookie to expire in one week

        // Add the cookie to the response
        response.addCookie(cartCookie);
    }

    // load list product from cookie
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
    public void destroy() {
        JPAConfig.shutdown();
    }
}
