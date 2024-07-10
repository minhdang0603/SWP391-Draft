package com.web.laptoptg.service;

import com.web.laptoptg.model.Rating;

import java.util.List;

public interface RatingService {
    Rating addRating(Rating rating);

    List<Rating> getRatingByProductIDAndCreateTimeDesc(int productID);

    List<Rating> getRatingByUserIDAndCreateTimeDesc(int userID);

    List<Rating> getAllRatings();
}
