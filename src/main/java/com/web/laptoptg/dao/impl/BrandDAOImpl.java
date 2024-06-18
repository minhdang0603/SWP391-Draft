package com.web.laptoptg.dao.impl;

import com.web.laptoptg.dao.BrandDAO;
import com.web.laptoptg.model.Brand;
import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.model.Category;
import com.web.laptoptg.model.Product;
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
    public Brand saveBrand(Brand brand) {
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
        return brand;
    }

    @Override
    public Brand updateBrand(Brand brand) {
        try {
            transaction.begin();
            entityManager.merge(brand);
            entityManager.flush();
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
        return brand;
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
    @Override
    public List<Brand> getAllBrands() {
        entityManager.clear();
        TypedQuery<Brand> query = entityManager.createQuery("SELECT b FROM Brand b", Brand.class);
        return query.getResultList();
    }

    @Override
    public boolean findBrandByName(String name) {
        entityManager.clear();
        boolean found = false;
        try {
            TypedQuery<Brand> query = entityManager.createQuery(
                    "SELECT brand FROM Brand brand WHERE lower(brand.brandName)  = :name",
                    Brand.class
            );
            query.setParameter("name", name.toLowerCase());
            List<Brand> results = query.getResultList();
            found = !results.isEmpty();
        } catch (Exception ex) {
            ex.printStackTrace();
            found = false;
        }

        return found;
    }

    @Override
    public Brand findBrandById(int id) {
        entityManager.clear();
        return entityManager.find(Brand.class, id);
    }
}
