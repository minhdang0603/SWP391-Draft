package com.web.laptoptg.controller.customer;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dto.UserDTO;
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

@WebServlet(urlPatterns = "/rating-process")
public class RatingController extends HttpServlet {

    private RatingService ratingService;
    private ProductService productService;

    @Override
    public void init() throws ServletException {
        super.init();
        ratingService = new RatingServiceImpl();
        productService = new ProductServiceImpl();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDTO account = (UserDTO)req.getSession().getAttribute("account");
        String productId = req.getParameter("productId");
        String review = req.getParameter("review");
        String ratings = req.getParameter("rating");
        int ratingScore = Integer.parseInt(ratings);
        LocalDateTime createDate = LocalDateTime.now();
        Rating rating = new Rating();
        rating.setRatingScore(ratingScore);
        rating.setUser(account.toUser());
        rating.setProduct(productService.findProductById(Integer.parseInt(productId)));
        rating.setContent(review);
        rating.setCreateTime(createDate);
        ratingService.addRating(rating);
        resp.sendRedirect(req.getContextPath() + "/product-detail?pid=" + productId);
    }

    @Override
    public void destroy() {
        JPAConfig.shutdown();
    }
}
