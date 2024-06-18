package com.web.laptoptg.service.impl;

import com.web.laptoptg.dao.OrderDetailDAO;
import com.web.laptoptg.dao.impl.OrderDetailDAOImpl;
import com.web.laptoptg.model.OrderDetails;
import com.web.laptoptg.service.OrderDetailService;

import java.util.List;

public class OrderDetailServiceImpl implements OrderDetailService {

    private OrderDetailDAO orderDetailDAO;

    public OrderDetailServiceImpl() {
        orderDetailDAO = new OrderDetailDAOImpl();
    }

    @Override
    public OrderDetails getOrderDetailById(int id) {
        return orderDetailDAO.getOrderDetailById(id);
    }

    @Override
    public List<OrderDetails> getOrderDetailsByOrderId(int orderId) {
        return orderDetailDAO.getOrderDetailsByOrderId(orderId);
    }

    @Override
    public List<OrderDetails> getAllOrderDetail() {
        return orderDetailDAO.getAllOrderDetail();
    }

    @Override
    public OrderDetails saveOrderDetail(OrderDetails orderDetail) {
        return orderDetailDAO.saveOrderDetail(orderDetail);
    }

    @Override
    public OrderDetails updateOrderDetail(OrderDetails orderDetail) {
        return orderDetailDAO.updateOrderDetail(orderDetail);
    }
}
