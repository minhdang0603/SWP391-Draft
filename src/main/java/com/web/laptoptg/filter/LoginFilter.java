package com.web.laptoptg.filter;

import com.web.laptoptg.dto.CartDTO;
import com.web.laptoptg.dto.ItemDTO;
import com.web.laptoptg.dto.UserDTO;
import com.web.laptoptg.model.Cart;
import com.web.laptoptg.model.CartDetails;
import com.web.laptoptg.model.Product;
import com.web.laptoptg.model.User;
import com.web.laptoptg.service.CartDetailsService;
import com.web.laptoptg.service.CartService;
import com.web.laptoptg.service.ProductService;
import com.web.laptoptg.service.UserService;
import com.web.laptoptg.service.impl.CartDetailsServiceImpl;
import com.web.laptoptg.service.impl.CartServiceImpl;
import com.web.laptoptg.service.impl.ProductServiceImpl;
import com.web.laptoptg.service.impl.UserServiceImpl;
import jakarta.servlet.*;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

public class LoginFilter implements Filter {
    private CartService cartService = new CartServiceImpl();
    private CartDetailsService cartDetailsService =  new CartDetailsServiceImpl();
    private ProductService productService = new ProductServiceImpl();
    private UserService userService = new UserServiceImpl();

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        Filter.super.init(filterConfig);
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("account"); // get user from session
        if (user != null) { // check user exist
            if (user.getRole().equals("ADMIN") || user.getRole().equals("SALER")) { // check role and redirect to appropriate page
                response.sendRedirect(request.getContextPath() + "/admin/home");
                return;
            }

            // check cookie and update user's cart in database
            Cookie[] cookies = request.getCookies();
            List<ItemDTO> itemList = loadCookies(cookies);
            User temp = userService.findUserByEmail(user.getEmail());
            Cart cart = cartService.getCartByUser(temp);
            session.setAttribute("cart", cart);
            List<CartDetails> cartDetailsList = cart.getCartDetailsList();
            if (itemList.isEmpty()) {
                addProductToCookie(cookies, cartDetailsList, response);
            } else {
                updateCart(itemList, cart);
            }
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // else redirect to login page
        request.getRequestDispatcher("common/login.jsp").forward(request, response);
    }

    // update cart when user login
    private void updateCart(List<ItemDTO> list, Cart cart) {
        for (ItemDTO item : list) {
            CartDetails cartDetails = cartDetailsService.getCartDetailsByCartAndProduct(cart.getId(), item.getProduct().getId());
            if (cartDetails != null) {
                cartDetails.setQuantity(item.getQuantity());
                cartDetailsService.updateCartDetails(cartDetails);
            } else {
                cartDetails = new CartDetails();
                cartDetails.setQuantity(item.getQuantity());
                cartDetails.setProduct(item.getProduct());
                cartDetails.setCart(cart);
                cartDetailsService.saveCartDetails(cartDetails);
            }
        }
    }

    // add list product to cookie if cookie is not exist
    private void addProductToCookie(Cookie[] cookies, List<CartDetails> cartDetailsList, HttpServletResponse response) {
        StringBuilder cartContent = new StringBuilder();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("cart")) {
                    cartContent.append(cookie.getValue());
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
            }
        }
        for (CartDetails cartDetails : cartDetailsList) {
            // Update cart content with new product ID and quantity
            if (cartContent.length() == 0) {
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
        Filter.super.destroy();
    }
}
