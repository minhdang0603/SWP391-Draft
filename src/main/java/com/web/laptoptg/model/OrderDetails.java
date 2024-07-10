package com.web.laptoptg.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "order_details")
@Data //toString()
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class OrderDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "unit_price")
    private long unitPrice;

    @Column(name = "quantity")
    private int quantity;

    @ManyToOne(fetch = FetchType.EAGER, cascade = {CascadeType.MERGE, CascadeType.REFRESH, CascadeType.DETACH})
    @JoinColumn(name = "order_id")
    private Orders order;

    @ManyToOne(fetch = FetchType.EAGER, cascade = {CascadeType.MERGE, CascadeType.REFRESH, CascadeType.DETACH})
    @JoinColumn(name = "product_id")
    private Product product;

    @Column(name = "product_name")
    private String productName;

    @Column(name = "maintenance")
    private String maintenance;

    @Column(name = "image")
    private String image;

    @Column(name = "rated_status")
    private boolean isRated;
}
