package com.web.laptoptg.dao;

import com.web.laptoptg.model.Category;

import java.util.List;

public interface CategoryDAO {
    Category getCategoryById(int id);
    Category saveCategory(Category category);
    Category updateCategory(Category category);
    void deleteCategory(Category category);

    List<Category> getAll();
    //find product by its name
    boolean findCategoryByName(String name);
    int getNumOfCategory();

    Category findCategoryById(int id);
}
