package com.web.laptoptg.model;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "product")
@Data //toString()
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "cpu")
    private String cpu;

    @Column(name = "unit_price")
    private long unitPrice;

    @Column(name = "sold_unit")
    private int soldUnit;

    @Column(name = "stock_unit")
    private int stockUnit;

    @Column(name = "battery_vol")
    private String batteryVol;

    @Column(name = "operating_system")
    private String operatingSystem;

    @Column(name = "monitor_scale")
    private String monitorScale;

    @Column(name = "ram")
    private String ram;

    @Column(name = "product_name")
    private String productName;

    @Column(name = "design")
    private String design;

    @Column(name = "maintenance")
    private String maintenance;

    @Column(name = "description")
    private String description;

    @ManyToOne(fetch = FetchType.EAGER, cascade = {CascadeType.MERGE, CascadeType.REFRESH, CascadeType.DETACH})
    @JoinColumn(name = "category_id")
    private Category category;

    @ManyToOne(fetch = FetchType.EAGER, cascade = {CascadeType.MERGE, CascadeType.REFRESH, CascadeType.DETACH})
    @JoinColumn(name = "brand_id")
    private Brand brand;

    @Column(name = "image")
    private String image;

    @Column(name = "status")
    private String status;
}
