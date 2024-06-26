package com.web.laptoptg.model;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Entity
@Table(name = "orders")
@Data //toString()
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Orders {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "address")
    private String address;

    @Column(name = "note")
    private String note;

    @Column(name = "user_name")
    private String userName;

    @Column(name = "order_date")
    private LocalDateTime orderDate;

    @Column(name = "deliver_date")
    private LocalDateTime deliverDate;//local datetime

    @Column(name = "receive_date")
    private LocalDateTime receiveDate;//local datetime

    @Column(name = "phone_number")
    private String phoneNumber;

    @Column(name = "order_status")
    private String orderStatus;

    @OneToMany(mappedBy = "order", fetch = FetchType.LAZY, cascade = {CascadeType.MERGE, CascadeType.REFRESH, CascadeType.DETACH})
    private List<OrderDetails> orderDetails;

    @ManyToOne(optional = true, fetch = FetchType.EAGER, cascade = {CascadeType.MERGE, CascadeType.REFRESH, CascadeType.DETACH})
    @JoinColumn(name = "user_id")
    private User customer;

    @ManyToOne(optional = true, fetch = FetchType.EAGER, cascade = {CascadeType.MERGE, CascadeType.REFRESH, CascadeType.DETACH})
    @JoinColumn(name = "saler_id")
    private User saler;

    @OneToOne(fetch = FetchType.EAGER, cascade = {CascadeType.MERGE, CascadeType.REFRESH, CascadeType.DETACH})
    @JoinColumn(name = "payment_id")
    private Payment payment;

    public String getFormattedDeliverDate() {
        String date ="";
        if(deliverDate==null){
            return date;
        }
        date = deliverDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss"));
        return date;
    }

    public String getFormattedReceiveDate() {
        String date ="";
        if(receiveDate==null){
            return date;
        }
        date = receiveDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss"));
        return date;
    }

    public String getFormattedOrderDate() {
        return orderDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss"));
    }
}
