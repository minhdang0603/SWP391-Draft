package com.web.laptoptg.service.impl;

import com.web.laptoptg.dao.BrandDAO;
import com.web.laptoptg.dao.impl.BrandDAOImpl;
import com.web.laptoptg.model.Brand;
import com.web.laptoptg.model.Product;
import com.web.laptoptg.service.BrandService;

import java.util.List;

public class BrandServiceImpl implements BrandService {

    private BrandDAO brandDAO;

    public BrandServiceImpl() {
        brandDAO = new BrandDAOImpl();
    }

    @Override
    public Brand getBrandById(int id) {
        return brandDAO.getBrandById(id);
    }

    @Override
    public Brand saveBrand(Brand brand) {
        return brandDAO.saveBrand(brand);
    }

    @Override
    public Brand updateBrand(Brand brand) {
        return brandDAO.updateBrand(brand);
    }

    @Override
    public void deleteBrand(Brand brand) {
        brandDAO.deleteBrand(brand);
    }

    @Override
    public List<Brand> getAllBrands() {
        return brandDAO.getAllBrands();
    }
    @Override
    public boolean findBrandByName(String name) {
        return brandDAO.findBrandByName(name);
    }

    @Override
    public Brand findBrandById(int id) {
        return brandDAO.findBrandById(id);
    }
}
