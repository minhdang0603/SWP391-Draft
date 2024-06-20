package com.web.laptoptg.dao;

import com.web.laptoptg.model.Product;

import java.util.List;

public interface ProductDAO {
    //insert a product to database
    Product saveProduct (Product pro);

    //show all product
    List<Product> getAllProduct();

    //update a product to database
    Product updateProduct(Product pro);

    //find product by its name
    boolean findProductByName(String name);

    List<Product> findProduct(String name);

    //delete a product by its id
    void deleteProduct(Product product);

    //find by id
    Product findProductById(int id);

    List<Product> getProductByCateOrderBySoldUnit(int cateID, int max);

    List<Product> getProductByCate(int cateID, int max);

    List<Product> getNextProduct(List<Integer> brandIDs, String price, int cateID, int amount, int numberOfProduct);

    List<Product> getProductsBySortingBrandsAndCategoryId(List<Integer> brandIDs, String sortValue,int cateID);
}
