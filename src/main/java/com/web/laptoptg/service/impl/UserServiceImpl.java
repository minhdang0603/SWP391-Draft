package com.web.laptoptg.service.impl;

import com.web.laptoptg.dao.RoleDAO;
import com.web.laptoptg.dao.UserDAO;
import com.web.laptoptg.dao.impl.RoleDAOImpl;
import com.web.laptoptg.dao.impl.UserDAOImpl;
import com.web.laptoptg.dto.UserDTO;
import com.web.laptoptg.model.User;
import com.web.laptoptg.service.UserService;
import com.web.laptoptg.util.PasswordUtil;

import java.security.NoSuchAlgorithmException;
import java.util.List;

public class UserServiceImpl implements UserService {

    private UserDAO userDAO = new UserDAOImpl();
    private RoleDAO roleDAO = new RoleDAOImpl();

    @Override
    public boolean register(UserDTO user) { // register user
        User temp = new User();
        temp.setAddress(user.getAddress());
        temp.setEmail(user.getEmail());
        temp.setUserName(user.getUserName());
        temp.setPassword(user.getPassword());
        temp.setRole(roleDAO.getRoleByRoleName(user.getRole()));
        temp.setStatus(user.getStatus());
        temp.setPhoneNumber(user.getPhoneNumber());
        userDAO.saveUser(temp);
        return userDAO.findUserByEmail(temp.getEmail()) != null;
    }

    @Override
    public void updateUser(UserDTO user) {
        User temp = userDAO.findUserByEmail(user.getEmail());
        temp.setStatus("active");
        userDAO.updateUser(temp);
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
    public void changePassword(UserDTO user, String newPassword) {

    }

    @Override
    public User login(String email, String password) {
        User user = this.findUserByEmail(email);
        try {
            if (user != null && PasswordUtil.verify(password, user.getPassword())) {
                return user;
            }
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
        return null;
    }
}
