package com.web.laptoptg.service.impl;

import com.web.laptoptg.dao.CategoryDAO;
import com.web.laptoptg.dao.impl.CategoryDAOImpl;
import com.web.laptoptg.model.Category;
import com.web.laptoptg.service.CategoryService;

public class CategoryServiceImpl implements CategoryService {
    private CategoryDAO categoryDAO = new CategoryDAOImpl();
    @Override
    public Category getCategoryById(int id) {
        return categoryDAO.getCategoryById(id);
    }

    @Override
    public void saveCategory(Category category) {
        categoryDAO.saveCategory(category);
    }

    @Override
    public void updateCategory(Category category) {
        categoryDAO.updateCategory(category);
    }

    @Override
    public void deleteCategory(Category category) {
        categoryDAO.deleteCategory(category);
    }

    @Override
    public int getNumOfCategory() {
        return categoryDAO.getNumOfCategory();
    }
}
