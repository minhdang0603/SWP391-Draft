package com.web.laptoptg.model;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "payment")
@Data //toString()
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Payment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "payment_method")
    private String method;

    @Column(name = "amount")
    private long amount;

    @Column(name = "payment_status")
    private String status;

    @Column(name = "payment_date")
    private LocalDateTime payDate;

    public String getFormattedPayDate() {
        if(payDate==null){
            return "";
        }
        return payDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss"));
    }
}
