package com.web.laptoptg.service.impl;

import com.web.laptoptg.dao.BrandDAO;
import com.web.laptoptg.model.Brand;
import com.web.laptoptg.service.BrandService;

public class BrandServiceImpl implements BrandService {

    private BrandDAO brandDAO ;

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
}
