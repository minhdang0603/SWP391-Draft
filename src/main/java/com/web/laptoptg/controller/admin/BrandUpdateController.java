package com.web.laptoptg.controller.admin;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.model.Brand;
import com.web.laptoptg.model.Category;
import com.web.laptoptg.service.BrandService;
import com.web.laptoptg.service.impl.BrandServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(urlPatterns = "/admin/brand-update")
public class BrandUpdateController extends HttpServlet {
    private BrandService brandService;

    @Override
    public void init() throws ServletException {
        brandService = new BrandServiceImpl();
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String brandName = req.getParameter("brandName");
        int brandId = Integer.parseInt(req.getParameter("brandID"));
        String msg;

        Brand brand = new Brand();
        brand.setId(brandId);
        brand.setBrandName(brandName);

        brandService.updateBrand(brand);
        Brand brandNew = brandService.findBrandById(brandId);

        msg = "Chỉnh Sửa Thành Công Danh Mục ID" + brand.getId();
        req.getSession().setAttribute("msg", msg);
        resp.sendRedirect(req.getContextPath() + "/admin/brand-manage");
    }

    @Override
    public void destroy() {
        JPAConfig.shutdown();
    }
}
