package com.web.laptoptg.dto;

import com.web.laptoptg.model.Role;
import com.web.laptoptg.model.User;
import com.web.laptoptg.service.RoleService;
import com.web.laptoptg.service.impl.RoleServiceImpl;
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


    public User toUser() {
        User user = new User();
        RoleService roleService = new RoleServiceImpl();
        user.setId(this.id);
        user.setUserName(this.userName);
        user.setAddress(this.address);
        user.setPhoneNumber(this.phoneNumber);
        user.setEmail(this.email);
        user.setPassword(this.password);
        user.setStatus(this.status);
        user.setRole(roleService.getRoleByRoleName(this.role));
        return user;
    }
}
