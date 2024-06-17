package com.web.laptoptg.service.impl;

import com.web.laptoptg.dao.OrderDAO;
import com.web.laptoptg.dao.impl.OrderDAOImpl;
import com.web.laptoptg.model.Orders;
import com.web.laptoptg.service.OrderService;

import java.util.List;

public class OrderServiceImpl implements OrderService {

    private OrderDAO orderDAO = new OrderDAOImpl();

    public OrderServiceImpl() {
        orderDAO = new OrderDAOImpl();
    }

    @Override
    public Orders getOrderById(int id) {
        return orderDAO.getOrderById(id);
    }

    @Override
    public List<Orders> getAllOrders() {
        return orderDAO.getAllOrders();
    }

    @Override
    public void deleteOrderById(int id) {
        orderDAO.deleteOrderById(id);
    }

    @Override
    public List<Orders> searchOrdersByPhone(String phoneNumber) {
        return orderDAO.searchOrdersByPhone(phoneNumber);
    }

    @Override
    public void updateOrder(Orders order) {
        orderDAO.updateOrder(order);
    }

    @Override
    public void saveOrder(Orders order) {
        orderDAO.saveOrder(order);
    }
}
