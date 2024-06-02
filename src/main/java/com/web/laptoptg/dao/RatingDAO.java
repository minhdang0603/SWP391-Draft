package com.web.laptoptg.dao;

import com.web.laptoptg.model.Rating;

import java.util.List;

public interface RatingDAO {
    Rating finbById(int id);
    List<Rating> getRatingByProductIDAndCreateTimeDesc(int productID);
    List<Rating> getRatingByUserIDAndCreateTimeDesc(int userID);
    void addRating(Rating rating);
    void updateRating(Rating rating);
    void deleteRating(Rating rating);
}
