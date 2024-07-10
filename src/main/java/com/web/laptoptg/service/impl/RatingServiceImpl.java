package com.web.laptoptg.service.impl;

import com.web.laptoptg.dao.RatingDAO;
import com.web.laptoptg.dao.impl.RatingDAOImpl;
import com.web.laptoptg.model.Rating;
import com.web.laptoptg.service.RatingService;

import java.util.List;

public class RatingServiceImpl implements RatingService {
    private RatingDAO ratingDAO;

    public RatingServiceImpl() {
        ratingDAO = new RatingDAOImpl();
    }

    @Override
    public Rating addRating(Rating rating) {
        return ratingDAO.addRating(rating);
    }

    @Override
    public List<Rating> getRatingByProductIDAndCreateTimeDesc(int productID) {
        return ratingDAO.getRatingByProductIDAndCreateTimeDesc(productID);
    }

    @Override
    public List<Rating> getAllRatings(){
        return ratingDAO.getAllRatings();
    };
    @Override
    public List<Rating> getRatingByUserIDAndCreateTimeDesc(int userID) {
        return ratingDAO.getRatingByUserIDAndCreateTimeDesc(userID);
    }
}
