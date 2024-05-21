package com.web.laptoptg.model;

import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "order")
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "address")
    private String address;

    @Column(name = "note")
    private String note;

    @Column(name = "user_nam")
    private String userName;

    @Column(name = "oder_date")
    private String orderDate;

    @Column(name = "deliver_date")
    private String deliverDate;

    @Column(name = "receive_date")
    private String receiveDate;

    @Column(name = "phone_number")
    private String phoneNumber;

    @Column(name = "order_status")
    private String orderStatus;

    @OneToMany(mappedBy = "order", fetch = FetchType.LAZY)
    private List<OrderDetails> orderDetails = new ArrayList<>();

    @ManyToOne(optional = true, fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User customer;

    @ManyToOne(optional = true, fetch = FetchType.LAZY)
    @JoinColumn(name = "saler_id")
    private User saler;

    public Order() {
    }

    public Order(int id, String address, String note, String userName, String orderDate, String deliverDate, String receiveDate, String phoneNumber, String orderStatus, List<OrderDetails> orderDetails, User customer, User saler) {
        this.id = id;
        this.address = address;
        this.note = note;
        this.userName = userName;
        this.orderDate = orderDate;
        this.deliverDate = deliverDate;
        this.receiveDate = receiveDate;
        this.phoneNumber = phoneNumber;
        this.orderStatus = orderStatus;
        this.orderDetails = orderDetails;
        this.customer = customer;
        this.saler = saler;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public String getDeliverDate() {
        return deliverDate;
    }

    public void setDeliverDate(String deliverDate) {
        this.deliverDate = deliverDate;
    }

    public String getReceiveDate() {
        return receiveDate;
    }

    public void setReceiveDate(String receiveDate) {
        this.receiveDate = receiveDate;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public List<OrderDetails> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetails> orderDetails) {
        this.orderDetails = orderDetails;
    }

    public User getCustomer() {
        return customer;
    }

    public void setCustomer(User customer) {
        this.customer = customer;
    }

    public User getSaler() {
        return saler;
    }

    public void setSaler(User saler) {
        this.saler = saler;
    }
}
