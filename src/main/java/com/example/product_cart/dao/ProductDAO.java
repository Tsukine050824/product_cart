package com.example.product_cart.dao;

import com.example.product_cart.model.Product;
import com.example.product_cart.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

/**
 * DAO quản lý Product
 * Sử dụng ConcurrentHashMap để cache theo productId
 */
public class ProductDAO {

    // Cache sản phẩm theo id (O(1))
    private static final ConcurrentHashMap<Integer, Product> cache =
            new ConcurrentHashMap<>();

    // Lấy tất cả sản phẩm
    public List<Product> findAll() throws Exception {
        List<Product> list = new ArrayList<>();

        String sql = "SELECT * FROM products";

        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                Product p = mapRow(rs);
                list.add(p);
                cache.put(p.getId(), p);
            }
        }
        return list;
    }

    // Tìm sản phẩm theo id (ưu tiên cache)
    public Product findById(int id) throws Exception {

        // 1. Đọc từ cache
        if (cache.containsKey(id)) {
            return cache.get(id);
        }

        // 2. Không có trong cache → đọc DB
        String sql = "SELECT * FROM products WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Product p = mapRow(rs);
                cache.put(id, p);
                return p;
            }
        }
        return null;
    }

    // Thêm sản phẩm
    public void insert(Product p) throws Exception {

        String sql = "INSERT INTO products(name, price, description) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getName());
            ps.setBigDecimal(2, p.getPrice());
            ps.setString(3, p.getDescription());
            ps.executeUpdate();
        }

        // DB thay đổi → clear cache
        cache.clear();
    }

    // Cập nhật sản phẩm
    public void update(Product p) throws Exception {

        String sql = "UPDATE products SET name=?, price=?, description=? WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getName());
            ps.setBigDecimal(2, p.getPrice());
            ps.setString(3, p.getDescription());
            ps.setInt(4, p.getId());
            ps.executeUpdate();
        }

        cache.put(p.getId(), p);
    }

    // Xóa sản phẩm
    public void delete(int id) throws Exception {

        String sql = "DELETE FROM products WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        }

        cache.remove(id);
    }

    // Map ResultSet → Product
    private Product mapRow(ResultSet rs) throws Exception {
        return new Product(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getBigDecimal("price"),
                rs.getString("description")
        );
    }
}
