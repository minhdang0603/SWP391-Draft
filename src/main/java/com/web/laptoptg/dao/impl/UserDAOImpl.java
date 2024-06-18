package com.web.laptoptg.dao.impl;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dao.UserDAO;
import com.web.laptoptg.dto.UserDTO;
import com.web.laptoptg.model.User;
import com.web.laptoptg.service.CartService;
import com.web.laptoptg.service.impl.CartServiceImpl;
import com.web.laptoptg.service.impl.UserServiceImpl;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.*;

import java.util.List;

public class UserDAOImpl implements UserDAO {

    EntityManager entityManager;
    EntityTransaction transaction;

    private CartService cartService;

    public UserDAOImpl() {
        entityManager = JPAConfig.getEntityManager();
        transaction = entityManager.getTransaction();
        cartService = new CartServiceImpl();
    }

    @Override
    public User saveUser(User user) {
        try {
            transaction.begin();
            entityManager.persist(user);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
        return user;
    }

    @Override
    public User updateUser(User user) {
        try {
            transaction.begin();
            entityManager.merge(user);
            entityManager.flush();
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
        return user;
    }

    @Override
    public void deleteById(int id) {
        try {
            transaction.begin();
            // Xóa các bản ghi trong Cart trước khi xóa User
            cartService.deleteCartByUserId(id);
            User user = entityManager.find(User.class, id);
            if (user != null) {
                entityManager.remove(user);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    @Override
    public List<User> findAllUsers() {
        List<User> users = null;
        try {
            TypedQuery<User> query = entityManager.createQuery("from User u join fetch u.role", User.class);
            users = query.getResultList();
        } catch (NoResultException e) {
            e.printStackTrace();
        }
        return users;
    }


    @Override
    public User findUserByEmail(String email) {
        entityManager.clear();
        User user = null;
        try {
            TypedQuery<User> query = entityManager.createQuery("select u from User u join fetch u.role where u.email = :email", User.class);
            query.setParameter("email", email);
            user = query.getSingleResult();
        } catch (NoResultException e) {
            e.printStackTrace();
        }
        return user;
    }

    @Override
    public List<User> findUserByRole(String role) {
        entityManager.clear();
        TypedQuery<User> query = entityManager.createQuery("from User u join fetch u.role where lower(u.role.roleName) = :role", User.class);
        query.setParameter("role", role.toLowerCase());
        return query.getResultList();
    }

    @Override
    public User findUserById(int id) {
        return entityManager.find(User.class, id);
    }
}
