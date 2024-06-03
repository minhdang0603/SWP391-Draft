package com.web.laptoptg.dao;

import com.web.laptoptg.model.Category;

import java.util.List;

public interface CategoryDAO {
    Category getCategoryById(int id);
    void saveCategory(Category category);
    void updateCategory(Category category);
    void deleteCategory(Category category);

    List<Category> getAll();

    int getNumOfCategory();
}
