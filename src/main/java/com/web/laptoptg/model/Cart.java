package com.web.laptoptg.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "cart")
@Data //toString()
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Cart {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "total_amount")
    private double totalAmmount;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;
}
