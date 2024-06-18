package com.web.laptoptg.service;

import com.web.laptoptg.model.OrderDetails;
import java.util.List;

public interface OrderDetailService {
    OrderDetails getOrderDetailById(int id);
    List<OrderDetails> getOrderDetailsByOrderId(int orderId);
    OrderDetails saveOrderDetail(OrderDetails orderDetail);
    OrderDetails updateOrderDetail(OrderDetails orderDetail);

    List<OrderDetails> getAllOrderDetail();
}
