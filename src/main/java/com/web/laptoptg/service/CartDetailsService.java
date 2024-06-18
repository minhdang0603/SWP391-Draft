package com.web.laptoptg.service;

import com.web.laptoptg.model.CartDetails;

import java.util.List;

public interface CartDetailsService {
    CartDetails saveCartDetails(CartDetails cartDetails);
    void deleteCartDetails(CartDetails cartDetails);
    void deleteAll(int cartId);
    List<CartDetails> getCartDetailsByCart(int cartId);
    CartDetails updateCartDetails(CartDetails cartDetails);
    CartDetails getCartDetailsByCartAndProduct(int cartId, int productId);
}
