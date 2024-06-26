package com.web.laptoptg.service;

import com.web.laptoptg.dto.UserDTO;
import com.web.laptoptg.model.User;

import java.util.List;

public interface UserService {
    User register (UserDTO user); // use for register
    User updateUser(UserDTO user); // use for update user information
    User findUserByEmail(String email); // find user by email
    List<User> findUserByRole(String role); // find user by role
    User findUserById(int id); // find user by id
    void deleteById(int id); // delete user by id
    void changePassword(UserDTO user, String newPassword); // use for
    User login(String email, String password);
    List<User> findAllUsers();
    User addUser(UserDTO user);
}
