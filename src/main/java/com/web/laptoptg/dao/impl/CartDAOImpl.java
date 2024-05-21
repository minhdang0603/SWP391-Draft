package com.web.laptoptg.dao.impl;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dao.CartDAO;
import com.web.laptoptg.model.Cart;
import com.web.laptoptg.model.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

public class CartDAOImpl implements CartDAO {

    // get cart
    @Override
    public Cart getCartByUser(User user) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        Cart cart = entityManager.find(Cart.class, user);
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
