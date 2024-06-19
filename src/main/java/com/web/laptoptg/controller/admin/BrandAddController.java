package com.web.laptoptg.controller.admin;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.model.Brand;
import com.web.laptoptg.service.BrandService;
import com.web.laptoptg.service.impl.BrandServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(urlPatterns = "/admin/brand-add")
public class BrandAddController extends HttpServlet {
    private BrandService brandService;
    public void init() throws ServletException {
        brandService = new BrandServiceImpl();
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("../admin/brand-manage").forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String brandName = req.getParameter("brandName");

        //check whether category already exist or not
        boolean cateCheckExist = brandService.findBrandByName(brandName);
        String msg;
        if (cateCheckExist) {//if category already exists
            msg = "Danh mục đã tồn tại! Thêm mới không thành công";
//            req.setAttribute("msg", msg);//send message back
//            doGet(req, resp);
        } else {//if not exist
            Brand brand = new Brand();
            brand.setBrandName(brandName);
            brandService.saveBrand(brand);

            boolean list = brandService.findBrandByName(brandName);
            if (!list) {
                msg = "Có lỗi! Thêm Không Thành Công!";
            } else {
                msg = "Thêm Thành Công!";
            }
        }

//            req.setAttribute("msg", msg);
        req.getSession().setAttribute("msg", msg);
        resp.sendRedirect(req.getContextPath() + "/admin/brand-manage");
    }

    @Override
    public void destroy() {
        JPAConfig.shutdown();
    }
}
