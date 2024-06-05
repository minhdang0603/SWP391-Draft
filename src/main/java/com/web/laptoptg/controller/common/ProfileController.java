package com.web.laptoptg.controller.common;

import com.web.laptoptg.dto.UserDTO;
import com.web.laptoptg.model.User;
import com.web.laptoptg.service.UserService;
import com.web.laptoptg.service.impl.UserServiceImpl;
import com.web.laptoptg.util.PasswordUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/profile")
public class ProfileController extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        UserDTO account = (UserDTO) session.getAttribute("account");
        if (account == null) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        req.getRequestDispatcher("common/users-profile.jsp").forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String formType = req.getParameter("formType");
        HttpSession session = req.getSession();
        UserDTO userDTO = (UserDTO) session.getAttribute("account");

        if ("form1".equals(formType)) {
            handleProfileEdit(req, resp, userDTO,session);
        } else if ("form2".equals(formType)) {
            handleChangePassword(req, resp, userDTO,session);
        }
    }

    private void handleProfileEdit(HttpServletRequest req, HttpServletResponse resp, UserDTO userDTO, HttpSession session) throws ServletException, IOException {
        // Lấy dữ liệu từ form
        String fullName = req.getParameter("fullName");
        String address = req.getParameter("address");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");

        userDTO.setUserName(fullName);
        userDTO.setAddress(address);
        userDTO.setPhoneNumber(phone);
        if(checkEmailExit(email)){
            userDTO.setEmail(email);
        }

        userService.updateUser(userDTO);
        session.setAttribute("updateSuccess", "Cập nhật thông tin thành công!");
        resp.sendRedirect(req.getContextPath() + "/profile");
    }

    public boolean checkEmailExit(String email){
        List<User> list = userService.findAllUsers();
        for(User user : list){
            if(user.getEmail().equals(email)){
                return false;
            }
        }
        return true;
    }


    private void handleChangePassword(HttpServletRequest req, HttpServletResponse resp, UserDTO userDTO, HttpSession session) throws ServletException, IOException {
        String password = req.getParameter("password");
        String newPass = req.getParameter("newpassword");
        String reNewPass = req.getParameter("renewpassword");

        UserDTO account = (UserDTO) session.getAttribute("account");
        // Lấy user từ db
        User raw = userService.findUserByEmail(account.getEmail());

        try {
            if (PasswordUtils.verify(password, raw.getPassword())) {
                String hashPass = PasswordUtils.hash(newPass);

                userDTO.setPassword(hashPass);
                userService.changePassword(userDTO, hashPass);
                userService.updateUser(userDTO);

                System.out.println(userDTO);
                System.out.println(raw);

                session.setAttribute("account", userDTO);
                session.setAttribute("resetSuccess", "Đã thay đổi mật khẩu thành công!!!");
                session.removeAttribute("resetFail"); // Xóa thông báo lỗi nếu có
                resp.sendRedirect(req.getContextPath() + "/profile");
            } else {
                session.setAttribute("resetFail", "Thay đổi mật khẩu không thành công!");
                session.removeAttribute("resetSuccess"); // Xóa thông báo thành công nếu có
                resp.sendRedirect(req.getContextPath() + "/profile");
            }
        } catch (Exception e) {
            System.err.println("Error during password change: " + e.getMessage());
            session.setAttribute("resetFail", "Thay đổi mật khẩu không thành công!");
            session.removeAttribute("resetSuccess"); // Xóa thông báo thành công nếu có
            resp.sendRedirect(req.getContextPath() + "/profile");
        }
    }
}
