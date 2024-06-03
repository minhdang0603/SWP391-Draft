package com.web.laptoptg.dao.impl;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dao.CategoryDAO;
import com.web.laptoptg.model.Category;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

public class CategoryDAOImpl implements CategoryDAO {
    private EntityManager entityManager;
    private EntityTransaction transaction;

    public CategoryDAOImpl() {
        entityManager = JPAConfig.getEntityManager();
        transaction = entityManager.getTransaction();
    }

    @Override
    public Category getCategoryById(int id) {
        Category category = entityManager.find(Category.class, id);

        return category;
    }

    @Override
    public void saveCategory(Category category) {
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

    @Override
    public int getNumOfCategory() {
        TypedQuery<Category> query = entityManager.createQuery("FROM Category c", Category.class);
        return query.getResultList().size();
    }
}
