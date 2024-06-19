package com.web.laptoptg.service;

import com.web.laptoptg.model.Product;

import java.util.List;

public interface ProductService {

    //insert a product to database
    Product saveProduct (Product pro);

    //update a product to database
    Product updateProduct(Product pro);

    //show all Products
    List<Product> getAllProducts();

    //find product by its name
    boolean findProductByName(String name);

    //delete a product by its id
    void deleteProduct(Product product);

    Product findProductById(int id);

    List<Product> getProductByCate(int cateID, int max);

    List<Product> getProductByCateOrderBySoldUnit(int cateID, int max);

    List<Product> getNextProduct(List<Integer> brandIDs, String price, int cateID, int amount, int numberOfProduct);

    List<Product> findProduct(String name);

    List<Product> getProductBySorting(List<Integer> brandIDs, String priceType, int cateID);
}
