package com.web.laptoptg.controller.customer;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.model.Product;
import com.web.laptoptg.model.Rating;
import com.web.laptoptg.service.ProductService;
import com.web.laptoptg.service.RatingService;
import com.web.laptoptg.service.impl.ProductServiceImpl;
import com.web.laptoptg.service.impl.RatingServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(urlPatterns = "/product-detail")
public class ViewProductDetailController extends HttpServlet {

    private ProductService productService;
    private RatingService ratingService;

    @Override
    public void init() throws ServletException {
        productService = new ProductServiceImpl();
        ratingService = new RatingServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // get product id from client
            int id = Integer.parseInt(req.getParameter("pid"));
            // get product by id from database
            Product pro = productService.findProductById(id);
            List<Rating> ratings = ratingService.getRatingByProductIDAndCreateTimeDesc(pro.getId());
            // get related products by brand
            List<Product> relatedPros = productService.getProductByCateOrderBySoldUnit(pro.getCategory().getId(), 4);

            if(ratings != null) {
                // count rating
                int five = (int) ratings.stream()
                        .filter(rating -> rating.getRatingScore() == 5).count();
                int four = (int) ratings.stream()
                        .filter(rating -> rating.getRatingScore() == 4).count();
                int three = (int) ratings.stream()
                        .filter(rating -> rating.getRatingScore() == 3).count();
                int two = (int) ratings.stream()
                        .filter(rating -> rating.getRatingScore() == 2).count();
                int one = (int) ratings.stream()
                        .filter(rating -> rating.getRatingScore() == 1).count();

                // calculate average rating score
                double averageRating = ratings.stream()
                        .mapToInt(Rating::getRatingScore)
                        .average()
                        .orElse(0.0);
                String formattedAverage = String.format("%.1f", averageRating);

                // send data and redirect to product detail page
                req.setAttribute("fiveStar", five);
                req.setAttribute("fourStar", four);
                req.setAttribute("threeStar", three);
                req.setAttribute("twoStar", two);
                req.setAttribute("oneStar", one);
                req.setAttribute("averageRating", formattedAverage);
            } else {
                req.setAttribute("fiveStar", 0);
                req.setAttribute("fourStar", 0);
                req.setAttribute("threeStar", 0);
                req.setAttribute("twoStar", 0);
                req.setAttribute("oneStar", 0);
                req.setAttribute("averageRating", 0);
            }

            req.setAttribute("ratings", ratings);
            req.setAttribute("relatedProducts", relatedPros);
            req.setAttribute("proDetail", pro);
            req.getRequestDispatcher("customer/product-detail.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    public void destroy() {
        JPAConfig.shutdown();
    }
}
