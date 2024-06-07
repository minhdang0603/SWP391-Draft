package com.web.laptoptg.dao;

import com.web.laptoptg.model.Brand;

import java.util.List;

public interface BrandDAO {
    Brand getBrandById(int id);
    void saveBrand(Brand brand);
    void updateBrand(Brand brand);
    void deleteBrand(Brand brand);

    // Additional method to list all Brands
    List<Brand> getAllBrands();
}