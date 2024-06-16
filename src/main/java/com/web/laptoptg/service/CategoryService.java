package com.web.laptoptg.service;

import com.web.laptoptg.model.Category;

import java.util.List;

public interface CategoryService {
    Category getCategoryById(int id);
    void saveCategory(Category category);
    void updateCategory(Category category);
    void deleteCategory(Category category);
    int getNumOfCategory();
    public boolean findCategoryByName(String name);

    Category findCategoryById(int id);

    List<Category> getAllCategory();
}
