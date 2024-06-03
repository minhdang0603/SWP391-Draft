package com.web.laptoptg.dao.impl;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dao.OrderDAO;
import com.web.laptoptg.model.Order;
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
    public Order getOrderById(int id) {
            return entityManager.find(Order.class, id);
    }

    @Override
    public List<Order> getAllOrders() {
            TypedQuery<Order> query = entityManager.createQuery("FROM Order o join fetch o.customer join fetch o.saler", Order.class);
            return query.getResultList();
    }

    @Override
    public void deleteOrderById(int id) {
        try {
            transaction.begin();
            Order order = entityManager.find(Order.class, id);
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
    public List<Order> searchOrdersByPhone(String phoneNumber) {
            TypedQuery<Order> query = entityManager.createQuery(
                    "SELECT o FROM Order o WHERE o.phoneNumber = :phoneNumber", Order.class);
            query.setParameter("phoneNumber", phoneNumber);
            return query.getResultList();
    }

    @Override
    public void updateOrder(Order order) {
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
    public void saveOrder(Order order) {
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
