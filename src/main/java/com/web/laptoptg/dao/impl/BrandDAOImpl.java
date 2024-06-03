package com.web.laptoptg.dao.impl;

import com.web.laptoptg.dao.BrandDAO;
import com.web.laptoptg.model.Brand;
import com.web.laptoptg.config.JPAConfig;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class BrandDAOImpl implements BrandDAO {

    EntityManager entityManager;
    EntityTransaction transaction;

    public BrandDAOImpl() {
        entityManager = JPAConfig.getEntityManager();
        transaction = entityManager.getTransaction();
    }

    @Override
    public Brand getBrandById(int id) {
        return entityManager.find(Brand.class, id);
    }

    @Override
    public void saveBrand(Brand brand) {
        try {
            transaction.begin();
            entityManager.persist(brand);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    @Override
    public void updateBrand(Brand brand) {
        try {
            transaction.begin();
            entityManager.merge(brand);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    @Override
    public void deleteBrand(Brand brand) {
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
        }
    }

    // Additional method to list all Brands
    public List<Brand> getAllBrands() {
        TypedQuery<Brand> query = entityManager.createQuery("SELECT b FROM Brand b", Brand.class);
        return query.getResultList();
    }
}
