package com.web.laptoptg.controller.admin;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.web.laptoptg.config.JPAConfig;
import com.web.laptoptg.dto.UserDTO;
import com.web.laptoptg.model.Orders;
import com.web.laptoptg.model.Rating;
import com.web.laptoptg.model.User;
import com.web.laptoptg.service.OrderService;
import com.web.laptoptg.service.PaymentService;
import com.web.laptoptg.service.RatingService;
import com.web.laptoptg.service.UserService;
import com.web.laptoptg.service.impl.OrderServiceImpl;
import com.web.laptoptg.service.impl.PaymentServiceImpl;
import com.web.laptoptg.service.impl.RatingServiceImpl;
import com.web.laptoptg.service.impl.UserServiceImpl;
import com.web.laptoptg.util.LocalDateTimeDeserializer;
import com.web.laptoptg.util.LocalDateTimeSerializer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(urlPatterns = "/admin/home")
public class HomeServlet extends HttpServlet {
    private OrderService orderService;
    private UserService userService;

    private RatingService ratingService;

    @Override
    public void init(){
        orderService = new OrderServiceImpl();
        userService = new UserServiceImpl();
        ratingService = new RatingServiceImpl();
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        UserDTO user = (UserDTO) session.getAttribute("account");
        String filterType = req.getParameter("filterType");
        List<Orders> ordersList = orderService.getAllOrders();
        List<Orders> ordersListforSaler = orderService.searchOrdersByCusID(user.getId());
        List<User> userList = userService.findUserByRole("MEMBER");
        List<Rating> ratingList = ratingService.getAllRatings();
        int cusQuant = userList.size();
        System.out.println(filterType);
        LocalDate today = LocalDate.now();
        List<Orders> filteredOrders = new ArrayList<>();
        long totalRevenue = 0;
        for (Orders order : ordersList) {
            if (order.getOrderDate().toLocalDate().isEqual(today)) {
                filteredOrders.add(order);
                totalRevenue += order.getPayment().getAmount();
            }
        }
        if (user.getRole().equals("SALER")){
            req.setAttribute("orderList", ordersListforSaler);
        } else req.setAttribute("orderList", ordersList);
        req.setAttribute("ratingList",ratingList);
        req.setAttribute("cusQuant", cusQuant);
        req.setAttribute("sales",filteredOrders.size());
        req.setAttribute("totalRevenue", totalRevenue);
        req.getRequestDispatcher("admin-home.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = null;
        try {
            String filterType = req.getParameter("filterType");
            System.out.println("Filter Type: " + filterType);

            List<Orders> ordersList = orderService.getAllOrders();
            LocalDate today = LocalDate.now();
            List<Orders> filteredOrders = new ArrayList<>();
            double totalRevenue = 0;
            if (filterType != null) {
                switch (filterType) {
                    case "today":
                        for (Orders order : ordersList) {
                            if (order.getOrderDate().toLocalDate().isEqual(today)) {
                                filteredOrders.add(order);
                                totalRevenue += order.getPayment().getAmount();
                            }
                        }
                        break;
                    case "thisMonth":
                        for (Orders order : ordersList) {
                            LocalDate orderDate = order.getOrderDate().toLocalDate();
                            if (orderDate.getYear() == today.getYear() &&
                                    orderDate.getMonth() == today.getMonth()) {
                                filteredOrders.add(order);
                                totalRevenue += order.getPayment().getAmount();
                            }
                        }
                        break;
                    case "thisYear":
                        for (Orders order : ordersList) {
                            if (order.getOrderDate().toLocalDate().getYear() == today.getYear()) {
                                filteredOrders.add(order);
                                totalRevenue += order.getPayment().getAmount();
                            }
                        }
                        break;
                }
            }
            int totalSales = filteredOrders.size();

            Gson gson = new GsonBuilder()
                    .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeSerializer())
                    .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeDeserializer())
                    .create();

            resp.setContentType("application/json");
            req.setCharacterEncoding("UTF-8");

            out = resp.getWriter();
            out.print(gson.toJson(new FilterResponse(totalSales, totalRevenue)));
        } catch (JsonIOException e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("An error occurred: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("An error occurred: " + e.getMessage());
        } finally {
            if (out != null) {
                out.close();
            }
        }
    }
    private class FilterResponse {
        private int totalSales;
        private double totalRevenue;

        public FilterResponse(int totalSales, double totalRevenue) {
            this.totalSales = totalSales;
            this.totalRevenue = totalRevenue;
        }

        public int getTotalSales() {
            return totalSales;
        }

        public double getTotalRevenue() {
            return totalRevenue;
        }
    }

    @Override
    public void destroy() {
        JPAConfig.shutdown();
    }
}
