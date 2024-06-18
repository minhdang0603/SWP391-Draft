package com.web.laptoptg.dao;

import com.web.laptoptg.model.OrderDetails;
import java.util.List;

public interface OrderDetailDAO {
    OrderDetails getOrderDetailById(int id);
    List<OrderDetails> getOrderDetailsByOrderId(int orderId);
    OrderDetails saveOrderDetail(OrderDetails orderDetail);
    OrderDetails updateOrderDetail(OrderDetails orderDetail);
    List<OrderDetails> getAllOrderDetail();
}
