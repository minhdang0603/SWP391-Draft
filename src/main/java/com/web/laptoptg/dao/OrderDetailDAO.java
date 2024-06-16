package com.web.laptoptg.dao;

import com.web.laptoptg.model.OrderDetails;
import java.util.List;

public interface OrderDetailDAO {
    OrderDetails getOrderDetailById(int id);
    List<OrderDetails> getOrderDetailsByOrderId(int orderId);
    void saveOrderDetail(OrderDetails orderDetail);
    void updateOrderDetail(OrderDetails orderDetail);
    List<OrderDetails> getAllOrderDetail();
}
