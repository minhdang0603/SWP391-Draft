package com.web.laptoptg.dao.impl;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dao.ProductDAO;
import com.web.laptoptg.model.Product;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class ProductDAOImpl implements ProductDAO {
    @Override
    public void saveProduct(Product pro) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.persist(pro);
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
    public List<Product> getAllProduct() {
        EntityManager entityManager = JPAConfig.getEntityManager();
        TypedQuery<Product> query = entityManager.createQuery("from Product", Product.class);
        try {
            return query.getResultList();
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
            JPAConfig.shutdown();
        }
    }

    @Override
    public void updateProduct(Product pro) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.merge(pro);
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
    public List<Product> findProductByName(String name) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        TypedQuery<Product> query = entityManager.createQuery("from Product where productName like :name", Product.class);
        query.setParameter("name", "%" + name + "%");
        try {
            return query.getResultList();
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
            JPAConfig.shutdown();
        }
    }

    @Override
    public List<Product> getProductByCategory(int cateID) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        TypedQuery<Product> query = entityManager.createQuery("from Product where category.id = :cateID", Product.class);
        query.setParameter("cateID", cateID);
        try {
            return query.getResultList();
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
            JPAConfig.shutdown();
        }
    }

    @Override
    public void deleteById(int id) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            Product pro = entityManager.find(Product.class, id);
            if (pro != null) {
                entityManager.remove(pro);
                transaction.commit();
            }
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
    public Product findProductById(int id) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        return entityManager.find(Product.class, id);
    }

    @Override
    public List<Product> getTop4ByCate(int cateID) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        TypedQuery<Product> query = entityManager.createQuery(
                "SELECT p FROM Product p JOIN FETCH p.category WHERE p.category.id = :cateID", Product.class);
        query.setMaxResults(4);  // Corrected to fetch top 3 as specified
        query.setParameter("cateID", cateID);
        try {
            return query.getResultList();
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
            JPAConfig.shutdown();
        }
    }

    @Override
    public List<Product> getNext3Product(int amount) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        TypedQuery<Product> query = entityManager.createQuery("SELECT p FROM Product p ORDER BY p.id", Product.class);
        query.setFirstResult(amount);
        query.setMaxResults(3);
        try {
            return query.getResultList();
        } finally {
            if (entityManager.isOpen()) {
                entityManager.close();
            }
            JPAConfig.shutdown();
        }
    }
}
