package com.example.product_cart.model;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Cart sử dụng Map để:
 * - Truy cập sản phẩm theo productId với O(1)
 * - Không bị trùng sản phẩm
 */
public class Cart {

    private Map<Integer, CartItem> items = new LinkedHashMap<>();

    // Thêm sản phẩm vào giỏ
    public void addProduct(Product product) {
        int productId = product.getId();

        if (items.containsKey(productId)) {
            CartItem item = items.get(productId);
            item.setQuantity(item.getQuantity() + 1);
        } else {
            items.put(productId, new CartItem(product, 1));
        }
    }

    public void remove(int productId) {
        items.remove(productId);
    }

    public void clear() {
        items.clear();
    }

    public Map<Integer, CartItem> getItems() {
        return items;
    }
}
