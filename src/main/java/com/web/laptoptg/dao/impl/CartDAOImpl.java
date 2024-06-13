package com.web.laptoptg.dao.impl;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dao.CartDAO;
import com.web.laptoptg.model.Cart;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

public class CartDAOImpl implements CartDAO {

    EntityManager entityManager;
    EntityTransaction transaction;

    public CartDAOImpl() {
        entityManager = JPAConfig.getEntityManager();
        transaction = entityManager.getTransaction();
    }

    // Get Cart by User
    @Override
    public Cart getCartByUserId(int userId) {
        TypedQuery<Cart> query = entityManager.createQuery("from Cart c join fetch c.user where c.user.id = :userId", Cart.class);
        query.setParameter("userId", userId);
        Cart cart = null;
        try {
            cart = query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
        return cart;
    }

    // Save Cart when a new user is created
    @Override
    public void saveCart(Cart cart) {
        try {
            transaction.begin();
            entityManager.persist(cart);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    // Update Cart total amount
    @Override
    public void updateCart(Cart cart) {
        try {
            transaction.begin();
            entityManager.merge(cart);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }
}
