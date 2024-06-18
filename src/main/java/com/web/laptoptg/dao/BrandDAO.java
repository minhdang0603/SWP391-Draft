package com.web.laptoptg.dao;

import com.web.laptoptg.model.Brand;
import com.web.laptoptg.model.Product;

import java.util.List;

public interface BrandDAO {
    Brand getBrandById(int id);
    Brand saveBrand(Brand brand);
    Brand updateBrand(Brand brand);
    void deleteBrand(Brand brand);

    // Additional method to list all Brands
    List<Brand> getAllBrands();
    boolean findBrandByName(String name);
    Brand findBrandById(int id);
}