<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="voluntaryou.Vag"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cadastro de vaga</title>
</head>
<body>
    <h1>Cadastre a vaga</h1>

    <%
        // Verifica se o formulário foi submetido
        if (request.getMethod().equals("POST")) {
            // Recebendo dados do formulário
            String vaga = request.getParameter("vaga");
            String descricao = request.getParameter("descricao");
            String requisitos = request.getParameter("requisitos");
            String atribuicoes = request.getParameter("atribuicoes");
            String tipo = request.getParameter("tipo");

            // Verificando se o parâmetro "escala" não é nulo antes de convertê-lo
            int escala = 0;
            String escalaParam = request.getParameter("escala");
            if (escalaParam != null && !escalaParam.isEmpty()) {
                escala = Integer.parseInt(escalaParam);
            }

            String experiencia = request.getParameter("experiencia");
            String cursos = request.getParameter("cursos");
            String diferencial = request.getParameter("diferencial");
            String salario = request.getParameter("salario");

            // objeto Vag com os dados da vaga
            Vag vagas = new Vag();
            vagas.setVaga(vaga);
            vagas.setDescricao(descricao);
            vagas.setRequisitos(requisitos);
            vagas.setAtribuicoes(atribuicoes);
            vagas.setTipo(tipo);
            vagas.setEscala(escala);
            vagas.setExperiencia(experiencia);
            vagas.setCursos(cursos);
            vagas.setDiferencial(diferencial);
            vagas.setSalario(salario);

            // configurar a conexão com o banco de dados aqui
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conexao = DriverManager.getConnection("jdbc:mysql://localhost:3306/voluntario", "root", "");
                Statement stmt = conexao.createStatement();

                // inserção de dados no banco de dados
                String sql = "INSERT INTO vagas (vaga, descricao, requisitos, atribuicoes, tipo, escala, experiencia, cursos, diferencial, salario) VALUES ('"
                        + vagas.getVaga() + "', '"
                        + vagas.getDescricao() + "', '"
                        + vagas.getRequisitos() + "', '"
                        + vagas.getAtribuicoes() + "', '"
                        + vagas.getTipo() + "', "
                        + vagas.getEscala() + ", '"
                        + vagas.getExperiencia() + "', '"
                        + vagas.getCursos() + "', '"
                        + vagas.getDiferencial() + "', '"
                        + vagas.getSalario() + "')";

                stmt.executeUpdate(sql);
                conexao.close();

                // Exibir mensagem de sucesso após o cadastro
                out.println("<p>Vaga cadastrada com sucesso!</p>");
            } catch (Exception ex) {
                ex.printStackTrace();
                out.println("Erro: " + ex.toString());
            }
        }
    %>

    <form action="cadastro_vag.jsp" method="post">
        <label for="vaga">Vaga:</label>
        <input type="text" id="vaga" name="vaga" required><br><br>

        <label for="descricao">Descrição:</label>
        <input type="text" id="descricao" name="descricao" required><br><br>

        <label for="requisitos">Requisitos:</label>
        <textarea id="requisitos" name="requisitos" required></textarea><br><br>

        <label for="atribuicoes">Atribuições:</label>
        <textarea id="atribuicoes" name="atribuicoes" required></textarea><br><br>

        <label for="tipo">Tipo:</label>
        <select id="tipo" name="tipo" required>
            <option value="Presencial">Presencial</option>
            <option value="HomeOffice">HomeOffice</option>
            <option value="Híbrido">Híbrido</option>
        </select><br><br>

        <label for="escala">Escala:</label>
        <input type="number" id="escala" name="escala" required><br><br>

        <label for="experiencia">Experiência:</label>
        <textarea id="experiencia" name="experiencia"></textarea><br><br>

        <label for="cursos">Cursos desejados:</label>
        <textarea id="cursos" name="cursos" required></textarea><br><br>

        <label for="diferencial">Diferencial:</label>
        <textarea id="diferencial" name="diferencial"></textarea><br><br>

        <label for="salario">Salário:</label>
        <input type="text" id="salario" name="salario"><br><br>

        <input type="submit" value="Cadastrar">
    </form>
</body>
</html>
