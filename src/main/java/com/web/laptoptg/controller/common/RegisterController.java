package com.web.laptoptg.controller.common;

import com.web.laptoptg.dto.UserDTO;
import com.web.laptoptg.service.UserService;
import com.web.laptoptg.service.impl.UserServiceImpl;
import com.web.laptoptg.util.Email;
import com.web.laptoptg.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;

@WebServlet(urlPatterns = {"/register", "/verify"})
public class RegisterController extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURL().toString();

        // redirect to required page
        if (url.contains("register")) {
            getRegisterPage(req, resp);
        } else if (url.contains("verify")) {
            getVerifyCode(req, resp);
        }
    }

    // call when user click on resend otp
    private void getVerifyCode(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String check = req.getParameter("index");
        String error = req.getParameter("error");
        if (error != null && error.equals("1")){ // send alert message when otp not match
            req.setAttribute("alert", "Mã xác thực không chính xác. Vui lòng nhập lại!");
        } else if (error != null && error.equals("2")) {
            req.setAttribute("alert", "Mã xác thực đã hết hạn. Vui lòng chọn gửi lại!");
        }`

        if (check != null && check.equals("1")) {
            try {
                Email sm = new Email();
                HttpSession session = req.getSession();
                UserDTO user = (UserDTO) session.getAttribute("user");
                String code = sm.getRandom();
                user.setCode(PasswordUtil.encryptToSHA256(code));
                String title = "Email xác nhận đăng ký tài khoản";
                String content = "<!DOCTYPE html>\n"
                        + "<html>\n"
                        + "<head>\n"
                        + "</head>\n"
                        + "<body>\n"
                        + "\n"
                        + "<h3 style=\"font-weight: bold;\">Mã xác nhận đăng ký tài khoản</h3>\n"
                        + "<h4>Mã xác nhận của bạn là: " + code + "</h4>\n"
                        + "\n"
                        + "</body>\n"
                        + "</html>";
                if (sm.sendEmail(user, title, content)) { // redirect to verify page with encrypted code
                    session.setAttribute("user", user); // save user to session
                    resp.sendRedirect(req.getContextPath() + "/verify?code=" + user.getCode());
                }
            } catch (NoSuchAlgorithmException e) {
                throw new RuntimeException(e);
            }
        } else {
            req.getRequestDispatcher("customer/verify.jsp").forward(req, resp);
        }
    }

    private void getRegisterPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("customer/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURL().toString();
        try {
            if (url.contains("register")) {
                postRegister(req, resp);
            } else if (url.contains("verify")) {
                postVerifyCode(req, resp);
            }
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    private void postVerifyCode(HttpServletRequest req, HttpServletResponse resp) throws NoSuchAlgorithmException, IOException {
        String[] optArray = req.getParameterValues("opt");
        StringBuilder builder = new StringBuilder();
        for (String s : optArray) {
            builder.append(s);
        }
        String otp = builder.toString();
        HttpSession session = req.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user != null){ // check user input data exist in session
            boolean checkOtp = PasswordUtil.verify(otp, user.getCode());
            if (checkOtp) { // if otp match redirect to home page and register successful
                user.setEmail(user.getEmail());
                user.setStatus("active");
                user.setCode("");
                userService.updateUser(user);
                session.setAttribute("user", user);
                session.removeAttribute("user");
                session.invalidate();
                resp.sendRedirect(req.getContextPath() + "/login");
            } else { // else require to re-enter otp
                resp.sendRedirect(req.getContextPath() + "/verify?error=1");
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/verify?error=2");
        }
    }

    private void postRegister(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, NoSuchAlgorithmException {
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");
        // get parameters
        String firstName = req.getParameter("first_name");
        String lastName = req.getParameter("last_name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirm_password");
        String alert = "";
        HttpSession session = req.getSession();
        if (userService.findUserByEmail(email) != null) { // check existing email - error type 1
            alert = "Email đã tồn tại";
            req.setAttribute("email", email);
            req.setAttribute("first_name", firstName);
            req.setAttribute("last_name", lastName);
            req.setAttribute("emailAlert", alert);
            req.getRequestDispatcher("customer/register.jsp").forward(req, resp);
        } else if (!PasswordUtil.passwordValidate(password)) { // check password validate - error type 2
            alert = "Mật khẩu không hợp lệ. <br/>Mật khẩu phải chứa ít nhất 8 ký tự<br/>Bao gồm ít nhất một chữ cái viết hoa và một ký tự đặc biệt<br/>Bao gồm ít nhất một ký tự số";
            req.setAttribute("email", email);
            req.setAttribute("first_name", firstName);
            req.setAttribute("last_name", lastName);
            req.setAttribute("passwordAlert", alert);
            req.getRequestDispatcher("customer/register.jsp").forward(req, resp);
        } else if (!confirmPassword.equals(password)) { // check confirm pasword match password - error type 3
            alert = "Xác nhận mật khẩu không khớp. Vui lòng kiểm tra lại.";
            email = PasswordUtil.encryptToSHA256(email);
            lastName = PasswordUtil.encryptToSHA256(lastName);
            firstName = PasswordUtil.encryptToSHA256(firstName);
            req.setAttribute("email", email);
            req.setAttribute("first_name", firstName);
            req.setAttribute("last_name", lastName);
            req.setAttribute("confirmPasswordAlert", alert);
            req.getRequestDispatcher("customer/register.jsp").forward(req, resp);
        } else { // send otp email
            Email sm = new Email();
            UserDTO userDTO = new UserDTO();
            userDTO.setUserName(firstName + " " + lastName);
            userDTO.setEmail(email);
            userDTO.setPassword(PasswordUtil.encryptToSHA256(password));
            // encrypt the code to sha-256
            String code = sm.getRandom();
            userDTO.setCode(PasswordUtil.encryptToSHA256(code));
            userDTO.setStatus("inactive");
            userDTO.setRole("MEMBER");
            String title = "Email xác nhận đăng ký tài khoản";
            String content = "<!DOCTYPE html>\n"
                    + "<html>\n"
                    + "<head>\n"
                    + "</head>\n"
                    + "<body>\n"
                    + "\n"
                    + "<h3 style=\"font-weight: bold;\">Mã xác nhận đăng ký tài khoản</h3>\n"
                    + "<h4>Mã xác nhận của bạn là: " + code + "</h4>\n"
                    + "\n"
                    + "</body>\n"
                    + "</html>";
            if (sm.sendEmail(userDTO, title, content)) { // redirect to verify page with encrypted code
                session.setAttribute("user", userDTO); // save user to session
                if (userService.register(userDTO)){
                    resp.sendRedirect(req.getContextPath() + "/verify?code=" + userDTO.getCode());
                } else { // can not save to database - error type 4
                   alert = "Lỗi hệ thống!";
                   req.setAttribute("systemError", alert);
                   req.getRequestDispatcher("customer/register.jsp").forward(req, resp);
                }
            } else { // fail ot send email - error type 5
                alert = "Xin vui lòng kiểm tra lại email đăng ký!";
                req.setAttribute("emailError", alert);
                req.getRequestDispatcher("customer/register.jsp").forward(req, resp);
            }
        }
    }
}
