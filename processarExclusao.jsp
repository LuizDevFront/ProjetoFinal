<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Processar Exclusão</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 50px;
        }

        p {
            font-size: 18px;
            color: green;
        }

        a {
            text-decoration: none;
            color: #4CAF50;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <h1>Processar Exclusão</h1>

    <%
        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);

            try {
                // Configurar a conexão com o banco de dados
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/voluntario";
                String usuario = "root";
                String senha = "";

                Connection conexao = DriverManager.getConnection(url, usuario, senha);

                // Excluir o registro do banco de dados
                String exclusaoSql = "DELETE FROM vagas WHERE id=?";
                try (PreparedStatement pstmtExclusao = conexao.prepareStatement(exclusaoSql)) {
                    pstmtExclusao.setInt(1, id);

                    int linhasAfetadas = pstmtExclusao.executeUpdate();

                    if (linhasAfetadas > 0) {
    %>
                        <p>Vaga excluída com sucesso!</p>
                        <p><a href="consulta.jsp">Voltar para a consulta</a></p>
    <%
                    } else {
    %>
                        <p>Falha ao excluir a vaga.</p>
    <%
                    }
                }

                // Fechar a conexão
                conexao.close();
            } catch (Exception ex) {
                ex.printStackTrace();
                out.println("Erro: " + ex.toString());
            }
        } else {
    %>
        <p>ID da vaga não fornecido.</p>
    <%
        }
    %>
</body>
</html>
