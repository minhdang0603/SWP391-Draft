package com.web.laptoptg.controller.admin;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.model.Brand;
import com.web.laptoptg.model.Category;
import com.web.laptoptg.model.Product;
import com.web.laptoptg.service.BrandService;
import com.web.laptoptg.service.CategoryService;
import com.web.laptoptg.service.ProductService;
import com.web.laptoptg.service.impl.BrandServiceImpl;
import com.web.laptoptg.service.impl.CategoryServiceImpl;
import com.web.laptoptg.service.impl.ProductServiceImpl;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;

@WebServlet(urlPatterns = "/admin/product-update")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 11
)
public class ProductUpdateController extends HttpServlet {
    private ProductService productService;
    private CategoryService categoryService;
    private BrandService brandService;

    @Override
    public void init() throws ServletException {
        productService = new ProductServiceImpl();
        categoryService = new CategoryServiceImpl();
        brandService = new BrandServiceImpl();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pname = req.getParameter("productName");
        String status = req.getParameter("productStatus");
        int pid = Integer.parseInt(req.getParameter("productID"));
        int brandID = Integer.parseInt(req.getParameter("productBrand"));
        int cateID = Integer.parseInt(req.getParameter("productCategory"));
        int price = Integer.parseInt(req.getParameter("unitPrice"));
        String os = req.getParameter("operatingSystem");
        String cpu = req.getParameter("cpu");
        String ram = req.getParameter("ram");
        String screen = req.getParameter("monitorScale");
        String battery = req.getParameter("batteryVol");
        String design = req.getParameter("design");
        String warranty = req.getParameter("maintenance");
        String description = req.getParameter("description");
        int stockUnit = Integer.parseInt(req.getParameter("stockUnit"));
        int soldUnit = Integer.parseInt(req.getParameter("soldUnit"));

        Product proOld = productService.findProductById(pid);

        //update image
        String uploadPath = req.getServletContext().getRealPath("/assets/img/product-img");// set path
        Part filePart = req.getPart("image");//get file from request
        String img = proOld.getId()+".png";

        String filePath = uploadPath + File.separator + img;
        // Lưu tệp
        try {
            filePart.write(filePath);
        } catch (IOException e) {
            e.printStackTrace();
        }

        String msg;

        Brand brand = brandService.getBrandById(brandID);
        Category category = categoryService.getCategoryById(cateID);
        Product pro = new Product();
        pro.setId(pid);
        pro.setStatus(status);
        pro.setCpu(cpu);
        pro.setUnitPrice(price);
        pro.setSoldUnit(soldUnit);
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
        pro.setImage(img);
        productService.updateProduct(pro);
        Product proNew = productService.findProductById(pid);

        msg = "Chỉnh Sửa Thành Công Sản Phẩm ID" + pro.getId();
        req.getSession().setAttribute("msg", msg);
        resp.sendRedirect(req.getContextPath() + "/admin/product-manage");
    }

    @Override
    public void destroy() {
        JPAConfig.shutdown();
    }
}

