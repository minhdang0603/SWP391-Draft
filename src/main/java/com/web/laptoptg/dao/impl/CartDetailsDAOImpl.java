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

    // insert cart details to database
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
            transaction.rollback();
        } finally {
            entityManager.close();
        }
    }

    // delete cart details
    @Override
    public void deleteCartDetails(CartDetails cartDetails) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.remove(cartDetails);
            transaction.commit();
        } catch (Exception e) {
            e.printStackTrace();
            transaction.rollback();
        } finally {
            entityManager.close();
        }
    }

    // delete all cart details by cart id
    @Override
    public void deleteAll(int cartId) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager
                    .createQuery("delete from CartDetails where cart.id = :cartId") // create query
                    .setParameter("cartId", cartId) //set query parameters
                    .executeUpdate(); // execute query
            transaction.commit();
        } catch (Exception e) {
            e.printStackTrace();
            transaction.rollback();
        } finally {
            entityManager.close();
        }
    }

    // get all cart details by cart id
    @Override
    public List<CartDetails> getCartDetailsByCart(int cartId) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        // create query
        TypedQuery<CartDetails> query = entityManager.createQuery("from CartDetails where cart.id = :cartId", CartDetails.class);

        // set query parameter
        query.setParameter("cartId", cartId);
        // return result list
        return query.getResultList();
    }

    // update cart details
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
            transaction.rollback();
        } finally {
            entityManager.close();
        }
    }

    // get cart details by cart id and product id
    @Override
    public CartDetails getCartDetailsByCartAndProduct(int cartId, int productId) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        CartDetails cartDetails = null;
        TypedQuery<CartDetails> query = entityManager
                .createQuery("from CartDetails where cart.id = :cartId and product.id = :productId", CartDetails.class);
        query.setParameter("cartId", cartId);
        query.setParameter("productId", productId);
        try {
            cartDetails = query.getSingleResult();
        } catch (NoResultException e) {
            e.printStackTrace();
        }
        return cartDetails;
    }
}
