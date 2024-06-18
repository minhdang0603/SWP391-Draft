package com.web.laptoptg.service.impl;

import com.web.laptoptg.dao.PaymentDAO;
import com.web.laptoptg.dao.impl.PaymentDAOImpl;
import com.web.laptoptg.model.Payment;
import com.web.laptoptg.service.PaymentService;

import java.util.List;

public class PaymentServiceImpl implements PaymentService {

    private PaymentDAO paymentDAO;

    public PaymentServiceImpl(){paymentDAO = new PaymentDAOImpl();}
    @Override
    public Payment savePayment(Payment payment) {
        return paymentDAO.savePayment(payment);
    }

    @Override
    public List<Payment> getAllPayment() {
        return paymentDAO.getAllPayment();
    }

    @Override
    public Payment updatePayment(Payment payment) {
        return paymentDAO.updatePayment(payment);
    }

    @Override
    public Payment findPaymentByID(int id) {
        return paymentDAO.findPaymentByID(id);
    }

    @Override
    public List<Payment> getPaymentsInRange(String startDateStr, String endDateStr) {
        return paymentDAO.getPaymentsInRange(startDateStr,endDateStr);
    }

    @Override
    public void deleteById(int id) {
        paymentDAO.deleteById(id);
    }
}
