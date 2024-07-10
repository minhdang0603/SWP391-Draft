package com.web.laptoptg.dao.impl;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dao.RatingDAO;
import com.web.laptoptg.model.Orders;
import com.web.laptoptg.model.Rating;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class RatingDAOImpl implements RatingDAO {

    EntityManager entityManager;
    EntityTransaction transaction;

    public RatingDAOImpl() {
        entityManager = JPAConfig.getEntityManager();
        transaction = entityManager.getTransaction();
    }

    @Override
    public Rating findById(int id) {
            return entityManager.find(Rating.class, id);
    }

    @Override
    public List<Rating> getRatingByProductIDAndCreateTimeDesc(int productID) {
        try {
            TypedQuery<Rating> query = entityManager.createQuery(
                    "FROM Rating r join fetch r.product WHERE r.product.id = :productID ORDER BY r.createTime DESC", Rating.class);
            query.setParameter("productID", productID);
            return query.getResultList();
        } catch (NoResultException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Rating> getRatingByUserIDAndCreateTimeDesc(int userID) {
        try {
            TypedQuery<Rating> query = entityManager.createQuery(
                    "FROM Rating r join fetch r.user WHERE r.user.id = :userID ORDER BY r.createTime DESC", Rating.class);
            query.setParameter("userID", userID);
            return query.getResultList();
        } catch (NoResultException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Rating> getAllRatings(){
        entityManager.clear();
        TypedQuery<Rating> query = entityManager.createQuery(
                "SELECT DISTINCT o FROM Rating o ", Rating.class);
        return query.getResultList();
    }

    @Override
    public Rating addRating(Rating rating) {
        try {
            transaction.begin();
            entityManager.persist(rating);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
        return rating;
    }
}
