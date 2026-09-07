<%-- 
    Document   : excluir_usu
    Created on : 28 de nov. de 2025, 16:08:20
    Author     : Fábio
--%>

<%@page import="UsuDAO.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Verifica se o usuário está logado
    if (session.getAttribute("autorizado") == null ||
        !"sim".equals(session.getAttribute("autorizado"))) {
        response.sendRedirect("../index.html");
        return;
    }

    // Pegando ID da URL
    String idParam = request.getParameter("id");

    if (idParam == null) {
        out.println("Erro: ID não informado.");
        return;
    }

    int idUsuario = Integer.parseInt(idParam);

    UsuarioDAO dao = new UsuarioDAO();

    boolean excluiu = dao.excluir(idUsuario);

    if (excluiu) {
        // Encerrar sessão após excluir a conta
        session.invalidate();
%>

<script>
    alert("Sua conta foi excluída com sucesso.");
    window.location.href = "../index.html";
</script>

<%
    } else {
%>

<script>
    alert("Erro ao excluir sua conta. Tente novamente.");
    window.location.href = "perfil.jsp";
</script>

<%
    }
%>
