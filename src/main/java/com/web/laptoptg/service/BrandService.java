package com.web.laptoptg.service;

import com.web.laptoptg.model.Brand;
import com.web.laptoptg.model.Product;

import java.util.List;

public interface BrandService {
    Brand getBrandById(int id);
    Brand saveBrand(Brand brand);
    Brand updateBrand(Brand brand);
    void deleteBrand(Brand brand);
    List<Brand> getAllBrands();
    public boolean findBrandByName(String name);
    Brand findBrandById(int id);
}
