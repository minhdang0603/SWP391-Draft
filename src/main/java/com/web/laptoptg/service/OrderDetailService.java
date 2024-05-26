package com.web.laptoptg.service;

import com.web.laptoptg.model.OrderDetails;
import java.util.List;

public interface OrderDetailService {
    OrderDetails getOrderDetailById(int id);
    List<OrderDetails> getOrderDetailsByOrderId(int orderId);
    void saveOrderDetail(OrderDetails orderDetail);
    void updateOrderDetail(OrderDetails orderDetail);
}
