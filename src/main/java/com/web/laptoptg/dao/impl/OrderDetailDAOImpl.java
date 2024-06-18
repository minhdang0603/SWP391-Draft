package com.web.laptoptg.dao.impl;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dao.OrderDetailDAO;
import com.web.laptoptg.model.OrderDetails;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class OrderDetailDAOImpl implements OrderDetailDAO {

    EntityManager entityManager;
    EntityTransaction transaction;

    public OrderDetailDAOImpl() {
        entityManager = JPAConfig.getEntityManager();
        transaction = entityManager.getTransaction();
    }

    @Override
    public OrderDetails getOrderDetailById(int id) {
        return entityManager.find(OrderDetails.class, id);
    }

    @Override
    public List<OrderDetails> getOrderDetailsByOrderId(int orderId) {
        TypedQuery<OrderDetails> query = entityManager.createQuery(
                "SELECT od FROM OrderDetails od WHERE od.order.id = :orderId", OrderDetails.class);
        query.setParameter("orderId", orderId);
        return query.getResultList();
    }
    @Override
    public List<OrderDetails> getAllOrderDetail() {
        entityManager.clear();
        TypedQuery<OrderDetails> query = entityManager.createQuery("from OrderDetails p join fetch p.product", OrderDetails.class);
        List<OrderDetails> detailsList = query.getResultList();
        return detailsList;
    }

    @Override
    public OrderDetails saveOrderDetail(OrderDetails orderDetail) {
        try {
            transaction.begin();
            entityManager.persist(orderDetail);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
        return orderDetail;
    }

    @Override
    public OrderDetails updateOrderDetail(OrderDetails orderDetail) {
        try {
            transaction.begin();
            entityManager.merge(orderDetail);
            entityManager.flush();
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
        return orderDetail;
    }
}
