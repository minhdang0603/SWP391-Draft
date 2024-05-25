package com.web.laptoptg.service.impl;

import com.web.laptoptg.dao.ProductDAO;
import com.web.laptoptg.dao.impl.ProductDAOImp;
import com.web.laptoptg.model.Product;
import com.web.laptoptg.service.ProductService;

import java.util.List;

public class ProductServiceImpl implements ProductService {

    private ProductDAO productDAO = new ProductDAOImp();
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
}
