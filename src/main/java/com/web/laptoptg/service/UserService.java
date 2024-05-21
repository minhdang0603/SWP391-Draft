package com.web.laptoptg.service;

import com.web.laptoptg.model.User;

import java.util.List;

public interface UserService {
    void saveUser (User user);
    void updateUser(User user);
    User findUserByEmail(String email);
    List<User> findUserByRole(String role);
    User findUserById(int id);
    void deleteById(int id);
    void changePassword(User user, String newPassword);
    User login(String email, String password);
}
