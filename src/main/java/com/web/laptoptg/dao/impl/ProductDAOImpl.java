package com.web.laptoptg.dao.impl;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.config.Status;
import com.web.laptoptg.dao.ProductDAO;
import com.web.laptoptg.model.Product;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
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
    public Product saveProduct(Product pro) {
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
        return pro;
    }

    @Override
    public List<Product> getAllProduct() {
        entityManager.clear();
        TypedQuery<Product> query = entityManager.createQuery("from Product p join fetch p.brand join fetch p.category", Product.class);
        List<Product> productList = query.getResultList();
        return productList;
    }

    @Override
    public Product updateProduct(Product pro) {
        try {
            transaction.begin();
            entityManager.merge(pro);
            entityManager.flush();
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
        return pro;
    }

    @Override
    public boolean findProductByName(String name) {
        entityManager.clear();
        boolean found = false;
        try {
            TypedQuery<Product> query = entityManager.createQuery(
                    "SELECT p FROM Product p JOIN FETCH p.category JOIN FETCH p.brand WHERE lower(p.productName)  = :name",
                    Product.class
            );
            query.setParameter("name", name.toLowerCase());
            List<Product> results = query.getResultList();
            found = !results.isEmpty();
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return found;
    }

    @Override
    public List<Product> findProduct(String name){
        entityManager.clear();
        try {
            TypedQuery<Product> query = entityManager.createQuery("from Product p where p.productName like :name", Product.class);
            query.setParameter("name", "%" + name + "%");
            return query.getResultList();
        } catch (NoResultException e){
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public void deleteProduct(Product pro) {
        try {
            transaction.begin();
            // Ensure the entity is managed before removing
            if (!entityManager.contains(pro)) {
                pro = entityManager.merge(pro);
            }
                entityManager.remove(pro);
                transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    @Override
    public Product findProductById(int id) {
        entityManager.clear();
        return entityManager.find(Product.class, id);
    }

    @Override
    public List<Product> getProductByCateOrderBySoldUnit(int cateID, int max) {
        entityManager.clear();
        TypedQuery<Product> query = entityManager.createQuery("SELECT p FROM Product p join fetch p.category WHERE p.category.id = :cateID and p.status = :status order by p.soldUnit desc", Product.class);
        query.setMaxResults(max);  // Corrected to fetch top 3 as specified
        query.setParameter("cateID", cateID);
        query.setParameter("status", Status.ACTIVE);
        return query.getResultList();
    }

    @Override
    public List<Product> getProductByCate(int cateID, int max) {
        entityManager.clear();
        TypedQuery<Product> query = entityManager.createQuery("SELECT p FROM Product p join fetch p.category WHERE p.category.id = :cateID and p.status = :status", Product.class);
        query.setMaxResults(max);  // Corrected to fetch top 3 as specified
        query.setParameter("cateID", cateID);
        query.setParameter("status", Status.ACTIVE);
        return query.getResultList();
    }

    @Override
    public List<Product> getNextProduct(List<Integer> brandIDs, String price, int cateID, int amount, int numberOfProduct) {
        entityManager.clear();
        String hql = "FROM Product p join fetch p.category c join fetch p.brand b where p.status = :status";

        // Add brand filter
        if (brandIDs != null && !brandIDs.isEmpty()) {
            hql += " and b.id IN (:brandIDs)";
        }

        // Add category filter
        if (cateID != 0) {
            hql += " and c.id = :cateID";
        }

        // Add sorting
        if ("1".equals(price)) {
            hql += " ORDER BY p.unitPrice ASC";
        } else if ("2".equals(price)) {
            hql += " ORDER BY p.unitPrice DESC";
        }

        TypedQuery<Product> query = entityManager.createQuery(hql, Product.class);

        // Set parameters
        if (brandIDs != null && !brandIDs.isEmpty()) {
            query.setParameter("brandIDs", brandIDs);
        }
        if (cateID != 0) {
            query.setParameter("cateID", cateID);
        }
        query.setParameter("status", Status.ACTIVE);
        query.setFirstResult(amount);
        query.setMaxResults(numberOfProduct);
        return query.getResultList();
    }

    @Override
    public List<Product> getProductsBySortingBrandsAndCategoryId(List<Integer> brandIDs, String sortValue, int cateID) {
        entityManager.clear();
        String hql = "FROM Product p where p.status = :status";

        // Add brand filter
        if (brandIDs != null && !brandIDs.isEmpty()) {
            hql += " and p.brand.id IN (:brandIDs)";
        }

        // Add category filter
        if (cateID != 0) {
            hql += " and p.category.id = :cateID";
        }

        // Add sorting
        if ("1".equals(sortValue)) {
            hql += " ORDER BY p.unitPrice ASC";
        } else if ("2".equals(sortValue)) {
            hql += " ORDER BY p.unitPrice DESC";
        }

        TypedQuery<Product> query = entityManager.createQuery(hql, Product.class);

        // Set parameters
        if (brandIDs != null && !brandIDs.isEmpty()) {
            query.setParameter("brandIDs", brandIDs);
        }
        if (cateID != 0) {
            query.setParameter("cateID", cateID);
        }
        query.setParameter("status", Status.ACTIVE);
        query.setMaxResults(9); // Limit to 9 results
        return query.getResultList();
    }
}
