<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.example.product_cart.model.Product" %>

<html>
<head>
    <title>Product Form</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 40px 20px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .form-container {
            max-width: 600px;
            width: 100%;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            padding: 40px;
            animation: slideUp 0.4s ease;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        h2 {
            color: #333;
            font-size: 28px;
            margin-bottom: 10px;
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
            width: 60px;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2);
            border-radius: 2px;
        }

        h2::before {
            content: '📝';
            margin-right: 10px;
        }

        .form-subtitle {
            text-align: center;
            color: #888;
            font-size: 14px;
            margin-bottom: 30px;
        }

        form {
            margin-top: 30px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        label {
            display: block;
            color: #555;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        input[type="text"],
        input[type="number"],
        textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 15px;
            font-family: inherit;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        input[type="text"]:focus,
        input[type="number"]:focus,
        textarea:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 35px;
            justify-content: center;
        }

        button,
        .btn {
            padding: 12px 35px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 15px;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }

        button[type="submit"] {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        button[type="submit"]:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }

        button[type="submit"]:active {
            transform: translateY(0);
        }

        a.btn {
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
        }

        a.btn:hover {
            background: #667eea;
            color: white;
            transform: translateY(-2px);
        }

        .required {
            color: #ff6b6b;
            margin-left: 3px;
        }

        .form-icon {
            position: relative;
        }

        input[type="text"],
        input[type="number"] {
            padding-left: 15px;
        }

        /* Input validation styles */
        input:invalid:not(:placeholder-shown),
        textarea:invalid:not(:placeholder-shown) {
            border-color: #ff6b6b;
        }

        input:valid:not(:placeholder-shown),
        textarea:valid:not(:placeholder-shown) {
            border-color: #51cf66;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .form-container {
                padding: 30px 20px;
            }

            h2 {
                font-size: 24px;
            }

            .button-group {
                flex-direction: column;
            }

            button,
            .btn {
                width: 100%;
            }
        }

        /* Loading animation for submit button */
        button[type="submit"]:disabled {
            opacity: 0.6;
            cursor: not-allowed;
        }

        /* Placeholder styling */
        ::placeholder {
            color: #aaa;
            font-style: italic;
        }

        /* Number input remove arrows */
        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        input[type="number"] {
            -moz-appearance: textfield;
        }
    </style>
</head>
<body>

<div class="form-container">
    <%
        // Lấy product từ request (dùng cho Edit)
        Product product = (Product) request.getAttribute("product");
    %>

    <h2>
        <%
            if (product != null) {
        %>
        Edit Product
        <%
        } else {
        %>
        Add New Product
        <%
            }
        %>
    </h2>

    <p class="form-subtitle">
        <%
            if (product != null) {
        %>
        Update the product information below
        <%
        } else {
        %>
        Fill in the details to create a new product
        <%
            }
        %>
    </p>

    <form action="products" method="post">

        <%
            if (product != null) {
        %>
        <input type="hidden" name="id" value="<%= product.getId() %>" />
        <%
            }
        %>

        <div class="form-group">
            <label for="name">Product Name<span class="required">*</span></label>
            <input type="text"
                   id="name"
                   name="name"
                   placeholder="Enter product name"
                   value="<%= (product != null ? product.getName() : "") %>"
                   required />
        </div>

        <div class="form-group">
            <label for="price">Price ($)<span class="required">*</span></label>
            <input type="number"
                   id="price"
                   step="0.01"
                   name="price"
                   placeholder="0.00"
                   value="<%= (product != null ? product.getPrice() : "") %>"
                   required />
        </div>

        <div class="form-group">
            <label for="description">Description</label>
            <textarea id="description"
                      name="description"
                      placeholder="Enter product description (optional)"><%=
            (product != null ? product.getDescription() : "")
            %></textarea>
        </div>

        <div class="button-group">
            <button type="submit">
                <%
                    if (product != null) {
                %>
                💾 Update Product
                <%
                } else {
                %>
                ✨ Create Product
                <%
                    }
                %>
            </button>
            <a href="products" class="btn">❌ Cancel</a>
        </div>

    </form>
</div>

</body>
</html>