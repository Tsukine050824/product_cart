package com.example.product_cart.controller;

import com.example.product_cart.dao.ProductDAO;
import com.example.product_cart.model.Cart;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;


@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        String action = req.getParameter("action");

        try {
            ProductDAO dao = new ProductDAO();

            if ("add".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                cart.addProduct(dao.findById(id));
            } else if ("remove".equals(action)) {
                cart.remove(Integer.parseInt(req.getParameter("id")));
            } else if ("clear".equals(action)) {
                cart.clear();
            }

            req.getRequestDispatcher("/jsp/cart.jsp").forward(req, resp);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}

