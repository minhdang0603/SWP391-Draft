package com.web.laptoptg.dao.impl;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dao.CartDAO;
import com.web.laptoptg.model.Cart;
import com.web.laptoptg.model.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

public class CartDAOImpl implements CartDAO {

    // get cart
    @Override
    public Cart getCartByUser(User user) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        TypedQuery<Cart> query = entityManager.createQuery("from Cart where user.id = :userId", Cart.class);
        query.setParameter("userId", user.getId());
        Cart cart = null;
        try {
            cart = query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }

        return cart;
    }

    // add cart when new user is created
    @Override
    public void saveCart(Cart cart) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.persist(cart);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
    }

    // update cart total amount
    @Override
    public void updateCart(Cart cart) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.merge(cart);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
    }
}
