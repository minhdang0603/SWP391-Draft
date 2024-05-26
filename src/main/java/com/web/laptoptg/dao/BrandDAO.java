package com.web.laptoptg.dao;

import com.web.laptoptg.model.Brand;

public interface BrandDAO {
    Brand getBrandById(int id);
    void saveBrand(Brand brand);
    void updateBrand(Brand brand);
    void deleteBrand(Brand brand);
}