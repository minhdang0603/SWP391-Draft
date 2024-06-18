package com.web.laptoptg.service;

import com.web.laptoptg.model.Category;

import java.util.List;

public interface CategoryService {
    Category getCategoryById(int id);
    Category saveCategory(Category category);
    Category updateCategory(Category category);
    void deleteCategory(Category category);
    int getNumOfCategory();
    boolean findCategoryByName(String name);

    Category findCategoryById(int id);

    List<Category> getAllCategory();
}
