<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Deletar Vaga</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 50px;
        }

        form {
            width: 300px;
            margin: auto;
        }

        label {
            display: block;
            margin-bottom: 8px;
        }

        input {
            width: 100%;
            padding: 8px;
            margin-bottom: 16px;
        }

        input[type="submit"] {
            background-color: #FF6347; /* cor vermelha, ajuste conforme necessário */
            color: white;
            border: none;
            padding: 10px 15px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h1>Deletar Vaga</h1>

    <form action="processarExclusao.jsp" method="post">
        <label for="id">ID da Vaga:</label>
        <input type="text" id="id" name="id" required>
        <br>
        <input type="submit" value="Deletar Vaga">
    </form>
</body>
</html>
