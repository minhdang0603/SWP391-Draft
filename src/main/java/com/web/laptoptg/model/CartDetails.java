package com.web.laptoptg.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "cart_details")
@Data //toString()
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class CartDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "quantity")
    private int quantity;

    @ManyToOne(
            fetch = FetchType.EAGER,
            cascade = {CascadeType.MERGE, CascadeType.REFRESH, CascadeType.DETACH}
    )
    @JoinColumn(name = "cart_id")
    private Cart cart;

    @ManyToOne(
            fetch = FetchType.EAGER,
            cascade = {CascadeType.MERGE, CascadeType.REFRESH, CascadeType.DETACH}
    )
    @JoinColumn(name = "product_id")
    private Product product;
}
