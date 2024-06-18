package com.web.laptoptg.service.impl;

import com.web.laptoptg.dao.CategoryDAO;
import com.web.laptoptg.dao.impl.CategoryDAOImpl;
import com.web.laptoptg.model.Category;
import com.web.laptoptg.service.CategoryService;

import java.util.List;

public class CategoryServiceImpl implements CategoryService {
    private CategoryDAO categoryDAO;

    public CategoryServiceImpl() {
        categoryDAO = new CategoryDAOImpl();
    }

    @Override
    public Category getCategoryById(int id) {
        return categoryDAO.getCategoryById(id);
    }

    @Override
    public Category saveCategory(Category category) {
        return categoryDAO.saveCategory(category);
    }

    @Override
    public Category updateCategory(Category category) {
        return categoryDAO.updateCategory(category);
    }

    @Override
    public void deleteCategory(Category category) {
        categoryDAO.deleteCategory(category);
    }

    @Override
    public int getNumOfCategory() {
        return categoryDAO.getNumOfCategory();
    }

    @Override
    public List<Category> getAllCategory() {
        return categoryDAO.getAll();
    }

    @Override
    public boolean findCategoryByName(String name) {
        return categoryDAO.findCategoryByName(name);
    }

    @Override
    public Category findCategoryById(int id) {
        return categoryDAO.findCategoryById(id);
    }

}
