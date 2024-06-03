package com.web.laptoptg.service.impl;

import com.web.laptoptg.dao.ProductDAO;
import com.web.laptoptg.dao.impl.ProductDAOImpl;
import com.web.laptoptg.model.Product;
import com.web.laptoptg.service.ProductService;

import java.util.List;

public class ProductServiceImpl implements ProductService {

    private ProductDAO productDAO = new ProductDAOImpl();
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
    public List<Product> findProductByName(String name) {
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
    public List<Product> getTop3ByCate(int cateID) {
        return productDAO.getTop3ByCate(cateID);
    }
}
