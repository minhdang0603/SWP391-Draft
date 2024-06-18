package com.web.laptoptg.service.impl;

import com.web.laptoptg.dao.CartDAO;
import com.web.laptoptg.dao.impl.CartDAOImpl;
import com.web.laptoptg.model.Cart;
import com.web.laptoptg.service.CartService;

public class CartServiceImpl implements CartService {

    private CartDAO cartDAO;

    public CartServiceImpl() {
        cartDAO = new CartDAOImpl();
    }

    @Override
    public Cart getCartByUserId(int userId) {
        return cartDAO.getCartByUserId(userId);
    }

    @Override
    public Cart saveCart(Cart cart) {
        return cartDAO.saveCart(cart);
    }

    @Override
    public void deleteCartByUserId(int userId) {
        // Xóa các bản ghi trong Cart dựa trên userId
        cartDAO.deleteCartByUserId(userId);
    }
}
