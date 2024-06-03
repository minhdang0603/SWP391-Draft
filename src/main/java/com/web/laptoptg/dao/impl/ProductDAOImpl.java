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
            transaction.rollback();
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Product> getAllProduct() {
        EntityManager entityManager = JPAConfig.getEntityManager();
        TypedQuery<Product> query = entityManager.createQuery("from Product", Product.class);
        return query.getResultList();
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
            transaction.rollback();
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
    }


    @Override
    public List<Product> findProductByName(String name) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        TypedQuery<Product> query = entityManager.createQuery("from Product where productName like :name", Product.class);
        query.setParameter("name", "%"+name+"%");
        return query.getResultList();
    }

    @Override
    public List<Product> getProductByCategory(int cateID) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        TypedQuery<Product> query = entityManager.createQuery("from Product where category.id = :cateID", Product.class);
        query.setParameter("cateID", cateID);
        return query.getResultList();
    }

    @Override
    public void deleteById(int id) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            Product pro = findProductById(id);
            entityManager.remove(pro);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
    }
    @Override
    public Product findProductById(int id) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        return entityManager.find(Product.class, id);
    }

    @Override
    public List<Product> getTop3ByCate(int cateID) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        TypedQuery<Product> query = entityManager.createQuery("SELECT p FROM Product p where category.id = :cateID", Product.class);
        query.setMaxResults(4);
        query.setParameter("cateID", cateID);
        return query.getResultList();
    }

    @Override
    public List<Product> getNext3Product(int amount) {
        EntityManager entityManager = JPAConfig.getEntityManager();
        try {
            // JPQL query without OFFSET and FETCH NEXT
            String jpql = "SELECT p FROM Product p ORDER BY p.id";
            TypedQuery<Product> query = entityManager.createQuery(jpql, Product.class);

            // Use setFirstResult for OFFSET and setMaxResults for FETCH NEXT
            query.setFirstResult(amount);
            query.setMaxResults(3);

            return query.getResultList();
        } finally {
            entityManager.close();
        }
    }
}
