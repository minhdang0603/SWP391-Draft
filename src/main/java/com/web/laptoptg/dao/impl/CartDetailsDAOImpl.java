package com.web.laptoptg.dao.impl;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dao.CartDetailsDAO;
import com.web.laptoptg.model.CartDetails;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class CartDetailsDAOImpl implements CartDetailsDAO {

    // Save CartDetails
    @Override
    public void saveCartDetails(CartDetails cartDetails) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.persist(cartDetails);
            transaction.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (transaction.isActive()) {
                transaction.rollback();
            }
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
            JPAConfig.shutdown();
        }
    }

    // Delete CartDetails
    @Override
    public void deleteCartDetails(CartDetails cartDetails) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            if (!entityManager.contains(cartDetails)) {
                cartDetails = entityManager.merge(cartDetails);
            }
            entityManager.remove(cartDetails);
            transaction.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (transaction.isActive()) {
                transaction.rollback();
            }
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
            JPAConfig.shutdown();
        }
    }

    // Delete all CartDetails by cartId
    @Override
    public void deleteAll(int cartId) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.createQuery("delete from CartDetails where cart.id = :cartId")
                    .setParameter("cartId", cartId)
                    .executeUpdate();
            transaction.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (transaction.isActive()) {
                transaction.rollback();
            }
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
            JPAConfig.shutdown();
        }
    }

    // Get all CartDetails by cartId
    @Override
    public List<CartDetails> getCartDetailsByCart(int cartId) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        try {
            TypedQuery<CartDetails> query = entityManager.createQuery("from CartDetails where cart.id = :cartId", CartDetails.class);
            query.setParameter("cartId", cartId);
            return query.getResultList();
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
            JPAConfig.shutdown();
        }
    }

    // Update CartDetails
    @Override
    public void updateCartDetails(CartDetails cartDetails) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.merge(cartDetails);
            transaction.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (transaction.isActive()) {
                transaction.rollback();
            }
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
            JPAConfig.shutdown();
        }
    }

    // Get CartDetails by cartId and productId
    @Override
    public CartDetails getCartDetailsByCartAndProduct(int cartId, int productId) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        try {
            TypedQuery<CartDetails> query = entityManager.createQuery("from CartDetails where cart.id = :cartId and product.id = :productId", CartDetails.class);
            query.setParameter("cartId", cartId);
            query.setParameter("productId", productId);
            return query.getSingleResult();
        } catch (NoResultException e) {
            e.printStackTrace();
            return null;
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }

        }
    }
}
