package com.web.laptoptg.controller.admin;

import com.web.laptoptg.model.Brand;
import com.web.laptoptg.model.Category;
import com.web.laptoptg.model.Product;
import com.web.laptoptg.service.BrandService;
import com.web.laptoptg.service.CategoryService;
import com.web.laptoptg.service.ProductService;
import com.web.laptoptg.service.impl.BrandServiceImpl;
import com.web.laptoptg.service.impl.CategoryServiceImpl;
import com.web.laptoptg.service.impl.ProductServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/admin/product-add")
public class ProductAddController extends HttpServlet {

    private ProductService productService;
    private CategoryService categoryService;
    private BrandService brandService;

    public void init() throws ServletException {
        productService = new ProductServiceImpl();
        categoryService = new CategoryServiceImpl();
        brandService = new BrandServiceImpl();
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pname = req.getParameter("productName");
        System.out.print(pname);
        int brandID = Integer.parseInt(req.getParameter("productBrand"));
        int cateID = Integer.parseInt(req.getParameter("productCategory"));
        int price = Integer.parseInt(req.getParameter("unitPrice"));
        String os = req.getParameter("os");
        String cpu = req.getParameter("cpu");
        String ram = req.getParameter("ram");
        String screen = req.getParameter("screen");
        String battery = req.getParameter("battery");
        String design = req.getParameter("design");
        String warranty = req.getParameter("warranty");
        String description = req.getParameter("description");
        int stockUnit = Integer.parseInt(req.getParameter("stockUnit"));
        boolean success = true;
//        Product proCheck = productService.findProductByName("pname");
//        if(proCheck != null){
//            success = false;
//            System.out.println(proCheck.getId());
//            resp.setContentType("application/json");
//            resp.setCharacterEncoding("UTF-8");
//            resp.getWriter().write("{\"success\": " + success + "}");
//        }
        Brand brand = brandService.getBrandById(brandID);
        Category category = categoryService.getCategoryById(cateID);
        Product pro = new Product();
        pro.setCpu(cpu);
        pro.setUnitPrice(price);
        pro.setSoldUnit(0);
        pro.setStockUnit(stockUnit);
        pro.setBatteryVol(battery);
        pro.setOperatingSystem(os);
        pro.setDescription(description);
        pro.setMonitorScale(screen);
        pro.setBrand(brand);
        pro.setCategory(category);
        pro.setRam(ram);
        pro.setProductName(pname);
        pro.setDesign(design);
        pro.setMaintenance(warranty);
        productService.saveProduct(pro);
//        System.out.print("Added!");
//        resp.setContentType("application/json");
//        resp.setCharacterEncoding("UTF-8");
//        resp.getWriter().write("{\"success\": " + success + "}");
        resp.sendRedirect("admin/product-manage");
    }

}
