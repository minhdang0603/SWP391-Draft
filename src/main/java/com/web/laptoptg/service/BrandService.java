package com.web.laptoptg.service;

import com.web.laptoptg.model.Brand;

public interface BrandService {
    Brand getBrandById(int id);
    void saveBrand(Brand brand);
    void updateBrand(Brand brand);
    void deleteBrand(Brand brand);
}
