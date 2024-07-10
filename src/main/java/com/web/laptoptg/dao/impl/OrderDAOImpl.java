package com.web.laptoptg.dao.impl;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dao.OrderDAO;
import com.web.laptoptg.model.Orders;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
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
                        //"LEFT JOIN FETCH o.orderDetails od " +
                        "LEFT JOIN FETCH o.customer", Orders.class);
        return query.getResultList();
    }

    @Override
    public void deleteOrder(Orders order) {
        try {
            transaction.begin();
            // Ensure the entity is managed before removing
            if (!entityManager.contains(order)) {
                order = entityManager.merge(order);
            }
                entityManager.remove(order);
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
        entityManager.clear();
        TypedQuery<Orders> query = entityManager.createQuery(
                "SELECT o FROM Orders o WHERE o.phoneNumber = :phoneNumber", Orders.class);
        query.setParameter("phoneNumber", phoneNumber);
        return query.getResultList();
    }
    @Override
    public List<Orders> searchOrdersByCusID(int id) {
        List<Orders> result;
        try {
            TypedQuery<Orders> query = entityManager.createQuery(
                    "SELECT o FROM Orders o " +
                            " JOIN fetch o.orderDetails"+
                            " where o.saler.id = :id", Orders.class);
            query.setParameter("id", id);
            result = query.getResultList();
        } catch (NoResultException ex) {
            ex.printStackTrace();
            result = null;
        }
        return result;
    }

    @Override
    public Orders updateOrder(Orders order) {
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
        return order;
    }

    @Override
    public Orders saveOrder(Orders order) {
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
        return order;
    }

    @Override
    public List<Orders> getOrderdByCustomerIDAndStatus(int cid, String status) {
        entityManager.clear();
        try {
            TypedQuery<Orders> orders = entityManager.createQuery("from Orders o join fetch o.orderDetails where o.customer.id = :cid and o.orderStatus = :status order by o.orderDate desc", Orders.class);
            orders.setParameter("cid", cid);
            orders.setParameter("status", status);
            return orders.getResultList();
        } catch (NoResultException ex){
            ex.printStackTrace();
            return null;
        }
    }
}
