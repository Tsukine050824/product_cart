<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.product_cart.model.Product" %>

<html>
<head>
    <title>Product List</title>
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
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            padding: 40px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            flex-wrap: wrap;
            gap: 20px;
        }

        h2 {
            color: #333;
            font-size: 32px;
            position: relative;
            padding-bottom: 10px;
        }

        h2:before {
            content: '📦';
            margin-right: 10px;
        }

        h2:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 80px;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2);
            border-radius: 2px;
        }

        .header-actions {
            display: flex;
            gap: 15px;
        }

        .btn {
            text-decoration: none;
            padding: 12px 25px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-block;
            font-size: 14px;
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

        .btn-cart {
            background: #51cf66;
            color: white;
            box-shadow: 0 4px 15px rgba(81, 207, 102, 0.3);
        }

        .btn-cart:hover {
            background: #40c057;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(81, 207, 102, 0.4);
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
            vertical-align: middle;
        }

        tr:last-child td {
            border-bottom: none;
        }

        tbody tr:hover {
            background-color: #f8f9ff;
            transition: background-color 0.3s ease;
        }

        .product-id {
            font-weight: 600;
            color: #667eea;
            font-size: 16px;
        }

        .product-name {
            font-weight: 600;
            color: #333;
            font-size: 15px;
        }

        .product-price {
            font-weight: 600;
            color: #51cf66;
            font-size: 16px;
        }

        .product-description {
            color: #666;
            max-width: 300px;
            line-height: 1.5;
        }

        .action-links {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .action-links a {
            text-decoration: none;
            padding: 6px 12px;
            border-radius: 5px;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.3s ease;
            white-space: nowrap;
        }

        .btn-edit {
            background: #4dabf7;
            color: white;
        }

        .btn-edit:hover {
            background: #339af0;
            transform: translateY(-1px);
        }

        .btn-delete {
            background: #ff6b6b;
            color: white;
        }

        .btn-delete:hover {
            background: #ff5252;
            transform: translateY(-1px);
        }

        .btn-add-cart {
            background: #51cf66;
            color: white;
        }

        .btn-add-cart:hover {
            background: #40c057;
            transform: translateY(-1px);
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
        }

        .empty-state .icon {
            font-size: 80px;
            margin-bottom: 20px;
            opacity: 0.3;
        }

        .empty-state p {
            font-size: 18px;
            color: #666;
            margin-bottom: 25px;
        }

        .footer-actions {
            margin-top: 30px;
            text-align: center;
            padding-top: 20px;
            border-top: 2px solid #f0f0f0;
        }

        /* Badge for ID */
        .id-badge {
            background: linear-gradient(135deg, #e8eaff 0%, #f0f1ff 100%);
            padding: 4px 10px;
            border-radius: 5px;
            font-weight: 700;
            color: #667eea;
            display: inline-block;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            .header {
                flex-direction: column;
                align-items: flex-start;
            }

            h2 {
                font-size: 24px;
            }

            table {
                font-size: 13px;
            }

            th, td {
                padding: 10px 8px;
            }

            .product-description {
                max-width: 150px;
                font-size: 12px;
            }

            .action-links {
                flex-direction: column;
                gap: 5px;
            }

            .action-links a {
                text-align: center;
                width: 100%;
            }

            .header-actions {
                width: 100%;
                flex-direction: column;
            }

            .btn {
                width: 100%;
                text-align: center;
            }
        }

        /* Animation */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        tbody tr {
            animation: fadeIn 0.5s ease;
        }

        /* Tooltip for long descriptions */
        .product-description {
            position: relative;
            cursor: help;
        }

        .product-description:hover {
            color: #333;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <h2>Product List</h2>
        <div class="header-actions">
            <a href="products?action=new" class="btn btn-primary">➕ Add New Product</a>
            <a href="cart?action=view" class="btn btn-cart">🛒 View Cart</a>
        </div>
    </div>

    <%
        List<Product> products = (List<Product>) request.getAttribute("products");

        if (products != null && !products.isEmpty()) {
    %>
    <table>
        <thead>
        <tr>

            <th>Name</th>
            <th>Price</th>
            <th>Description</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (Product p : products) {
        %>
        <tr>

            <td class="product-name"><%= p.getName() %></td>
            <td class="product-price">$<%= String.format("%.2f", p.getPrice()) %></td>
            <td class="product-description">
                <%= p.getDescription() != null && !p.getDescription().isEmpty()
                        ? p.getDescription()
                        : "<em style='color: #aaa;'>No description</em>" %>
            </td>
            <td>
                <div class="action-links">
                    <a href="products?action=edit&id=<%= p.getId() %>" class="btn-edit">✏️ Edit</a>
                    <a href="products?action=delete&id=<%= p.getId() %>"
                       class="btn-delete"
                       onclick="return confirm('Are you sure you want to delete this product?')">🗑️ Delete</a>
                    <a href="cart?action=add&id=<%= p.getId() %>" class="btn-add-cart">🛒 Add to Cart</a>
                </div>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <%
    } else {
    %>
    <div class="empty-state">
        <div class="icon">📦</div>
        <p>No products found. Start by adding your first product!</p>
        <a href="products?action=new" class="btn btn-primary">➕ Add New Product</a>
    </div>
    <%
        }
    %>

    <div class="footer-actions">
        <a href="cart?action=view" class="btn btn-cart">🛒 View Shopping Cart</a>
    </div>
</div>

</body>
</html>