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

@WebServlet(urlPatterns = "/checkout-page")
public class CheckoutController extends HttpServlet {
    private ProductService productService;

    @Override
    public void init() throws ServletException {
        productService = new ProductServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();

        // check if the flow come from checkout button in cart page
        String fromCart = (String) session.getAttribute("fromCart");

        // redirect to cart page if not
        if (fromCart == null || !fromCart.equals("fromCart")) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        session.removeAttribute("fromCart");

        // redirect to login page if user is not logging in
        UserDTO account = (UserDTO) session.getAttribute("account");
        if(account == null){
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // load cookie
        List<Product> products = productService.getAllProducts();
        Cookie[] cookies = req.getCookies();
        CartDTO cartDTO = loadCookies(cookies, products);
        List<ItemDTO> items = cartDTO.getItems();

        // check product stock unit and quantity in cart
        for (ItemDTO item : items) {

            // show error message when quantity > stock unit
            if (item.getQuantity() > item.getProduct().getStockUnit()) {
                session.setAttribute("quantityError", "Số lượng sản phẩm " + item.getProduct().getProductName() + " trong kho không đủ!");

                // using javascript to forward to cart page
                resp.setContentType("text/html;charset=UTF-8");
                PrintWriter out = resp.getWriter();
                out.println("<html><head>");
                out.println("<script>window.location.href='" + req.getContextPath() + "/cart';</script>");
                out.println("</head><body></body></html>");
                return;
            }
        }

        // forward to checkout page
        req.setAttribute("cart", items);
        req.setAttribute("total", cartDTO.getTotal());
        req.getRequestDispatcher("customer/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getSession().setAttribute("fromCart", "fromCart");
        // validate user to avoid they go straight forward to checkout page
        resp.sendRedirect(req.getContextPath() + "/checkout-page");
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
    public void destroy() {
        JPAConfig.shutdown();
    }
}
