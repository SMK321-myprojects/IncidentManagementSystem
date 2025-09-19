<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Incidents Management System</title>
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            background: linear-gradient(135deg, #a445b2, #fa4299);
            color: white;
            text-align: center;
        }

        .container {
            width: 80%;
            max-width: 700px;
            background: rgba(255, 255, 255, 0.2);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.3);
            animation: fadeIn 0.8s ease-in-out;
        }

        h1 {
            font-size: 2.8rem;
            margin-bottom: 15px;
        }

        p {
            font-size: 1.3rem;
            margin-bottom: 30px;
        }

        .buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 12px 20px;
            background: white;
            color: #a445b2;
            font-size: 1rem;
            font-weight: bold;
            text-transform: uppercase;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn:hover {
            background: #fa4299;
            color: white;
            transform: scale(1.05);
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        a {
    text-decoration: none; /* Removes underline */
    color: white; /* Ensures text color is visible */
}

a:hover {
    text-decoration: none; /* Ensures it doesn't appear on hover */
}
        
    </style>
</head>
<body>

    <div class="container">
        <h1>Incidents Management System</h1>
        <p th:if="${user.role=='USER'}">Welcome, <strong>[[${user.name}]]</strong></p>
        <p th:if="${user.role=='ADMIN'}">Welcome, <strong>Admin</strong></p>
        <div class="buttons">
    <a href="/defaultIncidents" class="btn"><i class="fas fa-list"></i> Search Default Incidents</a>
    <a href="/issues" class="btn"><i class="fas fa-plus-circle"></i>Issues</a>
    <a href="/logout" class="btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
</div>

    </div>

</body>
</html>
