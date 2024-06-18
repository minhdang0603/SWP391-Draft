package com.web.laptoptg.dao;

import com.web.laptoptg.model.User;

import java.util.List;

public interface UserDAO {
    User saveUser (User user);
    User updateUser(User user);
    User findUserByEmail(String email);
    List<User> findUserByRole(String role);
    User findUserById(int id);
    void deleteById(int id);
    List<User> findAllUsers();
}
