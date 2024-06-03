package com.web.laptoptg.dao.impl;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dao.OrderDAO;
import com.web.laptoptg.model.Order;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class OrderDAOImpl implements OrderDAO {

    @Override
    public Order getOrderById(int id) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        try {
            return entityManager.find(Order.class, id);
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }

        }
    }

    @Override
    public List<Order> getAllOrders() {
        EntityManager entityManager = JPAConfig.getEntityManager();
        try {
            TypedQuery<Order> query = entityManager.createQuery("SELECT o FROM Order o", Order.class);
            return query.getResultList();
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
            JPAConfig.shutdown();
        }
    }

    @Override
    public void deleteOrderById(int id) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
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
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
            JPAConfig.shutdown();
        }
    }

    @Override
    public List<Order> searchOrdersByPhone(String phoneNumber) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        try {
            TypedQuery<Order> query = entityManager.createQuery(
                    "SELECT o FROM Order o WHERE o.phoneNumber = :phoneNumber", Order.class);
            query.setParameter("phoneNumber", phoneNumber);
            return query.getResultList();
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
            JPAConfig.shutdown();
        }
    }

    @Override
    public void updateOrder(Order order) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.merge(order);
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
    public void saveOrder(Order order) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.persist(order);
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
