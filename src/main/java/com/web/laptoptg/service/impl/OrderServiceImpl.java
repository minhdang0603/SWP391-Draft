package com.web.laptoptg.service.impl;

import com.web.laptoptg.dao.OrderDAO;
import com.web.laptoptg.dao.impl.OrderDAOImpl;
import com.web.laptoptg.model.Orders;
import com.web.laptoptg.model.Product;
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
    public void deleteOrder(Orders product) {
        orderDAO.deleteOrder(product);
    }

    @Override
    public List<Orders> searchOrdersByPhone(String phoneNumber) {
        return orderDAO.searchOrdersByPhone(phoneNumber);
    }

    @Override
    public List<Orders> searchOrdersByCusID(int id) {return  orderDAO.searchOrdersByCusID(id);}

    @Override
    public Orders updateOrder(Orders order) {
        return orderDAO.updateOrder(order);
    }

    @Override
    public Orders saveOrder(Orders order) {
        return orderDAO.saveOrder(order);
    }

    @Override
    public List<Orders> getOrdersByUserIDAndStatus(int cid, String status) {
        return orderDAO.getOrderdByCustomerIDAndStatus(cid, status);
    }
}
