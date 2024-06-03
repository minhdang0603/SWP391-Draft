package com.web.laptoptg.dao.impl;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dao.UserDAO;
import com.web.laptoptg.model.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class UserDAOImpl implements UserDAO {

    EntityManager entityManager;
    EntityTransaction transaction;

    public UserDAOImpl() {
        entityManager = JPAConfig.getEntityManager();
        transaction = entityManager.getTransaction();
    }

    @Override
    public void saveUser(User user) {
        try {
            transaction.begin();
            entityManager.persist(user);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            e.printStackTrace();
        }
    }

    @Override
    public void updateUser(User user) {
        try {
            transaction.begin();
            entityManager.merge(user);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            e.printStackTrace();
        }
    }

    @Override
    public void deleteById(int id) {
        try {
            transaction.begin();
            User user = findUserById(id);
            entityManager.remove(user);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
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
        try {
            TypedQuery<User> query = entityManager.createQuery("from User u join fetch u.role where u.email = :email", User.class);
            query.setParameter("email", email);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public List<User> findUserByRole(String role) {
        TypedQuery<User> query = entityManager.createQuery("from User u join fetch u.role where u.role = :role", User.class);
        query.setParameter("role", role);
        return query.getResultList();
    }

    @Override
    public User findUserById(int id) {
        return entityManager.find(User.class, id);
    }
}
