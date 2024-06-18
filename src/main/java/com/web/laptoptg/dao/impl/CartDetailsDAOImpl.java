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

    EntityManager entityManager;
    EntityTransaction transaction;

    public CartDetailsDAOImpl() {
        entityManager = JPAConfig.getEntityManager();
        transaction = entityManager.getTransaction();
    }

    // Save CartDetails
    @Override
    public CartDetails saveCartDetails(CartDetails cartDetails) {
        try {
            transaction.begin();
            entityManager.persist(cartDetails);
            transaction.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (transaction.isActive()) {
                transaction.rollback();
            }
        }
        return cartDetails;
    }

    // Delete CartDetails
    @Override
    public void deleteCartDetails(CartDetails cartDetails) {
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
        }
    }

    // Delete all CartDetails by cartId
    @Override
    public void deleteAll(int cartId) {
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
        }
    }

    // Get all CartDetails by cartId
    @Override
    public List<CartDetails> getCartDetailsByCart(int cartId) {
        TypedQuery<CartDetails> query = entityManager.createQuery("from CartDetails cd join fetch cd.cart where cd.cart.id = :cartId", CartDetails.class);
        query.setParameter("cartId", cartId);
        return query.getResultList();
    }

    // Update CartDetails
    @Override
    public CartDetails updateCartDetails(CartDetails cartDetails) {
        try {
            transaction.begin();
            entityManager.merge(cartDetails);
            entityManager.flush();
            transaction.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (transaction.isActive()) {
                transaction.rollback();
            }
        }
        return cartDetails;
    }

    // Get CartDetails by cartId and productId
    @Override
    public CartDetails getCartDetailsByCartAndProduct(int cartId, int productId) {
        try {
            TypedQuery<CartDetails> query = entityManager.createQuery("from CartDetails cd join fetch cd.product join fetch cd.cart where cd.cart.id = :cartId and cd.product.id = :productId", CartDetails.class);
            query.setParameter("cartId", cartId);
            query.setParameter("productId", productId);
            return query.getSingleResult();
        } catch (NoResultException e) {
            e.printStackTrace();
            return null;
        }
    }
}
