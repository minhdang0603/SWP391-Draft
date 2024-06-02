package com.web.laptoptg.dto;

import com.web.laptoptg.model.Product;
import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString
public class ItemDTO {
    private Product product;
    private int quantity;
}
