package com.web.laptoptg.service;

import com.web.laptoptg.model.Product;

import java.util.List;

public interface ProductService {

    //insert a product to database
    void saveProduct (Product pro);

    //update a product to database
    void updateProduct(Product pro);

    //show all Products
    List<Product> getAllProducts();

    //find product by its name
    List<Product> findProductByName(String name);

    //find product by its category
    List<Product> getProductByCategory(int cateID);

    //delete a product by its id
    void deleteById(int id);

    Product findProductById(int id);

    List<Product> getTop3ByCate(int cateID);
}
