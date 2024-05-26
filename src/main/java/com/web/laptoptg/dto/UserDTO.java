package com.web.laptoptg.dto;

import lombok.*;

@Data //toString()
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class UserDTO {

    private int id;

    private String address;

    private String email;

    private String userName;

    private String phoneNumber;

    private String role;

    private String status;

    private String code;

    private String password;
}
