package com.web.laptoptg.service.impl;

import com.web.laptoptg.dao.OrderDetailDAO;
import com.web.laptoptg.dao.impl.OrderDetailDAOImpl;
import com.web.laptoptg.model.OrderDetails;
import com.web.laptoptg.service.OrderDetailService;

import java.util.List;

public class OrderDetailServiceImpl implements OrderDetailService {

    private OrderDetailDAO orderDetailDAO = new OrderDetailDAOImpl();

    @Override
    public OrderDetails getOrderDetailById(int id) {
        return orderDetailDAO.getOrderDetailById(id);
    }

    @Override
    public List<OrderDetails> getOrderDetailsByOrderId(int orderId) {
        return orderDetailDAO.getOrderDetailsByOrderId(orderId);
    }

    @Override
    public void saveOrderDetail(OrderDetails orderDetail) {
        orderDetailDAO.saveOrderDetail(orderDetail);
    }

    @Override
    public void updateOrderDetail(OrderDetails orderDetail) {
        orderDetailDAO.updateOrderDetail(orderDetail);
    }
}
