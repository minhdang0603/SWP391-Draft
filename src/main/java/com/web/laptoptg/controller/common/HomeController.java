package com.web.laptoptg.controller.common;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.config.Status;
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
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

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
        Cookie[] cookies = req.getCookies(); // get cookie from request
        List<Product> products = productService.getAllProducts(); // get all product from database
        List<Category> categories = categoryService.getAllCategory(); // get all categories from database
        List<ItemDTO> items = loadCookies(cookies, products); // load cart from cookie

        // set target categories
        List<Integer> targetCategoryIds = Arrays.asList(1, 3, 4);

        // filter all categories by target categories
        List<Category> filteredCategories = categories.stream()
                .filter(category -> targetCategoryIds.contains(category.getId()))
                .collect(Collectors.toList());

        // filter products by filtered categories and status
        List<List<Product>> list = filteredCategories.stream()
                .map(category -> products.stream()
                        .filter(product -> product.getCategory().equals(category))
                        .filter(product -> product.getStatus().equals(Status.ACTIVE))
                        .limit(5)
                        .collect(Collectors.toList()))
                .collect(Collectors.toList());

        // get 6 product order by sold unit
        List<Product> topSelling = products.stream()
                .sorted((p1, p2) -> Integer.compare(p2.getSoldUnit(), p1.getSoldUnit()))
                .limit(5)
                .collect(Collectors.toList());

        // send data to client and redirect to home page
        req.setAttribute("categories", categories);
        req.setAttribute("list", list);
        req.setAttribute("listSoldUnit", topSelling);
        req.getSession().setAttribute("checkCart", items.size());
        req.getRequestDispatcher("common/home-index.jsp").forward(req, resp);
    }

    private List<ItemDTO> loadCookies(Cookie[] cookies, List<Product> products) {
        StringBuilder cartContent = new StringBuilder();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("cart")) {
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

    @Override
    public void destroy() {
        JPAConfig.shutdown();
    }
}
