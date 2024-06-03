package com.web.laptoptg.dao.impl;

import com.web.laptoptg.dao.BrandDAO;
import com.web.laptoptg.model.Brand;
import com.web.laptoptg.config.JPAConfig;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class BrandDAOImpl implements BrandDAO {

    @Override
    public Brand getBrandById(int id) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        try {
            return entityManager.find(Brand.class, id);
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
            JPAConfig.shutdown();
        }
    }

    @Override
    public void saveBrand(Brand brand) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.persist(brand);
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
    public void updateBrand(Brand brand) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.merge(brand);
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
    public void deleteBrand(Brand brand) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            // Ensure the entity is managed before removing
            if (!entityManager.contains(brand)) {
                brand = entityManager.merge(brand);
            }
            entityManager.remove(brand);
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

    // Additional method to list all Brands
    public List<Brand> getAllBrands() {
        EntityManager entityManager = JPAConfig.getEntityManager();
        try {
            TypedQuery<Brand> query = entityManager.createQuery("SELECT b FROM Brand b", Brand.class);
            return query.getResultList();
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
            JPAConfig.shutdown();
        }
    }
}
