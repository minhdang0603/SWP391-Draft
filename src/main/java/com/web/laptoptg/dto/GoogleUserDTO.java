package com.web.laptoptg.dto;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class GoogleUserDTO {
    private String id;
    private String email;
    private String name;
    private String given_name;
    private String family_name;
    private String picture;
}
