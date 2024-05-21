package com.web.laptoptg.service.impl;

import com.web.laptoptg.dao.UserDAO;
import com.web.laptoptg.dao.impl.UserDAOImpl;
import com.web.laptoptg.model.User;
import com.web.laptoptg.service.UserService;

import java.util.List;

public class UserServiceImpl implements UserService {

    private UserDAO userDAO = new UserDAOImpl();

    @Override
    public void saveUser(User user) {
        userDAO.saveUser(user);
    }

    @Override
    public void updateUser(User user) {
        userDAO.updateUser(user);
    }

    @Override
    public User findUserByEmail(String email) {
        return userDAO.findUserByEmail(email);
    }

    @Override
    public List<User> findUserByRole(String role) {
        return userDAO.findUserByRole(role);
    }

    @Override
    public User findUserById(int id) {
        return userDAO.findUserById(id);
    }

    @Override
    public void deleteById(int id) {
        userDAO.deleteById(id);
    }

    @Override
    public void changePassword(User user, String newPassword) {

    }

    @Override
    public User login(String email, String password) {
        return null;
    }


}
