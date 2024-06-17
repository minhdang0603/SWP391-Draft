package com.web.laptoptg.dao.impl;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dao.OrderDAO;
import com.web.laptoptg.model.Orders;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class OrderDAOImpl implements OrderDAO {

    EntityManager entityManager;
    EntityTransaction transaction;

    public OrderDAOImpl() {
        entityManager = JPAConfig.getEntityManager();
        transaction = entityManager.getTransaction();
    }

    @Override
    public Orders getOrderById(int id) {
            return entityManager.find(Orders.class, id);
    }

    @Override
    public List<Orders> getAllOrders() {
        entityManager.clear();
        TypedQuery<Orders> query = entityManager.createQuery(
                "SELECT DISTINCT o FROM Orders o " +
                        "LEFT JOIN FETCH o.saler " +
                        "LEFT JOIN FETCH o.payment " +
                        "LEFT JOIN FETCH o.orderDetails od " +
                        "LEFT JOIN FETCH o.customer", Orders.class);
        return query.getResultList();
    }

    @Override
    public void deleteOrderById(int id) {
        try {
            transaction.begin();
            Orders order = entityManager.find(Orders.class, id);
            if (order != null) {
                entityManager.remove(order);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    @Override
    public List<Orders> searchOrdersByPhone(String phoneNumber) {
            TypedQuery<Orders> query = entityManager.createQuery(
                    "SELECT o FROM Orders o WHERE o.phoneNumber = :phoneNumber", Orders.class);
            query.setParameter("phoneNumber", phoneNumber);
            return query.getResultList();
    }

    @Override
    public void updateOrder(Orders order) {
        try {
            transaction.begin();
            entityManager.merge(order);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    @Override
    public void saveOrder(Orders order) {
        try {
            transaction.begin();
            entityManager.persist(order);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }
}
