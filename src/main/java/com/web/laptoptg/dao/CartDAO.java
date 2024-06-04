package com.web.laptoptg.dao;

import com.web.laptoptg.model.Cart;
import com.web.laptoptg.model.User;

public interface CartDAO {
    Cart getCartByUserId(int userId);
    void saveCart(Cart cart);
    void updateCart(Cart cart);
}
