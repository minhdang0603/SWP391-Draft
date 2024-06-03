package com.web.laptoptg.dao.impl;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dao.OrderDetailDAO;
import com.web.laptoptg.model.OrderDetails;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class OrderDetailDAOImpl implements OrderDetailDAO {

    @Override
    public OrderDetails getOrderDetailById(int id) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        try {
            return entityManager.find(OrderDetails.class, id);
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }

        }
    }

    @Override
    public List<OrderDetails> getOrderDetailsByOrderId(int orderId) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        try {
            TypedQuery<OrderDetails> query = entityManager.createQuery(
                    "SELECT od FROM OrderDetails od WHERE od.order.id = :orderId", OrderDetails.class);
            query.setParameter("orderId", orderId);
            return query.getResultList();
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
            JPAConfig.shutdown();
        }
    }

    @Override
    public void saveOrderDetail(OrderDetails orderDetail) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.persist(orderDetail);
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
    public void updateOrderDetail(OrderDetails orderDetail) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.merge(orderDetail);
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
