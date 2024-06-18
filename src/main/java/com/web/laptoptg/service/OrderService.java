package com.web.laptoptg.service;

import com.web.laptoptg.model.Orders;

import java.util.List;

public interface OrderService {
    Orders getOrderById(int id);
    List<Orders> getAllOrders();
    void deleteOrderById(int id);
    List<Orders> searchOrdersByPhone(String phoneNumber);
    Orders updateOrder(Orders order);
    Orders saveOrder(Orders order);
}
