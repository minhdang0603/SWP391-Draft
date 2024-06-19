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

@WebServlet(urlPatterns = "/admin/brand-delete")
public class BrandDeleteController extends HttpServlet {
    private BrandService brandService;

    @Override
    public void init() throws ServletException {
        brandService = new BrandServiceImpl();
    }
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int brandId = Integer.parseInt(req.getParameter("brandId"));
        Brand brand = brandService.findBrandById(brandId);
        brandService.deleteBrand(brand);

        String msg;
        msg = "Danh mục đã xóa thành công!";
        req.getSession().setAttribute("msg", msg);
        resp.sendRedirect(req.getContextPath() + "/admin/brand-manage");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req,resp);
    }

    @Override
    public void destroy() {
        JPAConfig.shutdown();
    }
}
