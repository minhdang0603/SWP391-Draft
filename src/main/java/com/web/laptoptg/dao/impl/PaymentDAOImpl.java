package com.web.laptoptg.dao.impl;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dao.PaymentDAO;
import com.web.laptoptg.model.Payment;
import com.web.laptoptg.model.Product;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class PaymentDAOImpl implements PaymentDAO {

    EntityManager entityManager;
    EntityTransaction transaction;

    public PaymentDAOImpl(){
        entityManager = JPAConfig.getEntityManager();
        transaction = entityManager.getTransaction();
    }
    @Override
    public Payment savePayment(Payment payment) {
        try {
            transaction.begin();
            entityManager.persist(payment);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
        return payment;
    }

    @Override
    public List<Payment> getAllPayment() {
        entityManager.clear();
        TypedQuery<Payment> query = entityManager.createQuery("from Payment p", Payment.class);
        List<Payment> paymentList = query.getResultList();
        return paymentList;
    }

    @Override
    public Payment updatePayment(Payment payment) {
        try {
            transaction.begin();
            entityManager.merge(payment);
            entityManager.flush();
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
        return payment;
    }

    @Override
    public Payment findPaymentByID(int id) {
        entityManager.clear();
        return entityManager.find(Payment.class, id);
    }

    @Override
    public List<Payment> getPaymentsInRange(String startDateStr, String endDateStr) {
        entityManager.clear();

        // Chuyển đổi String thành Date
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date startDate = null;
        Date endDate = null;
        try {
            startDate = dateFormat.parse(startDateStr);
            endDate = dateFormat.parse(endDateStr);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        TypedQuery<Payment> query = entityManager.createQuery(
                "from Payment p where p.paymentDate >= :startDate and p.paymentDate <= :endDate", Payment.class);
        query.setParameter("startDate", startDate);
        query.setParameter("endDate", endDate);
        List<Payment> paymentList = query.getResultList();
        return paymentList;
    }

    @Override
    public void deleteById(int id) {
        try {
            transaction.begin();
            Payment pro = entityManager.find(Payment.class, id);
            if (pro != null) {
                entityManager.remove(pro);
                transaction.commit();
            }
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }
}
