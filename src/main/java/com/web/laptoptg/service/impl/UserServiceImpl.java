package com.web.laptoptg.service.impl;

import com.web.laptoptg.dao.RoleDAO;
import com.web.laptoptg.dao.UserDAO;
import com.web.laptoptg.dao.impl.RoleDAOImpl;
import com.web.laptoptg.dao.impl.UserDAOImpl;
import com.web.laptoptg.dto.UserDTO;
import com.web.laptoptg.model.Cart;
import com.web.laptoptg.model.Role;
import com.web.laptoptg.model.User;
import com.web.laptoptg.service.CartService;
import com.web.laptoptg.service.UserService;
import com.web.laptoptg.util.PasswordUtils;

import java.security.NoSuchAlgorithmException;
import java.util.List;

public class UserServiceImpl implements UserService {

    private UserDAO userDAO;
    private RoleDAO roleDAO;

    public UserServiceImpl() {
        roleDAO = new RoleDAOImpl();
        userDAO = new UserDAOImpl();
    }

    @Override
    public User register(UserDTO user) { // register user
        User temp = new User();
        temp.setAddress(user.getAddress());
        temp.setEmail(user.getEmail());
        temp.setUserName(user.getUserName());
        temp.setPassword(user.getPassword());
        temp.setRole(roleDAO.getRoleByRoleName(user.getRole()));
        temp.setStatus(user.getStatus());
        temp.setPhoneNumber(user.getPhoneNumber());
        return userDAO.saveUser(temp);
    }

    @Override
    public User updateUser(UserDTO user) {
        User temp = userDAO.findUserById(user.getId());
        temp.setId(user.getId());
        temp.setUserName(user.getUserName());
        temp.setAddress(user.getAddress());
        temp.setPhoneNumber(user.getPhoneNumber());
        temp.setEmail(user.getEmail());
        if (user.getPassword() != null) {
            temp.setPassword(user.getPassword());
        }
        temp.setRole(roleDAO.getRoleByRoleName(user.getRole()));
        if (user.getStatus() != null) {
            temp.setStatus(user.getStatus());
        }
        return userDAO.updateUser(temp);
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
        User temp = this.findUserByEmail(user.getEmail());

        if (temp != null && temp.getPassword().equals(user.getPassword())) {
            temp.setPassword(PasswordUtils.hash(newPassword));
            userDAO.updateUser(temp);
        }
    }


    @Override
    public User login(String email, String password) {
        User user = userDAO.findUserByEmail(email);
        if (user == null) return null;
        if (PasswordUtils.verify(password, user.getPassword())) {
            return user;
        }
        return null;
    }

    @Override
    public List<User> findAllUsers() {
        return userDAO.findAllUsers();
    }

    public User addUser(UserDTO user) {
        User temp = new User();
        CartService cartService = new CartServiceImpl();
        temp.setUserName(user.getUserName());
        temp.setAddress(user.getAddress());
        temp.setPhoneNumber(user.getPhoneNumber());
        temp.setEmail(user.getEmail());
        temp.setPassword(user.getPassword());
        temp.setRole(roleDAO.getRoleById(Integer.parseInt(user.getRole())));
        temp.setStatus(user.getStatus());

        Cart cart = new Cart();
        cart.setUser(temp);
        cartService.saveCart(cart);
        return userDAO.saveUser(temp);
    }
}
