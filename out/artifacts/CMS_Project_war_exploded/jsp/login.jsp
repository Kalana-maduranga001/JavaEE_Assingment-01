<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(-45deg, #667eea, #764ba2, #f093fb, #f5576c);
            background-size: 400% 400%;
            animation: gradientShift 15s ease infinite;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            overflow: hidden;
            position: relative;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Animated background particles */
        .bg-animation {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: 1;
        }

        .particle {
            position: absolute;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
        }

        .particle:nth-child(1) { width: 80px; height: 80px; left: 10%; animation-delay: 0s; }
        .particle:nth-child(2) { width: 120px; height: 120px; left: 20%; animation-delay: 2s; }
        .particle:nth-child(3) { width: 60px; height: 60px; left: 25%; animation-delay: 4s; }
        .particle:nth-child(4) { width: 100px; height: 100px; left: 40%; animation-delay: 0s; }
        .particle:nth-child(5) { width: 70px; height: 70px; left: 70%; animation-delay: 3s; }
        .particle:nth-child(6) { width: 110px; height: 110px; left: 80%; animation-delay: 5s; }
        .particle:nth-child(7) { width: 90px; height: 90px; left: 32%; animation-delay: 1s; }
        .particle:nth-child(8) { width: 50px; height: 50px; left: 55%; animation-delay: 4s; }

        @keyframes float {
            0%, 100% { transform: translateY(100vh) rotate(0deg); opacity: 0; }
            10% { opacity: 1; }
            90% { opacity: 1; }
        }

        .login-container {
            width: 100%;
            max-width: 420px;
            padding: 40px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            box-shadow:
                    0 25px 50px rgba(0,0,0,0.2),
                    0 0 0 1px rgba(255,255,255,0.2);
            position: relative;
            z-index: 10;
            transform: translateY(0);
            animation: slideIn 0.8s ease-out;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(50px) scale(0.9);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .login-container::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: linear-gradient(45deg, #667eea, #764ba2, #f093fb, #f5576c);
            border-radius: 22px;
            z-index: -1;
            animation: borderGlow 3s linear infinite;
        }

        @keyframes borderGlow {
            0%, 100% { opacity: 0.5; }
            50% { opacity: 1; }
        }

        .login-header {
            text-align: center;
            margin-bottom: 35px;
        }

        .login-header h3 {
            font-size: 2.2rem;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 10px;
            animation: titlePulse 2s ease-in-out infinite alternate;
        }

        @keyframes titlePulse {
            from { transform: scale(1); }
            to { transform: scale(1.05); }
        }

        .login-subtitle {
            color: #666;
            font-size: 0.95rem;
            margin-bottom: 20px;
        }

        .input-group {
            position: relative;
            margin-bottom: 30px;
        }

        .input-icon {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: #667eea;
            z-index: 2;
            font-size: 20px;
            transition: all 0.3s ease;
        }

        .form-control {
            padding: 20px 20px 20px 60px;
            border: 2px solid #e1e5e9;
            border-radius: 15px;
            font-size: 18px;
            height: 65px;
            background: rgba(255, 255, 255, 0.9);
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }

        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            transform: translateY(-2px);
            background: rgba(255, 255, 255, 1);
        }

        .form-control:focus + .input-icon {
            color: #764ba2;
            transform: translateY(-50%) scale(1.1);
        }

        .form-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-login {
            width: 100%;
            padding: 20px;
            font-size: 18px;
            font-weight: 600;
            height: 65px;
            border: none;
            border-radius: 15px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
            position: relative;
            overflow: hidden;
        }

        .btn-login::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .btn-login:hover::before {
            left: 100%;
        }

        .btn-login:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
            background: linear-gradient(135deg, #764ba2, #667eea);
        }

        .btn-login:active {
            transform: translateY(-1px);
        }

        .error-msg {
            color: #e74c3c;
            margin-top: 20px;
            text-align: center;
            padding: 12px;
            background: rgba(231, 76, 60, 0.1);
            border-radius: 8px;
            border-left: 4px solid #e74c3c;
            animation: shake 0.5s ease-in-out;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        .floating-icon {
            position: absolute;
            font-size: 20px;
            color: rgba(255, 255, 255, 0.6);
            animation: floatIcon 4s ease-in-out infinite;
        }

        .floating-icon:nth-child(1) { top: 20%; left: 15%; animation-delay: 0s; }
        .floating-icon:nth-child(2) { top: 60%; right: 20%; animation-delay: 2s; }
        .floating-icon:nth-child(3) { bottom: 30%; left: 25%; animation-delay: 1s; }
        .floating-icon:nth-child(4) { top: 40%; right: 15%; animation-delay: 3s; }

        @keyframes floatIcon {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

        /* Glowing orbs */
        .orb {
            position: absolute;
            border-radius: 50%;
            filter: blur(1px);
            animation: orbMove 8s ease-in-out infinite;
        }

        .orb1 {
            width: 200px;
            height: 200px;
            background: radial-gradient(circle, rgba(102, 126, 234, 0.3), transparent);
            top: 10%;
            left: 10%;
            animation-delay: 0s;
        }

        .orb2 {
            width: 150px;
            height: 150px;
            background: radial-gradient(circle, rgba(245, 87, 108, 0.3), transparent);
            bottom: 20%;
            right: 15%;
            animation-delay: 4s;
        }

        @keyframes orbMove {
            0%, 100% { transform: translate(0, 0) scale(1); }
            25% { transform: translate(30px, -30px) scale(1.1); }
            50% { transform: translate(-20px, 20px) scale(0.9); }
            75% { transform: translate(20px, -10px) scale(1.05); }
        }
    </style>
</head>
<body>
<!-- Animated background -->
<div class="bg-animation">
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
</div>

<!-- Floating icons -->
<div class="floating-icon"><i class="fas fa-lock"></i></div>
<div class="floating-icon"><i class="fas fa-shield-alt"></i></div>
<div class="floating-icon"><i class="fas fa-key"></i></div>
<div class="floating-icon"><i class="fas fa-user-shield"></i></div>

<!-- Glowing orbs -->
<div class="orb orb1"></div>
<div class="orb orb2"></div>

<div class="login-container">
    <div class="login-header">
        <h3><i class="fas fa-user-circle"></i> Login</h3>
        <p class="login-subtitle">Welcome back! Please sign in to your account</p>
    </div>

    <form method="post" action="${pageContext.request.contextPath}/login">
        <div class="input-group">
            <label for="username" class="form-label">Username</label>
            <div class="position-relative">
                <input type="text" class="form-control" id="username" name="username" required
                       placeholder="Enter your username">
                <i class="fas fa-user input-icon"></i>
            </div>
        </div>

        <div class="input-group">
            <label for="password" class="form-label">Password</label>
            <div class="position-relative">
                <input type="password" class="form-control" id="password" name="password" required
                       placeholder="Enter your password">
                <i class="fas fa-lock input-icon"></i>
            </div>
        </div>

        <div class="d-grid">
            <button type="submit" class="btn-login">
                <i class="fas fa-sign-in-alt me-2"></i>Sign In
            </button>
        </div>
    </form>

    <c:if test="${not empty error}">
        <div class="error-msg">
            <i class="fas fa-exclamation-triangle me-2"></i>${error}
        </div>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>