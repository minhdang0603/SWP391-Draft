package com.web.laptoptg.controller.admin;

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
        String id = req.getParameter("idDelete");
        if (id != null) {
            userService.deleteById(Integer.parseInt(id));
        }
        List<User> listUser = userService.findAllUsers();
        //System.out.println(listUser);
        req.setAttribute("listUser", listUser);
        req.getRequestDispatcher("account-manage.jsp").forward(req, resp);
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
        String repassword = request.getParameter("repassword");


        String hashPass = PasswordUtils.hash(password);


        UserDTO userDTO = new UserDTO();
        userDTO.setUserName(userName);
        userDTO.setEmail(email);
        userDTO.setAddress(address);
        userDTO.setPhoneNumber(phoneNumber);
        userDTO.setRole(role);
        userDTO.setPassword(hashPass);
        userDTO.setStatus(status);

        //add vào data base
        userService.addUser(userDTO);


        User raw = userService.findUserByEmail(email);
        Cart cart = new Cart();
        cart.setUser(raw);
        cartService.saveCart(cart);
        System.out.println(raw);
        System.out.println(userDTO);

        response.sendRedirect(request.getContextPath() + "/admin/account-manage");
    }

    public void editAcc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userName = request.getParameter("userName");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String role = request.getParameter("role");
        String status = request.getParameter("status");


        UserDTO userDTO = new UserDTO();
        userDTO.setUserName(userName);
        userDTO.setAddress(address);
        userDTO.setEmail(email);
        userDTO.setPhoneNumber(phoneNumber);
        userDTO.setRole(role);
        userDTO.setStatus(status);

        System.out.println("Status: " + status);

        userService.updateUser(userDTO);
        response.sendRedirect(request.getContextPath() + "/admin/account-manage");
    }


}
