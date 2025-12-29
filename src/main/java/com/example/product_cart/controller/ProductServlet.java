package com.example.product_cart.controller;

import com.example.product_cart.dao.ProductDAO;
import java.math.BigDecimal;

import com.example.product_cart.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;



@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    private ProductDAO dao = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        try {
            if (action == null || action.equals("list")) {
                req.setAttribute("products", dao.findAll());
                req.getRequestDispatcher("/jsp/product-list.jsp").forward(req, resp);

            } else if (action.equals("new")) {
                req.getRequestDispatcher("/jsp/product-form.jsp").forward(req, resp);

            } else if (action.equals("edit")) {
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("product", dao.findById(id));
                req.getRequestDispatcher("/jsp/product-form.jsp").forward(req, resp);

            } else if (action.equals("delete")) {
                dao.delete(Integer.parseInt(req.getParameter("id")));
                resp.sendRedirect("products");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    // 🔴 PHẦN BỊ THIẾU GÂY LỖI 405
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            String id = req.getParameter("id");
            String name = req.getParameter("name");
            BigDecimal price = new BigDecimal(req.getParameter("price"));
            String description = req.getParameter("description");

            Product p = new Product();
            p.setName(name);
            p.setPrice(price);
            p.setDescription(description);

            if (id == null || id.isEmpty()) {
                // ADD NEW
                dao.insert(p);
            } else {
                // UPDATE
                p.setId(Integer.parseInt(id));
                dao.update(p);
            }

            resp.sendRedirect("products");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
