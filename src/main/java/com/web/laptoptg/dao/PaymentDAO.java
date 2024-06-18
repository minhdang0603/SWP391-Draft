package com.web.laptoptg.dao;

import com.web.laptoptg.model.Payment;

import java.util.List;

public interface PaymentDAO {
    Payment savePayment (Payment payment);

    List<Payment> getAllPayment();

    Payment updatePayment(Payment payment);

    Payment findPaymentByID(int id);

    List<Payment> getPaymentsInRange(String startDateStr, String endDateStr);

    void deleteById(int id);
}
