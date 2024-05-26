package com.web.laptoptg.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "category")
@Data //toString()
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Category {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "category_name")
    private String categoryName;
}
