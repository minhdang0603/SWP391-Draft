package com.web.laptoptg;

import com.web.laptoptg.model.Order;
import com.web.laptoptg.model.OrderDetails;
import com.web.laptoptg.model.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.util.ArrayList;
import java.util.List;

public class main {

    public static void main(String[] args) {
        // Tạo EntityManagerFactory từ persistence unit (META-INF/persistence.xml)
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("jdbc");
        EntityManager em = emf.createEntityManager();

        // Bắt đầu transaction
        em.getTransaction().begin();

        // Tạo đối tượng User cho khách hàng và nhân viên bán hàng
        User customer = new User();
        customer.setUserName("Nguyen Van A");
        customer.setUserName("sa");
        customer.setAddress("hy");
        customer.setPassword("160203");
        customer.setRole(null);
        customer.setEmail("nguyenvana@example.com");
        customer.setPhoneNumber("0123456789");
        em.persist(customer);

        User saler = new User();
        saler.setUserName("Le Thi B");
        saler.setUserName("sal");
        saler.setAddress("hn");
        saler.setPassword("1602");
        saler.setRole(null);
        saler.setEmail("lethib@example.com");
        saler.setPhoneNumber("0987654321");
        em.persist(saler);

        // Tạo đối tượng Order
        Order order = new Order();
        order.setAddress("123 Đường ABC, Quận 1, TP. HCM");
        order.setNote("Giao hàng trước 5 giờ chiều");
        order.setUserName("Nguyen Van A");
        order.setOrderDate("2024-05-25");
        order.setDeliverDate("2024-05-26");
        order.setReceiveDate("2024-05-27");
        order.setPhoneNumber("0123456789");
        order.setOrderStatus("Đang xử lý");
        order.setCustomer(customer);
        order.setSaler(saler);

        // Tạo danh sách OrderDetails và thêm vào Order
        List<OrderDetails> orderDetailsList = new ArrayList<>();

        OrderDetails orderDetails1 = new OrderDetails();
        orderDetails1.setProduct(null);
        orderDetails1.setQuantity(10);
        orderDetails1.setUnitPrice(1500);
        orderDetails1.setOrder(order);
        em.persist(orderDetails1);
        orderDetailsList.add(orderDetails1);

        OrderDetails orderDetails2 = new OrderDetails();
        orderDetails2.setProduct(null);
        orderDetails2.setQuantity(8);
        orderDetails2.setUnitPrice(100);
        orderDetails2.setOrder(order);
        em.persist(orderDetails2);
        orderDetailsList.add(orderDetails2);

        order.setOrderDetails(orderDetailsList);

        // Lưu đối tượng Order vào cơ sở dữ liệu
        em.persist(order);

        // Commit transaction
        em.getTransaction().commit();

        // Đóng EntityManager
        em.close();
        emf.close();

        System.out.println("Order đã được lưu vào cơ sở dữ liệu.");
    }
}
