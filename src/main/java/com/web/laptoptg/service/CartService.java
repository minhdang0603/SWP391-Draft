package com.web.laptoptg.service;

import com.web.laptoptg.model.Cart;
import com.web.laptoptg.model.User;

public interface CartService {
    Cart getCartByUserId(int userId);
    Cart saveCart(Cart cart);
    public void deleteCartByUserId(int userId);
}
