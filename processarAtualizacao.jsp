<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
    String idParam = request.getParameter("id");

    // Verifica se o parâmetro 'id' está presente
    if (idParam == null || idParam.isEmpty()) {
        out.println("<p>ID não fornecido. Por favor, forneça um ID válido.</p>");
    } else {
        try {
            int id = Integer.parseInt(idParam);
            String vaga = request.getParameter("vaga");
            String descricao = request.getParameter("descricao");
            String requisitos = request.getParameter("requisitos");
            String atribuicoes = request.getParameter("atribuicoes");
            String tipo = request.getParameter("tipo");

            // Verificando e convertendo o valor de escala
            int escala = 0; // ou outro valor padrão
            String escalaParam = request.getParameter("escala");
            if (escalaParam != null && !escalaParam.isEmpty()) {
                escala = Integer.parseInt(escalaParam);
            }

            String experiencia = request.getParameter("experiencia");
            String cursos = request.getParameter("cursos");
            String diferencial = request.getParameter("diferencial");
            String salario = request.getParameter("salario");

            Connection conexao = null;
            PreparedStatement stmt = null;

            try {
                // Configurar a conexão com o banco de dados
                Class.forName("com.mysql.cj.jdbc.Driver");
                conexao = DriverManager.getConnection("jdbc:mysql://localhost:3306/voluntario", "root", "");

                // Atualizar os dados no banco de dados
                String sql = "UPDATE vagas SET vaga=?, descricao=?, requisitos=?, atribuicoes=?, tipo=?, escala=?, experiencia=?, cursos=?, diferencial=?, salario=? WHERE id=?";
                stmt = conexao.prepareStatement(sql);

                stmt.setString(1, vaga);
                stmt.setString(2, descricao);
                stmt.setString(3, requisitos);
                stmt.setString(4, atribuicoes);
                stmt.setString(5, tipo);
                stmt.setInt(6, escala);
                stmt.setString(7, experiencia);
                stmt.setString(8, cursos);
                stmt.setString(9, diferencial);
                stmt.setString(10, salario);
                stmt.setInt(11, id);

                int linhasAfetadas = stmt.executeUpdate();

                if (linhasAfetadas > 0) {
                    // Mensagem de sucesso
                    out.println("<p>Vaga atualizada com sucesso!</p>");
                } else {
                    // Mensagem se nenhum dado foi atualizado
                    out.println("<p>Nenhum dado foi atualizado.</p>");
                }

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (stmt != null) {
                    try {
                        stmt.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (conexao != null) {
                    try {
                        conexao.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        } catch (NumberFormatException e) {
            out.println("<p>ID inválido. Por favor, forneça um ID numérico válido.</p>");
        }
    }
%>
