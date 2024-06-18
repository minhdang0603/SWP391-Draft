package com.web.laptoptg.dao;

import com.web.laptoptg.model.Cart;
import com.web.laptoptg.model.User;

public interface CartDAO {
    Cart getCartByUserId(int userId);
    Cart saveCart(Cart cart);
    Cart updateCart(Cart cart);

    void deleteCartByUserId(int userId); // Thêm phương thức này

}
