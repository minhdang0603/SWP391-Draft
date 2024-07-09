package com.web.laptoptg.dao;

import com.web.laptoptg.model.Rating;

import java.util.List;

public interface RatingDAO {
    Rating findById(int id);
    List<Rating> getRatingByProductIDAndCreateTimeDesc(int productID);
    List<Rating> getRatingByUserIDAndCreateTimeDesc(int userID);
    Rating addRating(Rating rating);

    List<Rating> getAllRatings();
}
