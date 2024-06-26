package com.web.laptoptg.controller.common;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.web.laptoptg.config.Constrants;
import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.config.Status;
import com.web.laptoptg.dto.GoogleUserDTO;
import com.web.laptoptg.dto.UserDTO;
import com.web.laptoptg.model.Cart;
import com.web.laptoptg.model.User;
import com.web.laptoptg.service.CartService;
import com.web.laptoptg.service.UserService;
import com.web.laptoptg.service.impl.CartServiceImpl;
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
    private CartService cartService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
        cartService = new CartServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        UserDTO userDTO = (UserDTO) session.getAttribute("account");
        String url = req.getRequestURL().toString();
        if (url.contains("google_login_handler")) { // handle google login api
            googleLoginHandler(req, resp);
        } else if (url.contains("login")) { // go to login page
            getLogin(req, resp, userDTO);
        } else if (url.contains("logout")) { // execute log out
            session.removeAttribute("account"); // remove user's account in session
            Cookie[] cookies = req.getCookies();
            deleteCookie(cookies, resp); // remove user's cart in cookie
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

    private void googleLoginHandler(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String error = req.getParameter("error");
        if (error != null && error.equals("access_denied")) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String code = req.getParameter("code");

        // redirect to error page
        if(code == null) {
            req.getRequestDispatcher("common/page-error-404.jsp").forward(req, resp);
            return;
        }

        String accessToken = getToken(code);
        GoogleUserDTO googleUserDTO = getUserInfo(accessToken);
        User user = userService.findUserByEmail(googleUserDTO.getEmail());
        UserDTO userDTO = new UserDTO();
        HttpSession session = req.getSession();

        // create user in database if user is not existed
        if (user == null) {
            userDTO.setEmail(googleUserDTO.getEmail());
            userDTO.setStatus(Status.ACTIVE);
            userDTO.setRole("MEMBER");
            userDTO.setUserName(googleUserDTO.getName());
            String generatedPassword = PasswordUtils.generatePassword(8);
            userDTO.setPassword(PasswordUtils.hash(generatedPassword));
            User temp = userService.register(userDTO);
            userDTO.setId(temp.getId());
            Cart cart = new Cart();
            cart.setUser(temp);
            cartService.saveCart(cart);
            session.setAttribute("loginUser", userDTO);
            resp.sendRedirect(req.getContextPath() + "/waiting");
            return;
        }

        // check account status
        if (user.getStatus().equals("inactive")) {
            String alert = "Tài khoản của bạn đã bị khóa. Xin vui lòng liên hệ với LaptopTG store để khôi phục tài khoản!";
            req.getSession().setAttribute("accountError", alert);
            resp.sendRedirect(req.getContextPath() + "/login");
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
        userDTO.setPassword(user.getPassword());
        session.setAttribute("loginUser", userDTO);
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
        HttpSession session = req.getSession();
        session.removeAttribute("accountError");
        session.removeAttribute("emailAlert");
        session.removeAttribute("resetSuccess");
        session.removeAttribute("emailSuccess");
        session.removeAttribute("registerSuccess");
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
            req.getSession().setAttribute("accountError", alert);
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // check account status
        if (user.getStatus().equals("inactive")) {
            alert = "Tài khoản của bạn đã bị khóa. Xin vui lòng liên hệ với LaptopTG store để khôi phục tài khoản!";
            req.getSession().setAttribute("accountError", alert);
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // add account to session and redirect to authorization filter
        UserDTO userDTO = new UserDTO();
        userDTO.setId(user.getId());
        userDTO.setEmail(user.getEmail());
        userDTO.setRole(user.getRole().getRoleName());
        userDTO.setUserName(user.getUserName());
        userDTO.setAddress(user.getAddress());
        userDTO.setPhoneNumber(user.getPhoneNumber());
        userDTO.setStatus(user.getStatus());
        userDTO.setPassword(user.getPassword());
        session.setAttribute("loginUser", userDTO);
        resp.sendRedirect(req.getContextPath() + "/waiting");
    }

    @Override
    public void destroy() {
        JPAConfig.shutdown();
    }
}
