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
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/admin/product-add")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 11
)
public class ProductAddController extends HttpServlet {

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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("../admin/product-manage").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //get parameters from request scope
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
        String status = req.getParameter("productStatus");
        int stockUnit = Integer.parseInt(req.getParameter("stockUnit"));


        //check whether product already exist or not
        boolean proCheckExist = productService.findProductByName(pname);
        String msg;
        if (proCheckExist) {//if product already exists
            msg = "Sản phẩm đã tồn tại! Thêm mới không thành công";
//            req.setAttribute("msg", msg);//send message back
//            doGet(req, resp);
        } else {//if not exist
            Brand brand = brandService.getBrandById(brandID);
            Category category = categoryService.getCategoryById(cateID);
            Product pro = new Product();
            pro.setCpu(cpu);
            pro.setStatus(status);
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


            //save the new product to database
            productService.saveProduct(pro);
            int pid = pro.getId();
            pro.setImage(pid + ".png");
            String img = pro.getImage();
            productService.saveProduct(pro);

            String uploadPath = req.getServletContext().getRealPath("/assets/img/product-img");// set path
            Part filePart = req.getPart("image");//get file from request
            String filePath = uploadPath + File.separator + img;
            System.out.println(filePath);
            // Lưu tệp
            try {
                filePart.write(filePath);
            } catch (IOException e) {
                e.printStackTrace();
            }
            //check if saved to db or not yet
            boolean list = productService.findProductByName(pname);
            if (!list) {
                msg = "Có lỗi! Thêm Không Thành Công!";
            } else {
                msg = "Thêm Thành Công!";
            }
        }
//            req.setAttribute("msg", msg);
        req.getSession().setAttribute("msg", msg);
        resp.sendRedirect(req.getContextPath() + "/admin/product-manage");
    }

    @Override
    public void destroy() {
        JPAConfig.shutdown();
    }
}

