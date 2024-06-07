package com.web.laptoptg.dao.impl;

import com.web.laptoptg.dao.CategoryDAO;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class CategoryDAOImplTest {

    private CategoryDAO categoryDAO;

    @BeforeEach
    void setUp() throws Exception {
        categoryDAO = new CategoryDAOImpl();
    }

    @Test
    void testGetCategoryById() throws Exception {
        assertNull(categoryDAO.getCategoryById(11));
    }

}