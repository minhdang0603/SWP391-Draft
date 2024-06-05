package com.web.laptoptg.service.impl;

import com.web.laptoptg.dao.BrandDAO;
import com.web.laptoptg.dao.impl.BrandDAOImpl;
import com.web.laptoptg.model.Brand;
import com.web.laptoptg.service.BrandService;

import java.util.List;

public class BrandServiceImpl implements BrandService {

    private BrandDAO brandDAO = new BrandDAOImpl();

    @Override
    public Brand getBrandById(int id) {
        return brandDAO.getBrandById(id);
    }

    @Override
    public void saveBrand(Brand brand) {
        brandDAO.saveBrand(brand);
    }

    @Override
    public void updateBrand(Brand brand) {
        brandDAO.updateBrand(brand);
    }

    @Override
    public void deleteBrand(Brand brand) {
        brandDAO.deleteBrand(brand);
    }

    @Override
    public List<Brand> getAllBrands() {
        return brandDAO.getAllBrands();
    }
}
