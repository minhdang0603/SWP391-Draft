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
    public void saveProduct(Product pro) {
        productDAO.saveProduct(pro);
    }

    @Override
    public void updateProduct(Product pro) {
        productDAO.updateProduct(pro);
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
    public List<Product> getProductByCategory(int cateID) {
        return productDAO.getProductByCategory(cateID);
    }

    @Override
    public void deleteById(int id) {
        productDAO.deleteById(id);
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
    public List<Product> getNextProduct(int amount, int numberOfProduct) {
        return productDAO.getNextProduct(amount, numberOfProduct);
    }

    @Override
    public List<Product> getNextProductByCate(int amount, int numberOfProduct, int cateID){
        return productDAO.getNextProductByCate(amount, numberOfProduct, cateID);
    }

    @Override
    public List<Product> findProduct(String name) {
        return productDAO.findProduct(name);
    }

    @Override
    public List<Product> getProductByBrandIDs(List<Integer> brandIDs){
        return productDAO.getProductByBrandIDs(brandIDs);
    }
}
