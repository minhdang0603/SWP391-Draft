package com.web.laptoptg.dao.impl;

import com.web.laptoptg.dao.BrandDAO;
import com.web.laptoptg.model.Brand;
import com.web.laptoptg.config.JPAConfig;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

public class BrandDaoImpl implements BrandDAO {

    @Override
    public Brand getBrandById(int id) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        Brand brand = entityManager.find(Brand.class, id);
        entityManager.close();
        return brand;
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
            transaction.rollback();
            e.printStackTrace();
        } finally {
            entityManager.close();
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
            transaction.rollback();
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public void deleteBrand(Brand brand) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.remove(brand);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
    }
}
