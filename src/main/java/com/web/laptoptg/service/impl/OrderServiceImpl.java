package com.web.laptoptg.service.impl;

import com.web.laptoptg.dao.OrderDAO;
import com.web.laptoptg.dao.impl.OrderDAOImpl;
import com.web.laptoptg.model.Order;
import com.web.laptoptg.service.OrderService;

import java.util.List;

public class OrderServiceImpl implements OrderService {

    private OrderDAO orderDAO = new OrderDAOImpl();

    @Override
    public Order getOrderById(int id) {
        return orderDAO.getOrderById(id);
    }

    @Override
    public List<Order> getAllOrders() {
        return orderDAO.getAllOrders();
    }

    @Override
    public void deleteOrderById(int id) {
        orderDAO.deleteOrderById(id);
    }

    @Override
    public List<Order> searchOrdersByPhone(String phoneNumber) {
        return orderDAO.searchOrdersByPhone(phoneNumber);
    }

    @Override
    public void updateOrder(Order order) {
        orderDAO.updateOrder(order);
    }

    @Override
    public void saveOrder(Order order) {
        orderDAO.saveOrder(order);
    }
}
