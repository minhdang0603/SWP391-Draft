package com.web.laptoptg.dao.impl;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dao.CategoryDAO;
import com.web.laptoptg.model.Category;
import com.web.laptoptg.model.Product;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class CategoryDAOImpl implements CategoryDAO {

    EntityManager entityManager;
    EntityTransaction transaction;

    public CategoryDAOImpl() {
        entityManager = JPAConfig.getEntityManager();
        transaction = entityManager.getTransaction();
    }

    @Override
    public Category getCategoryById(int id) {
        return entityManager.find(Category.class, id);
    }

    @Override
    public Category saveCategory(Category category) {
        try {
            transaction.begin();
            entityManager.persist(category);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
        return category;
    }

    @Override
    public Category updateCategory(Category category) {
        try {
            transaction.begin();
            entityManager.merge(category);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
        return category;
    }

    @Override
    public void deleteCategory(Category category) {
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
        }
    }

    @Override
    public List<Category> getAll() {
        entityManager.clear();
        TypedQuery<Category> query = entityManager.createQuery("SELECT c FROM Category c", Category.class);
        return query.getResultList();

    }

    @Override
    public int getNumOfCategory() {
        TypedQuery<Category> query = entityManager.createQuery("SELECT c FROM Category c", Category.class);
        return query.getResultList().size();
    }

    @Override
    public boolean findCategoryByName(String name) {
        entityManager.clear();
        boolean found = false;
        try {
            TypedQuery<Category> query = entityManager.createQuery(
                    "SELECT cate FROM Category cate WHERE lower(cate.categoryName)  = :name",
                    Category.class
            );
            query.setParameter("name", name.toLowerCase());
            List<Category> results = query.getResultList();
            found = !results.isEmpty();
        } catch (Exception ex) {
            ex.printStackTrace();
            found = false;
        }

        return found;
    }

    @Override
    public Category findCategoryById(int id) {
        entityManager.clear();
        return entityManager.find(Category.class, id);
    }
}
