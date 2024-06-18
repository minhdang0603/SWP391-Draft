package com.web.laptoptg.service.impl;

import com.web.laptoptg.dao.CartDetailsDAO;
import com.web.laptoptg.dao.impl.CartDetailsDAOImpl;
import com.web.laptoptg.model.CartDetails;
import com.web.laptoptg.service.CartDetailsService;

import java.util.List;

public class CartDetailsServiceImpl implements CartDetailsService {

    private CartDetailsDAO cartDetailsDAO;

    public CartDetailsServiceImpl() {
        cartDetailsDAO = new CartDetailsDAOImpl();
    }

    @Override
    public CartDetails saveCartDetails(CartDetails cartDetails) {
        return cartDetailsDAO.saveCartDetails(cartDetails);
    }

    @Override
    public void deleteCartDetails(CartDetails cartDetails) {
        CartDetails temp = getCartDetailsByCartAndProduct(cartDetails.getCart().getId(), cartDetails.getProduct().getId());
        cartDetailsDAO.deleteCartDetails(temp);
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
    public CartDetails updateCartDetails(CartDetails cartDetails) {
        return cartDetailsDAO.updateCartDetails(cartDetails);
    }

    @Override
    public CartDetails getCartDetailsByCartAndProduct(int cartId, int productId) {
        return cartDetailsDAO.getCartDetailsByCartAndProduct(cartId, productId);
    }
}
