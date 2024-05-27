package com.web.laptoptg.dao.impl;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dao.CategoryDAO;
import com.web.laptoptg.model.Category;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

public class CategoryDAOImpl implements CategoryDAO {

    @Override
    public Category getCategoryById(int id) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        return entityManager.find(Category.class, id);
    }

    @Override
    public void saveCategory(Category category) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try{
            transaction.begin();
            entityManager.persist(category);
            transaction.commit();
        } catch (Exception e){
            transaction.rollback();
            e.printStackTrace();
        } finally {
            entityManager.close();
        }

    }

    @Override
    public void updateCategory(Category category) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try{
            transaction.begin();
            entityManager.merge(category);
            transaction.commit();
        } catch (Exception e){
            transaction.rollback();
            e.printStackTrace();
        } finally {
            entityManager.close();
        }

    }

    @Override
    public void deleteCategory(Category category) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try{
            transaction.begin();
            entityManager.remove(category);
            transaction.commit();
        } catch (Exception e){
            transaction.rollback();
            e.printStackTrace();
        } finally {
            entityManager.close();
        }

    }
}
