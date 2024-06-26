package com.web.laptoptg.controller.admin;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dto.UserDTO;
import com.web.laptoptg.model.Cart;
import com.web.laptoptg.model.User;
import com.web.laptoptg.service.CartService;
import com.web.laptoptg.service.UserService;
import com.web.laptoptg.service.impl.CartServiceImpl;
import com.web.laptoptg.service.impl.UserServiceImpl;
import com.web.laptoptg.util.PasswordUtils;
import jakarta.mail.Session;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/admin/account-manage")
public class AccountManagement extends HttpServlet {
    private UserService userService;
    private CartService cartService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
        cartService = new CartServiceImpl();
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        UserDTO account = (UserDTO) session.getAttribute("account");
        //kiem tra admin da dang nhap chua
        if (account != null && account.getRole().equals("ADMIN")) {
            String id = req.getParameter("idDelete");
            //xoa tai khoan
            if (id != null) {
                userService.deleteById(Integer.parseInt(id));
                session.setAttribute("successMessage", "Xóa tài khoản thanh công!");
            }
            List<User> listUser = userService.findAllUsers();
            req.setAttribute("listUser", listUser);
            req.setAttribute("successMessage", session.getAttribute("successMessage"));
            req.setAttribute("errorMessage", session.getAttribute("errorMessage"));
            session.removeAttribute("successMessage");
            session.removeAttribute("errorMessage");
            req.getRequestDispatcher("account-manage.jsp").forward(req, resp);
        }else {
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String formType = request.getParameter("formType");

        if (formType.equals("add")) {
            addAcc(request, response);
        }
        if (formType.equals("edit")) {
            editAcc(request, response);
        }
    }

    public void addAcc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userName = request.getParameter("userName");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String phoneNumber = request.getParameter("phoneNumber");
        String role = request.getParameter("role");
        String password = request.getParameter("password");
        String status = request.getParameter("status");

        HttpSession session = request.getSession();
        if (checkEmailExit(email)) {
            String hashPass = PasswordUtils.hash(password);

            UserDTO userDTO = new UserDTO();
            userDTO.setUserName(userName);
            userDTO.setEmail(email);
            userDTO.setAddress(address);
            userDTO.setPhoneNumber(phoneNumber);
            userDTO.setRole(role);
            userDTO.setPassword(hashPass);
            userDTO.setStatus(status);

            userService.addUser(userDTO);

            User raw = userService.findUserByEmail(email);
            if(raw.getRole().getRoleName().equalsIgnoreCase("member")){
                Cart cart = new Cart();
                cart.setUser(raw);
                cartService.saveCart(cart);
            }

            session.setAttribute("successMessage", "Thêm tài khoản thành công!");
        } else {
            session.setAttribute("errorMessage", "Thêm tài khoản thất bại , email đã tồn tại!");
        }
        response.sendRedirect(request.getContextPath() + "/admin/account-manage");
    }

    public void editAcc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userName = request.getParameter("userName");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String role = request.getParameter("role");
        String status = request.getParameter("status");
        String id = request.getParameter("userId");

        User raw = userService.findUserById(Integer.parseInt(id));

        UserDTO userDTO = new UserDTO();
        userDTO.setId(raw.getId());
        userDTO.setUserName(userName);
        userDTO.setAddress(address);
        userDTO.setEmail(email);
        userDTO.setPhoneNumber(phoneNumber);
        userDTO.setRole(role);
        userDTO.setStatus(status);


        userService.updateUser(userDTO);
        HttpSession session = request.getSession();
        session.setAttribute("successMessage", "Sửa đổi thành công!");
        response.sendRedirect(request.getContextPath() + "/admin/account-manage");
    }

    //neu email chua ton tai thi true
    public boolean checkEmailExit(String email){
        User u = userService.findUserByEmail(email);
        if(u == null){
            return true;
        }else{
            return false;
        }
    }

    @Override
    public void destroy() {
        JPAConfig.shutdown();
    }
}
