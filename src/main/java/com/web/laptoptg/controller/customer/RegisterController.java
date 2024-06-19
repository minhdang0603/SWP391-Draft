package com.web.laptoptg.controller.customer;

import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.config.Status;
import com.web.laptoptg.dto.UserDTO;
import com.web.laptoptg.model.Cart;
import com.web.laptoptg.model.User;
import com.web.laptoptg.service.CartService;
import com.web.laptoptg.service.UserService;
import com.web.laptoptg.service.impl.CartServiceImpl;
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
import java.security.NoSuchAlgorithmException;

@WebServlet(urlPatterns = {"/register", "/verify"})
public class RegisterController extends HttpServlet {

    private UserService userService;
    private CartService cartService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
        cartService = new CartServiceImpl();
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


    private void getVerifyCode(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        UserDTO account = (UserDTO) session.getAttribute("account");
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        // redirect to authorization if user already logged in
        if (account != null) {
            resp.sendRedirect(req.getContextPath() + "/waiting");
            return;
        }

        // send alert message when otp not match
        String check = req.getParameter("index");
        String error = req.getParameter("error");
        if (error != null && error.equals("1")) {
            // check entries number
            Integer entriesNumber = (Integer) session.getAttribute("entriesNumber");
            // create entries number if do not exist
            if (entriesNumber == null) {
                entriesNumber = 1;
                session.setAttribute("entriesNumber", entriesNumber);
                req.setAttribute("alert", "Mã xác thực không chính xác. Bạn còn " + (5 - entriesNumber) + " lần nhập!");
                req.getRequestDispatcher("customer/verify.jsp").forward(req, resp);
                return;
            }

            entriesNumber++;
            // if otp wrong 5 times system redirect to register page and show error message
            if (entriesNumber >= 5) {
                session.removeAttribute("entriesNumber");
                session.removeAttribute("user");
                session.setAttribute("verifyError", "Bạn đã nhập quá số lần cho phép!");
                resp.sendRedirect(req.getContextPath() + "/register");
                return;
            }

            session.setAttribute("entriesNumber", entriesNumber);
            req.setAttribute("alert", "Mã xác thực không chính xác. Bạn còn " + (5 - entriesNumber) + " lần nhập!");
            req.getRequestDispatcher("customer/verify.jsp").forward(req, resp);
            return;
        }

        // resend email when user click resend
        if (check != null && check.equals("1")) {
            Email sm = new Email();
            String code = PasswordUtils.generateOtp(6);
            user.setCode(PasswordUtils.hash(code));
            String title = "Email xác nhận đăng ký tài khoản";
            String content = getContent(code);
            if (sm.sendEmail(user, title, content)) { // redirect to verify page with encrypted code
                session.setAttribute("user", user);
                resp.sendRedirect(req.getContextPath() + "/verify?code=" + user.getCode());
                return;
            }
        }

        req.getRequestDispatcher("customer/verify.jsp").forward(req, resp);
    }

    private void getRegisterPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        UserDTO account = (UserDTO) session.getAttribute("account");
        if (account != null) {
            resp.sendRedirect(req.getContextPath() + "/waiting");
        } else {
            req.getRequestDispatcher("customer/register.jsp").forward(req, resp);
        }
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

        // convert inputted code to string
        String[] optArray = req.getParameterValues("opt");
        StringBuilder builder = new StringBuilder();
        for (String s : optArray) {
            builder.append(s);
        }
        String otp = builder.toString();
        HttpSession session = req.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");
        boolean checkOtp = PasswordUtils.verify(otp, user.getCode());

        if (!checkOtp) { // if otp is not match require to re-enter otp
            resp.sendRedirect(req.getContextPath() + "/verify?error=1");
            return;
        }

        // else redirect to home page and register successful
        user.setEmail(user.getEmail());
        user.setStatus(Status.ACTIVE);
        User temp = userService.register(user);
        Cart cart = new Cart();
        cart.setUser(temp);
        cartService.saveCart(cart);
        session.removeAttribute("user");
        session.setAttribute("registerSuccess", "Đăng ký tài khoản thành công!");
        resp.sendRedirect(req.getContextPath() + "/login");
    }

    private void postRegister(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, NoSuchAlgorithmException {
        // get parameters
        String firstName = req.getParameter("first_name");
        String lastName = req.getParameter("last_name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String alert;
        HttpSession session = req.getSession();

        if (userService.findUserByEmail(email) != null) { // check existing email
            alert = "Email đã tồn tại";
            req.setAttribute("email", email);
            req.setAttribute("first_name", firstName);
            req.setAttribute("last_name", lastName);
            req.setAttribute("emailAlert", alert);
            req.getRequestDispatcher("customer/register.jsp").forward(req, resp);
            return;
        }

        // send otp email
        Email sm = new Email();
        UserDTO userDTO = new UserDTO();
        userDTO.setUserName(firstName + " " + lastName);
        userDTO.setEmail(email);
        userDTO.setPassword(PasswordUtils.hash(password));

        // encrypt the code to sha-256
        String code = PasswordUtils.generateOtp(6);
        userDTO.setCode(PasswordUtils.hash(code));
        userDTO.setStatus(Status.INACTIVE);
        userDTO.setRole("MEMBER");
        String title = "Email xác nhận đăng ký tài khoản";
        String content = getContent(code);

        // fail to send email
        if (!sm.sendEmail(userDTO, title, content)) {
            alert = "Không gửi được email. Xin vui lòng kiểm tra lại email đăng ký!";
            req.setAttribute("emailError", alert);
            req.getRequestDispatcher("customer/register.jsp").forward(req, resp);
            return;
        }

        // redirect to verify page with encrypted code
        session.setAttribute("user", userDTO);
        resp.sendRedirect(req.getContextPath() + "/verify?code=" + userDTO.getCode());
    }

    private String getContent(String code) { // get content for send email
        return "<!DOCTYPE html>\n"
                + "<html>\n"
                + "<head>\n"
                + "</head>\n"
                + "<body>\n"
                + "\n"
                + "<h3 style=\"font-weight: bold;\">Mã xác nhận đăng ký tài khoản</h3>\n"
                + "<h5>Mã xác nhận của bạn là: " + code + "</h5>\n"
                + "\n"
                + "</body>\n"
                + "</html>";
    }

    @Override
    public void destroy() {
        JPAConfig.shutdown();
    }
}
