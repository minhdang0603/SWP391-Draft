package com.web.laptoptg.controller.admin;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.model.Category;
import com.web.laptoptg.service.CategoryService;
import com.web.laptoptg.service.impl.CategoryServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;

@WebServlet(urlPatterns = "/admin/category-update")
public class CategoryUpdateController extends HttpServlet {
    private CategoryService categoryService;

    @Override
    public void init() throws ServletException {
        categoryService = new CategoryServiceImpl();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String cateName = req.getParameter("categoryName");
        int cateId = Integer.parseInt(req.getParameter("categoryID"));
        String msg;

        Category cate = new Category();
        cate.setId(cateId);
        cate.setCategoryName(cateName);

        categoryService.updateCategory(cate);
        Category cateNew = categoryService.findCategoryById(cateId);

        msg = "Chỉnh Sửa Thành Công Danh Mục ID" + cate.getId();
        req.getSession().setAttribute("msg", msg);
        resp.sendRedirect(req.getContextPath() + "/admin/category-manage");

    }

    @Override
    public void destroy() {
        JPAConfig.shutdown();
    }
}
