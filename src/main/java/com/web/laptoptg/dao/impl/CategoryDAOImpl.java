package com.web.laptoptg.dao.impl;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dao.CategoryDAO;
import com.web.laptoptg.model.Category;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class CategoryDAOImpl implements CategoryDAO {

    @Override
    public Category getCategoryById(int id) {

        EntityManager entityManager = JPAConfig.getEntityManager();
        try {
            return entityManager.find(Category.class, id);
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }

        }
    }

    @Override
    public void saveCategory(Category category) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.persist(category);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
            JPAConfig.shutdown();
        }
    }

    @Override
    public void updateCategory(Category category) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.merge(category);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
            JPAConfig.shutdown();
        }
    }

    @Override
    public void deleteCategory(Category category) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            // Ensure the entity is managed before removing
            if (!entityManager.contains(category)) {
                category = entityManager.merge(category);
            }
            entityManager.remove(category);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
            JPAConfig.shutdown();
        }
    }

    @Override
    public List<Category> getAll() {
        EntityManager entityManager = JPAConfig.getEntityManager();
        try {
            TypedQuery<Category> query = entityManager.createQuery("SELECT c FROM Category c", Category.class);
            return query.getResultList();
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
            JPAConfig.shutdown();
        }
    }

    @Override
    public int getNumOfCategory() {
        EntityManager entityManager = JPAConfig.getEntityManager();
        try {
            TypedQuery<Category> query = entityManager.createQuery("SELECT c FROM Category c", Category.class);
            return query.getResultList().size();
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
            JPAConfig.shutdown();
        }
    }
}
