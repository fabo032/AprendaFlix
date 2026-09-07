<%-- 
    Document   : editar_usuario_processa
    Created on : 28 de nov. de 2025, 15:13:13
    Author     : Fábio
--%>

<%@page import="java.sql.*"%>
<%@page import="Conexao.ConectaDB"%>
<%@page import="modelo.Usuario"%>
<%@page import="UsuDAO.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Verifica login
    if (session.getAttribute("autorizado") == null ||
        !"sim".equals(session.getAttribute("autorizado"))) {
        response.sendRedirect("../index.html");
        return;
    }

    request.setCharacterEncoding("UTF-8");

    // Recebe campos do formulário
    int idUsuario = Integer.parseInt(request.getParameter("id_usuario"));
    String nomeUsu = request.getParameter("nome_usu");
    String nomeExi = request.getParameter("nome_exi");
    String email = request.getParameter("email");
    String senha = request.getParameter("senha"); // pode vir vazio

    // Carrega dados atuais para manter a senha caso esteja vazia
    UsuarioDAO dao = new UsuarioDAO();
    Usuario atual = dao.buscarPorId(idUsuario);

    if (atual == null) {
        out.println("<h3>Erro: usuário não encontrado!</h3>");
        return;
    }

    // Se senha vier vazia → mantém a atual
    String senhaFinal = senha == null || senha.trim().isEmpty()
                        ? atual.getSenha()
                        : senha;

    try (Connection conn = ConectaDB.conectar()) {

        String sql = "UPDATE usuarios SET email=?, senha=?, nome_usu=?, nome_exi=? WHERE id_usuario=?";
        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setString(1, email);
        ps.setString(2, senhaFinal);
        ps.setString(3, nomeUsu);
        ps.setString(4, nomeExi);
        ps.setInt(5, idUsuario);

        int linhas = ps.executeUpdate();

        if (linhas > 0) {
            // Atualiza sessão caso seja o próprio usuário logado
            session.setAttribute("email", email);
            session.setAttribute("nome_exi", nomeExi);
            session.setAttribute("nome_usu", nomeUsu);

            response.sendRedirect("../menu/telainicial.jsp?edit=ok");
        } else {
            out.println("<h3>Erro ao atualizar usuário!</h3>");
        }

    } catch (Exception e) {
        out.println("Erro SQL: " + e.getMessage());
        e.printStackTrace();
    }
%>
