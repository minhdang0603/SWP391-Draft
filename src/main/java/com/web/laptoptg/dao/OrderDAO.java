package com.web.laptoptg.dao;

import com.web.laptoptg.model.Orders;

import java.util.List;

public interface OrderDAO {
    Orders getOrderById(int id);
    List<Orders> getAllOrders();
    void deleteOrder(Orders order);
    List<Orders> searchOrdersByPhone(String phoneNumber);
    Orders updateOrder(Orders order);
    Orders saveOrder(Orders order);
    List<Orders> getOrderdByCustomerIDAndStatus(int cid, String status);

    List<Orders> searchOrdersByCusID(int id);
}
