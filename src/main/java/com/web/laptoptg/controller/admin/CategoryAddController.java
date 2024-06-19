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

@WebServlet(urlPatterns = "/admin/category-add")
public class CategoryAddController extends HttpServlet {
    private CategoryService categoryService;

    @Override
    public void init() throws ServletException {
        categoryService = new CategoryServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("../admin/category-manage").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String catename = req.getParameter("categoryName");

        //check whether category already exist or not
        boolean cateCheckExist = categoryService.findCategoryByName(catename);
        String msg;
        if (cateCheckExist) {//if category already exists
            msg = "Danh mục đã tồn tại! Thêm mới không thành công";
//            req.setAttribute("msg", msg);//send message back
//            doGet(req, resp);
        } else {//if not exist
            Category cate = new Category();
            cate.setCategoryName(catename);
            categoryService.saveCategory(cate);

            boolean list = categoryService.findCategoryByName(catename);
            if (!list) {
                msg = "Có lỗi! Thêm Không Thành Công!";
            } else {
                msg = "Thêm Thành Công!";
            }
        }

//            req.setAttribute("msg", msg);
        req.getSession().setAttribute("msg", msg);
        resp.sendRedirect(req.getContextPath() + "/admin/category-manage");
    }

    @Override
    public void destroy() {
        JPAConfig.shutdown();
    }
}

