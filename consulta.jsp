<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Consulta de Vagas</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        h1 {
            text-align: center;
        }

        form {
            text-align: center;
            margin-bottom: 20px;
        }

        table {
            border-collapse: collapse;
            width: 80%;
            margin: 20px auto;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        #atualizarBtn {
            display: block;
            margin: 20px auto;
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            text-align: center;
            text-decoration: none;
            font-size: 16px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h1>Consulta de Vagas</h1>

    <form action="consulta.jsp" method="get">
        <label for="nomeVaga">Nome da Vaga:</label>
        <input type="text" id="nomeVaga" name="nomeVaga">
        <input type="submit" value="Buscar">
    </form>

    <%
        String nomeVaga = request.getParameter("nomeVaga");

        // Verifica se a pesquisa foi realizada
        if (nomeVaga != null && !nomeVaga.isEmpty()) {
            try {
                // Configurar a conexão com o banco de dados
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/voluntario";
                String usuario = "root";
                String senha = "";

                Connection conexao = DriverManager.getConnection(url, usuario, senha);
                Statement stmt = conexao.createStatement();

                // Consultar os dados do banco de dados com base no nome da vaga
                String sql = "SELECT * FROM vagas WHERE vaga LIKE '%" + nomeVaga + "%'";
                ResultSet rs = stmt.executeQuery(sql);

                // Exibir os resultados em uma tabela
    %>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Vaga</th>
                        <th>Descrição</th>
                        <th>Requisitos</th>
                        <th>Atribuições</th>
                        <th>Tipo</th>
                        <th>Escala</th>
                        <th>Experiência</th>
                        <th>Cursos</th>
                        <th>Diferencial</th>
                        <th>Salário</th>                      
                    </tr>
    <%
                    while (rs.next()) {
    %>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getString("vaga") %></td>
                            <td><%= rs.getString("descricao") %></td>
                            <td><%= rs.getString("requisitos") %></td>
                            <td><%= rs.getString("atribuicoes") %></td>
                            <td><%= rs.getString("tipo") %></td>
                            <td><%= rs.getInt("escala") %></td>
                            <td><%= rs.getString("experiencia") %></td>
                            <td><%= rs.getString("cursos") %></td>
                            <td><%= rs.getString("diferencial") %></td>
                            <td><%= rs.getString("salario") %></td>                   
                        </tr>
    <%
                    }
                // Fechar a conexão
                rs.close();
                stmt.close();
                conexao.close();
            } catch (Exception ex) {
                ex.printStackTrace();
                out.println("Erro: " + ex.toString());
            }
    %>
                </table>
                <!-- Botão para redirecionar para a página de atualização -->
                <a href="atualizar.jsp" id="atualizarBtn">Atualizar Vagas</a>
    <%
        }
    %>
</body>
</html>
