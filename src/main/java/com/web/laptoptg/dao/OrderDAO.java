package com.web.laptoptg.dao;

import com.web.laptoptg.model.Orders;

import java.util.List;

public interface OrderDAO {
    Orders getOrderById(int id);
    List<Orders> getAllOrders();
    void deleteOrderById(int id);
    List<Orders> searchOrdersByPhone(String phoneNumber);
    Orders updateOrder(Orders order);
    Orders saveOrder(Orders order);
}
