package com.web.laptoptg.controller.common;

import com.web.laptoptg.dto.UserDTO;
import com.web.laptoptg.model.User;
import com.web.laptoptg.service.UserService;
import com.web.laptoptg.service.impl.UserServiceImpl;
import com.web.laptoptg.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(urlPatterns = "/login")
public class LoginController extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("common/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String alert;
        if(!PasswordUtil.passwordValidate(password)){ // send error message if password is not match rule
            alert = "Mật khẩu không hợp lệ. <br/>Mật khẩu phải chứa ít nhất 8 ký tự<br/>Bao gồm ít nhất một chữ cái viết hoa và một ký tự đặc biệt<br/>Bao gồm ít nhất một ký tự số";
            req.setAttribute("passwordError", alert);
            req.getRequestDispatcher("common/login.jsp").forward(req, resp);
        } else { // check email and password in database
            User user = userService.login(email, password);
            if(user != null){
                String status = user.getStatus();
                if (status.equals("active")){ // check account status if user exist
                    UserDTO userDTO = new UserDTO();
                    userDTO.setId(user.getId());
                    userDTO.setEmail(user.getEmail());
                    userDTO.setRole(user.getRole().getRoleName());
                    userDTO.setUserName(user.getUserName());
                    userDTO.setAddress(user.getAddress());
                    userDTO.setPhoneNumber(user.getPhoneNumber());
                    HttpSession session = req.getSession();
                    session.setAttribute("account", userDTO);
                    resp.sendRedirect(req.getContextPath() + "/waiting");
                } else { // return error message if account status is inactive
                    alert = "Tài khoản của bạn đã bị khóa, vui lòng liên hệ đến cửa hàng để khôi phục!";
                    req.setAttribute("accountError", alert);
                    req.getRequestDispatcher("common/login.jsp").forward(req, resp);
                }
            } else { // return error message if user not found in database
                alert = "Email hoặc mật khẩu sai. Xin vui lòng nhập lại!";
                req.setAttribute("accountError", alert);
                req.getRequestDispatcher("common/login.jsp").forward(req, resp);
            }
        }
    }
}
