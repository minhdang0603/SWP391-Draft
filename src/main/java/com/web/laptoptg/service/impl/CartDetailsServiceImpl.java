package com.web.laptoptg.service.impl;

import com.web.laptoptg.dao.CartDetailsDAO;
import com.web.laptoptg.dao.impl.CartDetailsDAOImpl;
import com.web.laptoptg.model.CartDetails;
import com.web.laptoptg.service.CartDetailsService;

import java.util.List;

public class CartDetailsServiceImpl implements CartDetailsService {

    private CartDetailsDAO cartDetailsDAO = new CartDetailsDAOImpl();

    @Override
    public void saveCartDetails(CartDetails cartDetails) {
        cartDetailsDAO.saveCartDetails(cartDetails);
    }

    @Override
    public void deleteCartDetails(CartDetails cartDetails) {
        cartDetailsDAO.deleteCartDetails(cartDetails);
    }

    @Override
    public void deleteAll(int cartId) {
        cartDetailsDAO.deleteAll(cartId);
    }

    @Override
    public List<CartDetails> getCartDetailsByCart(int cartId) {
        return cartDetailsDAO.getCartDetailsByCart(cartId);
    }

    @Override
    public void updateCartDetails(CartDetails cartDetails) {
        cartDetailsDAO.updateCartDetails(cartDetails);
    }

    @Override
    public CartDetails getCartDetailsByCartAndProduct(int cartId, int productId) {
        return cartDetailsDAO.getCartDetailsByCartAndProduct(cartId, productId);
    }
}
