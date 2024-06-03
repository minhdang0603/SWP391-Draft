package com.web.laptoptg.dao.impl;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dao.RatingDAO;
import com.web.laptoptg.model.Rating;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class RatingDAOImpl implements RatingDAO {

    private EntityManager entityManager;
    private EntityTransaction transaction;

    public RatingDAOImpl() {
        entityManager = JPAConfig.getEntityManager();
        transaction = entityManager.getTransaction();
    }
    @Override
    public Rating finbById(int id) {
        return entityManager.find(Rating.class, id);
    }

    @Override
    public List<Rating> getRatingByProductIDAndCreateTimeDesc(int productID) {
        List<Rating> ratings = null;
        TypedQuery<Rating> query = entityManager.createQuery("from Rating r where r.product.id = :productID order by r.createTime desc", Rating.class);
        query.setParameter("productID", productID);
        try {
            ratings = query.getResultList();
        } catch (NoResultException e) {
            e.printStackTrace();
        }
        return ratings;
    }

    @Override
    public List<Rating> getRatingByUserIDAndCreateTimeDesc(int userID) {
        List<Rating> ratings = null;
        TypedQuery<Rating> query = entityManager.createQuery("from Rating r where r.user.id = :userID order by r.createTime desc", Rating.class);
        query.setParameter("userID", userID);
        try {
            ratings = query.getResultList();
        } catch (NoResultException e) {
            e.printStackTrace();
        }
        return ratings;
    }

    @Override
    public void addRating(Rating rating) {
        try {
            transaction.begin();
            entityManager.persist(rating);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public void updateRating(Rating rating) {
        try {
            transaction.begin();
            entityManager.merge(rating);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public void deleteRating(Rating rating) {
        try {
            transaction.begin();
            entityManager.remove(rating);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
    }
}
