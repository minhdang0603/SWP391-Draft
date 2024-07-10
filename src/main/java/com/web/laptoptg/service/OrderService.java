package com.web.laptoptg.service;

import com.web.laptoptg.model.Orders;
import com.web.laptoptg.model.Product;

import java.util.List;

public interface OrderService {
    Orders getOrderById(int id);
    List<Orders> getAllOrders();
    void deleteOrder(Orders product);
    List<Orders> searchOrdersByPhone(String phoneNumber);
    Orders updateOrder(Orders order);
    Orders saveOrder(Orders order);
    List<Orders> getOrdersByUserIDAndStatus(int cid, String status);

    List<Orders> searchOrdersByCusID(int id);
}
