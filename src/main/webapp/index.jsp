<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Product Cart</title>
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
            position: relative;
            overflow-x: hidden;
        }

        /* Animated background circles */
        body::before,
        body::after {
            content: '';
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            animation: float 20s infinite ease-in-out;
            pointer-events: none;
        }

        body::before {
            width: 300px;
            height: 300px;
            top: -100px;
            left: -100px;
            animation-delay: 0s;
        }

        body::after {
            width: 400px;
            height: 400px;
            bottom: -150px;
            right: -150px;
            animation-delay: 5s;
        }

        @keyframes float {
            0%, 100% {
                transform: translate(0, 0) scale(1);
            }
            33% {
                transform: translate(50px, -50px) scale(1.1);
            }
            66% {
                transform: translate(-30px, 30px) scale(0.9);
            }
        }

        .container {
            max-width: 900px;
            width: 100%;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            padding: 60px 40px;
            text-align: center;
            position: relative;
            z-index: 1;
            animation: slideIn 0.6s ease;
            margin: 0 auto;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .logo {
            font-size: 80px;
            margin-bottom: 20px;
            animation: bounce 2s infinite;
        }

        @keyframes bounce {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-10px);
            }
        }

        h1 {
            color: #333;
            font-size: 42px;
            margin-bottom: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .subtitle {
            color: #666;
            font-size: 18px;
            margin-bottom: 50px;
            line-height: 1.6;
        }

        .button-group {
            display: flex;
            flex-direction: column;
            gap: 20px;
            max-width: 500px;
            margin: 0 auto;
        }

        .btn {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            padding: 18px 35px;
            font-size: 17px;
            text-decoration: none;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.2);
            transition: left 0.5s ease;
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }

        .btn-success {
            background: linear-gradient(135deg, #51cf66 0%, #37b24d 100%);
            color: white;
        }

        .btn-success:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(81, 207, 102, 0.4);
        }

        .btn-danger {
            background: linear-gradient(135deg, #ff6b6b 0%, #fa5252 100%);
            color: white;
        }

        .btn-danger:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(255, 107, 107, 0.4);
        }

        .btn-icon {
            font-size: 24px;
        }

        .features {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
            margin-top: 50px;
            padding-top: 40px;
            border-top: 2px solid #f0f0f0;
        }

        .feature {
            padding: 20px;
            border-radius: 12px;
            background: linear-gradient(135deg, #f8f9ff 0%, #e8eaff 100%);
            transition: all 0.3s ease;
        }

        .feature:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.2);
        }

        .feature-icon {
            font-size: 40px;
            margin-bottom: 10px;
        }

        .feature-title {
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
            font-size: 16px;
        }

        .feature-text {
            color: #666;
            font-size: 13px;
            line-height: 1.5;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .container {
                padding: 40px 25px;
            }

            h1 {
                font-size: 32px;
            }

            .logo {
                font-size: 60px;
            }

            .subtitle {
                font-size: 16px;
            }

            .btn {
                font-size: 15px;
                padding: 15px 25px;
            }

            .features {
                grid-template-columns: 1fr;
                gap: 15px;
            }

            .feature {
                padding: 15px;
            }
        }

        /* Active state */
        .btn:active {
            transform: translateY(-1px);
        }

        /* Loading animation for buttons */
        @keyframes pulse {
            0%, 100% {
                opacity: 1;
            }
            50% {
                opacity: 0.8;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="logo">🛍️</div>

    <h1>Welcome to Product Cart</h1>

    <p class="subtitle">
        Quản lý sản phẩm và giỏ hàng của bạn một cách dễ dàng<br>
        Khám phá các tính năng mạnh mẽ ngay bây giờ!
    </p>

    <div class="button-group">
        <a class="btn btn-primary" href="<%= request.getContextPath() %>/products">
            <span class="btn-icon">📦</span>
            <span>Xem danh sách sản phẩm</span>
        </a>

        <a class="btn btn-success" href="<%= request.getContextPath() %>/cart?action=view">
            <span class="btn-icon">🛒</span>
            <span>Vào giỏ hàng</span>
        </a>

        <a class="btn btn-danger" href="<%= request.getContextPath() %>/cart?action=clear"
           onclick="return confirm('Bạn có chắc muốn xóa toàn bộ giỏ hàng?')">
            <span class="btn-icon">🗑️</span>
            <span>Xóa giỏ hàng</span>
        </a>
    </div>

    <div class="features">
        <div class="feature">
            <div class="feature-icon">✨</div>
            <div class="feature-title">Quản lý dễ dàng</div>
            <div class="feature-text">Thêm, sửa, xóa sản phẩm chỉ với vài click</div>
        </div>

        <div class="feature">
            <div class="feature-icon">🚀</div>
            <div class="feature-title">Nhanh chóng</div>
            <div class="feature-text">Giao diện mượt mà, tải nhanh</div>
        </div>

        <div class="feature">
            <div class="feature-icon">🎨</div>
            <div class="feature-title">Giao diện đẹp</div>
            <div class="feature-text">Thiết kế hiện đại, dễ sử dụng</div>
        </div>
    </div>
</div>

</body>
</html>