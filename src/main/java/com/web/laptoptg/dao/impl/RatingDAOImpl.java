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
    @Override
    public Rating findById(int id) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        try {
            return entityManager.find(Rating.class, id);
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }

        }
    }

    @Override
    public List<Rating> getRatingByProductIDAndCreateTimeDesc(int productID) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        try {
            TypedQuery<Rating> query = entityManager.createQuery(
                    "FROM Rating r WHERE r.product.id = :productID ORDER BY r.createTime DESC", Rating.class);
            query.setParameter("productID", productID);
            return query.getResultList();
        } catch (NoResultException e) {
            e.printStackTrace();
            return null;
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
            JPAConfig.shutdown();
        }
    }

    @Override
    public List<Rating> getRatingByUserIDAndCreateTimeDesc(int userID) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        try {
            TypedQuery<Rating> query = entityManager.createQuery(
                    "FROM Rating r WHERE r.user.id = :userID ORDER BY r.createTime DESC", Rating.class);
            query.setParameter("userID", userID);
            return query.getResultList();
        } catch (NoResultException e) {
            e.printStackTrace();
            return null;
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
            JPAConfig.shutdown();
        }
    }

    @Override
    public void addRating(Rating rating) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.persist(rating);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
            JPAConfig.shutdown();
        }
    }

    @Override
    public void updateRating(Rating rating) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.merge(rating);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
            JPAConfig.shutdown();
        }
    }

    @Override
    public void deleteRating(Rating rating) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.remove(entityManager.merge(rating));
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
            JPAConfig.shutdown();
        }
    }
}
