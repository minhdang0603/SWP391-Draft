package com.web.laptoptg.dao.impl;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dao.ProductDAO;
import com.web.laptoptg.model.Product;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class ProductDAOImpl implements ProductDAO {

    EntityManager entityManager;
    EntityTransaction transaction;

    public ProductDAOImpl() {
        entityManager = JPAConfig.getEntityManager();
        transaction = entityManager.getTransaction();
    }

    @Override
    public void saveProduct(Product pro) {
        try {
            transaction.begin();
            entityManager.persist(pro);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    @Override
    public List<Product> getAllProduct() {
        TypedQuery<Product> query = entityManager.createQuery("from Product p join fetch p.brand join fetch p.category", Product.class);
        return query.getResultList();
    }

    @Override
    public void updateProduct(Product pro) {
        try {
            transaction.begin();
            entityManager.merge(pro);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    @Override
    public List<Product> findProductByName(String name) {
        TypedQuery<Product> query = entityManager.createQuery("from Product p join fetch p.category join fetch p.brand where p.productName like :name", Product.class);
        query.setParameter("name", "%" + name + "%");
        return query.getResultList();
    }

    @Override
    public List<Product> findProduct(String name){
        TypedQuery<Product> query = entityManager.createQuery("from Product p join fetch p.category join fetch p.brand where p.productName like :name", Product.class);
        query.setParameter("name", "%" + name + "%");
        return query.getResultList();
    }

    @Override
    public List<Product> getProductByCategory(int cateID) {
        TypedQuery<Product> query = entityManager.createQuery("from Product p join fetch p.category join fetch p.brand where p.category.id = :cateID", Product.class);
        query.setParameter("cateID", cateID);
        return query.getResultList();
    }

    @Override
    public void deleteById(int id) {
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
        }
    }

    @Override
    public Product findProductById(int id) {
        return entityManager.find(Product.class, id);
    }

    @Override
    public List<Product> getProductByCateOrderBySoldUnit(int cateID, int max) {
        TypedQuery<Product> query = entityManager.createQuery("SELECT p FROM Product p join fetch p.category WHERE p.category.id = :cateID order by p.soldUnit desc", Product.class);
        query.setMaxResults(max);  // Corrected to fetch top 3 as specified
        query.setParameter("cateID", cateID);
        return query.getResultList();
    }

    @Override
    public List<Product> getProductByCate(int cateID, int max) {
        TypedQuery<Product> query = entityManager.createQuery("SELECT p FROM Product p join fetch p.category WHERE p.category.id = :cateID", Product.class);
        query.setMaxResults(max);  // Corrected to fetch top 3 as specified
        query.setParameter("cateID", cateID);
        return query.getResultList();
    }

    @Override
    public List<Product> getNextProduct(int amount, int numberOfProduct) {
        TypedQuery<Product> query = entityManager.createQuery("SELECT p FROM Product p join fetch p.category", Product.class);
        query.setFirstResult(amount);
        query.setMaxResults(numberOfProduct);
        return query.getResultList();
    }

    @Override
    public List<Product> getNextProductByCate(int amount, int numberOfProduct, int cateID) {
        TypedQuery<Product> query = entityManager.createQuery("SELECT p FROM Product p join fetch p.category where p.category.id = :cateID", Product.class);
        query.setParameter("cateID", cateID);
        query.setFirstResult(amount);
        query.setMaxResults(numberOfProduct);
        return query.getResultList();
    }
}
