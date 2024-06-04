package com.web.laptoptg.controller.common;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.web.laptoptg.config.Constrants;
import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dto.GoogleUserDTO;
import com.web.laptoptg.dto.UserDTO;
import com.web.laptoptg.model.User;
import com.web.laptoptg.service.UserService;
import com.web.laptoptg.service.impl.UserServiceImpl;
import com.web.laptoptg.util.PasswordUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;

import java.io.IOException;

@WebServlet(urlPatterns = {"/login", "/logout", "/google_login_handler"})
public class LoginController extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        UserDTO userDTO = (UserDTO) session.getAttribute("account");
        String url = req.getRequestURL().toString();
        if (url.contains("google_login_handler")) { // go to login page
            googleLoginHandler(req, resp);
        } else if (url.contains("login")) {
            getLogin(req, resp, userDTO);
        } else if (url.contains("logout")) { // execute log out
            session.removeAttribute("account");
            session.removeAttribute("cart");
            Cookie[] cookies = req.getCookies();
            deleteCookie(cookies, resp);
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }

    private void deleteCookie(Cookie[] cookies, HttpServletResponse resp) {
        if(cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("cart")) {
                    cookie.setMaxAge(0);
                    resp.addCookie(cookie);
                }
            }
        }
    }

    public void googleLoginHandler(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String code = req.getParameter("code");
        String accessToken = getToken(code);
        GoogleUserDTO googleUserDTO = getUserInfo(accessToken);
        User user = userService.findUserByEmail(googleUserDTO.getEmail());
        UserDTO userDTO = new UserDTO();
        HttpSession session = req.getSession();

        // create user in database if user is not existed
        if (user == null) {
            userDTO.setEmail(googleUserDTO.getEmail());
            userDTO.setStatus("active");
            userDTO.setRole("MEMBER");
            userDTO.setUserName(googleUserDTO.getName());
            String generatedPassword = PasswordUtils.generatePassword(8);
            userDTO.setPassword(PasswordUtils.hash(generatedPassword));
            userService.register(userDTO);
            session.setAttribute("account", userDTO);
            resp.sendRedirect(req.getContextPath() + "/waiting");
            return;
        }

        // check account status
        if (user.getStatus().equals("inactive")) {
            String alert = "Tài khoản của bạn đã bị khóa. Xin vui lòng liên hệ với LaptopTG store để khôi phục tài khoản!";
            req.setAttribute("accountError", alert);
            req.getRequestDispatcher("common/login.jsp").forward(req, resp);
            return;
        }

        // get user in database and do log in function
        userDTO.setId(user.getId());
        userDTO.setEmail(user.getEmail());
        userDTO.setStatus(user.getStatus());
        userDTO.setUserName(user.getUserName());
        userDTO.setAddress(user.getAddress());
        userDTO.setPhoneNumber(user.getPhoneNumber());
        userDTO.setRole(user.getRole().getRoleName());
        session.setAttribute("account", userDTO);
        resp.sendRedirect(req.getContextPath() + "/waiting");
    }

    private String getToken(final String code) throws IOException {
        // call api to get token
        String response = Request
                .Post(Constrants.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(Form.form()
                        .add("client_id", Constrants.GOOGLE_CLIENT_ID)
                        .add("client_secret", Constrants.GOOGLE_CLIENT_SECRET)
                        .add("redirect_uri", Constrants.GOOGLE_REDIRECT_URI).add("code", code)
                        .add("grant_type", Constrants.GOOGLE_GRANT_TYPE).build())
                .execute().returnContent().asString();
        JsonObject jsonObject = new Gson().fromJson(response, JsonObject.class);
        return jsonObject.get("access_token").toString().replaceAll("\"", "");
    }

    private GoogleUserDTO getUserInfo(final String accessToken) throws IOException {
        // get user information by using token
        String link = Constrants.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();
        return new Gson().fromJson(response, GoogleUserDTO.class);
    }

    private void getLogin(HttpServletRequest req, HttpServletResponse resp, UserDTO userDTO) throws ServletException, IOException {
        if (userDTO != null) { // check if user already logged in
            resp.sendRedirect(req.getContextPath() + "/waiting");
            return;
        }

        // redirect login page
        req.getRequestDispatcher("common/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String alert;
        if (req.getSession().getAttribute("account") != null) { // check user already logged in
            resp.sendRedirect(req.getContextPath() + "/waiting");
            return;
        }

        // check email and password in database
        User user = userService.login(email, password);
        if (user == null) { // return error message if user not found in database
            alert = "Email hoặc mật khẩu sai. Xin vui lòng nhập lại!";
            req.setAttribute("accountError", alert);
            req.getRequestDispatcher("common/login.jsp").forward(req, resp);
            return;
        }

        // check account status
        if (user.getStatus().equals("inactive")) {
            alert = "Tài khoản của bạn đã bị khóa. Xin vui lòng liên hệ với LaptopTG store để khôi phục tài khoản!";
            req.setAttribute("accountError", alert);
            req.getRequestDispatcher("common/login.jsp").forward(req, resp);
            return;
        }

        UserDTO userDTO = new UserDTO();
        userDTO.setId(user.getId());
        userDTO.setEmail(user.getEmail());
        userDTO.setRole(user.getRole().getRoleName());
        userDTO.setUserName(user.getUserName());
        userDTO.setAddress(user.getAddress());
        userDTO.setPhoneNumber(user.getPhoneNumber());
        session.setAttribute("account", userDTO);
        resp.sendRedirect(req.getContextPath() + "/waiting");
    }

    @Override
    public void destroy() {
        JPAConfig.shutdown();
    }
}
