<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.example.product_cart.model.*" %>

<html>
<head>
    <title>Shopping Cart</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            background-attachment: fixed;
            min-height: 100vh;
            padding: 40px 20px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            padding: 40px;
        }

        h2 {
            color: #333;
            font-size: 32px;
            margin-bottom: 30px;
            text-align: center;
            position: relative;
            padding-bottom: 15px;
        }

        h2:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2);
            border-radius: 2px;
        }

        .empty-cart {
            text-align: center;
            padding: 60px 20px;
        }

        .empty-cart p {
            font-size: 18px;
            color: #666;
            margin-bottom: 25px;
        }

        .empty-cart .icon {
            font-size: 80px;
            margin-bottom: 20px;
            opacity: 0.3;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 25px 0;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 13px;
            letter-spacing: 0.5px;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #f0f0f0;
            color: #555;
        }

        tr:last-child td {
            border-bottom: none;
        }

        tr:hover {
            background-color: #f8f9ff;
            transition: background-color 0.3s ease;
        }

        .total-section {
            margin: 30px 0;
            padding: 25px;
            background: linear-gradient(135deg, #f8f9ff 0%, #e8eaff 100%);
            border-radius: 10px;
            border-left: 5px solid #667eea;
        }

        .total-section strong {
            font-size: 24px;
            color: #333;
        }

        .actions {
            text-align: center;
            margin-top: 30px;
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }

        a {
            text-decoration: none;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-block;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
        }

        .btn-secondary:hover {
            background: #667eea;
            color: white;
            transform: translateY(-2px);
        }

        .btn-danger {
            background: #ff6b6b;
            color: white;
            box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3);
            font-size: 14px;
            padding: 8px 20px;
        }

        .btn-danger:hover {
            background: #ff5252;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 107, 107, 0.4);
        }

        .price {
            font-weight: 600;
            color: #667eea;
        }

        .quantity {
            font-weight: 600;
            color: #764ba2;
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            table {
                font-size: 14px;
            }

            th, td {
                padding: 10px;
            }

            h2 {
                font-size: 24px;
            }

            .actions {
                flex-direction: column;
            }

            a {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <h2>🛒 Shopping Cart</h2>

    <%
        // Lấy cart từ session
        Object cartObj = session.getAttribute("cart");

        if (cartObj == null) {
    %>
    <div class="empty-cart">
        <div class="icon">🛍️</div>
        <p>Your cart is empty.</p>
        <a href="products" class="btn-primary">Start Shopping</a>
    </div>
    <%
    } else {
        // Giả sử cart có method getItems()
        // items là Map<Integer, CartItem>
        Map<Integer, CartItem> items =
                ((Cart) cartObj).getItems();

        if (items == null || items.isEmpty()) {
    %>
    <div class="empty-cart">
        <div class="icon">🛍️</div>
        <p>Your cart is empty.</p>
        <a href="products" class="btn-primary">Start Shopping</a>
    </div>
    <%
    } else {
        double grandTotal = 0;
    %>

    <table>
        <tr>
            <th>Product Name</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Total</th>
            <th>Action</th>
        </tr>

        <%
            for (CartItem item : items.values()) {
                grandTotal += item.getTotalPrice();
        %>
        <tr>
            <td><strong><%= item.getProduct().getName() %></strong></td>
            <td class="price">$<%= String.format("%.2f", item.getProduct().getPrice()) %></td>
            <td class="quantity"><%= item.getQuantity() %></td>
            <td class="price"><strong>$<%= String.format("%.2f", item.getTotalPrice()) %></strong></td>
            <td>
                <a href="cart?action=remove&id=<%= item.getProduct().getId() %>" class="btn-danger">
                    Remove
                </a>
            </td>
        </tr>
        <%
            }
        %>
    </table>

    <div class="total-section">
        <strong>Total Amount: $<%= String.format("%.2f", grandTotal) %></strong>
    </div>

    <div class="actions">
        <a href="cart?action=clear" class="btn-secondary">Clear Cart</a>
        <a href="products" class="btn-primary">Continue Shopping</a>
    </div>

    <%
            }
        }
    %>
</div>

</body>
</html>