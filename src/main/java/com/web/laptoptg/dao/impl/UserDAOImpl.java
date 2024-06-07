package com.web.laptoptg.dao.impl;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dao.UserDAO;
import com.web.laptoptg.dto.UserDTO;
import com.web.laptoptg.model.User;
import com.web.laptoptg.service.impl.UserServiceImpl;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class UserDAOImpl implements UserDAO {

    @Override
    public void saveUser(User user) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.persist(user);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public void updateUser(User user) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.merge(user);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
    }

//    public static void main(String[] args) {
//        UserDAO u = new UserDAOImpl();
//        // Tạo một đối tượng User mới
//        User userToUpdate = new User();
//        userToUpdate.setId(24); // Thay đổi id theo id của user cần cập nhật
//        userToUpdate.setUserName("New Name");
//        userToUpdate.setAddress("New Address");
//        userToUpdate.setPhoneNumber("123456789");
//        userToUpdate.setEmail("newemail123@example.com");
//
//        // Gọi phương thức updateUser để cập nhật thông tin của user
//        u.updateUser(userToUpdate);
//    }


    @Override
    public void deleteById(int id) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            User user = entityManager.find(User.class, id);
            if (user != null) {
                entityManager.remove(user);
            }
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<User> findAllUsers() {
        EntityManager entityManager = JPAConfig.getEntityManager();
        List<User> users = null;
        try {
            TypedQuery<User> query = entityManager.createQuery("from User", User.class);
            users = query.getResultList();
        } catch (NoResultException e) {
            e.printStackTrace();
        }
        return users;
    }

    @Override
    public User findUserByEmail(String email) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        try {
            TypedQuery<User> query = entityManager.createQuery("from User where email = :email", User.class);
            query.setParameter("email", email);
            return query.getSingleResult();
        } catch (NoResultException e){
            return null;
        }
    }

    @Override
    public List<User> findUserByRole(String role) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        TypedQuery<User> query = entityManager.createQuery("from User where role = :role", User.class);
        query.setParameter("role", role);
        return query.getResultList();
    }

    @Override
    public User findUserById(int id) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        return entityManager.find(User.class, id);
    }
}
