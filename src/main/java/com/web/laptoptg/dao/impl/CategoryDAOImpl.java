package com.web.laptoptg.dao.impl;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dao.CategoryDAO;
import com.web.laptoptg.model.Category;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

public class CategoryDAOImpl implements CategoryDAO {
    private EntityManager em;
    private EntityTransaction transaction;

    public CategoryDAOImpl() {
        em = JPAConfig.getEntityManager();
        transaction = em.getTransaction();
    }

    @Override
    public Category getCategoryById(int id) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        return entityManager.find(Category.class, id);
    }

    @Override
    public void saveCategory(Category category) {
        try{
            transaction.begin();
            em.persist(category);
            transaction.commit();
        } catch (Exception e){
            transaction.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }

    }

    @Override
    public void updateCategory(Category category) {
        try{
            transaction.begin();
            em.merge(category);
            transaction.commit();
        } catch (Exception e){
            transaction.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }

    }

    @Override
    public void deleteCategory(Category category) {
        try{
            transaction.begin();
            em.remove(category);
            transaction.commit();
        } catch (Exception e){
            transaction.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }

    }

    @Override
    public int getNumOfCategory() {
        TypedQuery<Category> query = em.createQuery("FROM Category c", Category.class);
        return query.getResultList().size();
    }
}
