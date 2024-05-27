package com.web.laptoptg.service;

import com.web.laptoptg.model.Category;

public interface CategoryService {
    Category getCategoryById(int id);
    void saveCategory(Category category);
    void updateCategory(Category category);
    void deleteCategory(Category category);
}
