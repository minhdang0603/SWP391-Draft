package com.web.laptoptg.service.impl;

import com.web.laptoptg.dao.ProductDAO;
import com.web.laptoptg.dao.impl.ProductDAOImpl;
import com.web.laptoptg.model.Product;
import com.web.laptoptg.service.ProductService;

import java.util.List;

public class ProductServiceImpl implements ProductService {

    private ProductDAO productDAO;

    public ProductServiceImpl() {
        productDAO = new ProductDAOImpl();
    }

    @Override
    public Product saveProduct(Product pro) {
        return productDAO.saveProduct(pro);
    }

    @Override
    public Product updateProduct(Product pro) {
        return productDAO.updateProduct(pro);
    }

    @Override
    public List<Product> getAllProducts() {
        return productDAO.getAllProduct();
    }

    @Override
    public boolean findProductByName(String name) {
        return productDAO.findProductByName(name);
    }

    @Override
    public void deleteProduct(Product id) {
        productDAO.deleteProduct(id);
    }

    @Override
    public Product findProductById(int id) {
        return productDAO.findProductById(id);
    }

    @Override
    public List<Product> getProductByCate(int cateID, int max) {
        return productDAO.getProductByCate(cateID, max);
    }

    @Override
    public List<Product> getProductByCateOrderBySoldUnit(int cateID, int max) {
        return productDAO.getProductByCateOrderBySoldUnit(cateID, max);
    }

    @Override
    public List<Product> getNextProduct(List<Integer> brandIDs, String price, int cateID, int amount, int numberOfProduct) {
        // get next product by brand id or price or categor id
        return productDAO.getNextProduct(brandIDs, price, cateID, amount, numberOfProduct);
    }

    @Override
    public List<Product> findProduct(String name) {
        return productDAO.findProduct(name);
    }

    @Override
    public List<Product> getProductBySorting(List<Integer> brandIDs, String priceType, int cateID) {
        return productDAO.getProductsBySortingBrandsAndCategoryId(brandIDs, priceType, cateID);
    }
}
