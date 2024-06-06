package com.web.laptoptg.dao;

import com.web.laptoptg.model.Product;

import java.util.List;

public interface ProductDAO {
    //insert a product to database
    void saveProduct (Product pro);

    //show all product
    List<Product> getAllProduct();

    //update a product to database
    void updateProduct(Product pro);

    //find product by its name
    List<Product> findProductByName(String name);

    //find product by its category
    List<Product> getProductByCategory(int cateID);

    //delete a product by its id
    void deleteById(int id);

    //find by id
    Product findProductById(int id);

    List<Product> getProductByCateOrderBySoldUnit(int cateID, int max);

    List<Product> getProductByCate(int cateID, int max);

    List<Product> getNextProductByCate(int amount, int numberOfProduct, int cateID);
}
