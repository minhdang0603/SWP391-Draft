package com.web.laptoptg.dto;

import com.web.laptoptg.model.Product;

import java.util.ArrayList;
import java.util.List;

public class CartDTO {
    private List<ItemDTO> items;

    public CartDTO() {
        items = new ArrayList<>();
    }

    private ItemDTO getItemByID(int id) {
        for (ItemDTO item : items) {
            if (item.getProduct().getId() == id) {
                return item;
            }
        }
        return null;
    }

    public List<ItemDTO> getItems() {
        return items;
    }

    public void addItem(ItemDTO item) {
        if(getItemByID(item.getProduct().getId()) != null) {
            ItemDTO temp = getItemByID(item.getProduct().getId());
            temp.setQuantity(temp.getQuantity() + item.getQuantity());
        } else {
            items.add(item);
        }
    }

    public long getTotal(){
        long total = 0;
        for (ItemDTO item : items) {
            total += item.getQuantity()*item.getProduct().getUnitPrice();
        }
        return total;
    }

    public Product getProductByID(int id, List<Product> products) {
        for (Product product : products) {
            if (product.getId() == id) {
                return product;
            }
        }
        return null;
    }

    public CartDTO(String cartContent, List<Product> products) {
        items = new ArrayList<>();
        try {
            if(cartContent != null && !cartContent.isEmpty()) {
                String[] cartItems = cartContent.split("/");
                for (String item : cartItems) {
                    String[] cartItem = item.split(":");
                    int id = Integer.parseInt(cartItem[0]);
                    int quantity = Integer.parseInt(cartItem[1]);
                    Product product = getProductByID(id, products);
                    ItemDTO itemDTO = new ItemDTO(product, quantity);
                    addItem(itemDTO);
                }
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }
}
