package com.web.laptoptg.controller.common;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dto.UserDTO;
import com.web.laptoptg.model.User;
import com.web.laptoptg.service.UserService;
import com.web.laptoptg.service.impl.UserServiceImpl;
import com.web.laptoptg.util.Email;
import com.web.laptoptg.util.PasswordUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/forgot-password")
public class ForgotPasswordController extends HttpServlet {

    private UserService userService;
    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        // block user who have already signed in go to forgot password page
        if (session.getAttribute("account") != null) {
            resp.sendRedirect(req.getContextPath() + "/waiting");
            return;
        }

        // block user go straight to forgot password page
        String index = req.getParameter("index");
        if (!(index != null && index.equals("0"))) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        // redirect to forgot password page
        String code = req.getParameter("code");
        req.setAttribute("code", code);
        req.getRequestDispatcher("common/forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String index = req.getParameter("index");

        if (index.equals("1")) { // do send email
            sendEmail(req, resp);
        } else { // do change password
            postChangePassword(req, resp);
        }
    }

    private void postChangePassword(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String password = req.getParameter("password");
        String code = req.getParameter("code");
        List<User> users = userService.findAllUsers();
        UserDTO userDTO = new UserDTO();
        // check user that doing forgot password in database by using hash code
        for (User user : users) {
            if (PasswordUtils.verify(user.getEmail() + user.getPassword(), code)) {
                userDTO.setEmail(user.getEmail());
                userDTO.setPassword(user.getPassword());
            }
        }

        // do change password function and redirect to login page with success message
        userService.changePassword(userDTO, password);
        session.setAttribute("resetSuccess", "Đã thay đổi mật khẩu thành công!");
        resp.sendRedirect(req.getContextPath() + "/login");
    }

    private void sendEmail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String alert;
        User user = userService.findUserByEmail(email);

        if (user == null) { // check existing email
            HttpSession session = req.getSession();
            alert = "Email không tồn tại";
            session.setAttribute("emailAlert", alert);
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // send otp email
        Email sm = new Email();
        HttpSession session = req.getSession();
        UserDTO userDTO = new UserDTO();
        String code = PasswordUtils.hash(email + user.getPassword());
        userDTO.setEmail(user.getEmail());
        userDTO.setPassword(user.getPassword());
        String changePasswordUrl = "http://localhost:8080/laptop-tg/forgot-password?index=0&code=" + code;
        String title = "Email xác nhận thay đổi mật khẩu";
        String content = "<!DOCTYPE html>\n"
                + "<html>\n"
                + "<head>\n"
                + "</head>\n"
                + "<body>\n"
                + "\n"
                + "<h3 style=\"font-weight: bold;\">Xác nhận thay đổi mật khẩu</h3>\n"
                + "<h5>Vào đây để thay đổi mật khẩu: <a href=\"" + changePasswordUrl + "\">Đổi mật khẩu</a></h5>\n"
                + "\n"
                + "</body>\n"
                + "</html>";

        // fail to send email
        if (!sm.sendEmail(userDTO, title, content)) {
            alert = "Không gửi được email. Xin vui lòng kiểm tra lại email đăng ký!";
            session.setAttribute("emailError", alert);
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // send success message
        alert = "Xin vui lòng kiểm tra email!";
        session.setAttribute("emailSuccess", alert);
        resp.sendRedirect(req.getContextPath() + "/login");
    }

    @Override
    public void destroy() {
        JPAConfig.shutdown();
    }
}
