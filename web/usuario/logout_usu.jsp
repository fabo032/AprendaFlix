<%-- 
    Document   : logout_usu
    Created on : 28 de nov. de 2025, 16:22:15
    Author     : Fábio
--%>
<%
    // Finaliza a sessão do usuário
    session.invalidate();

    // Redireciona para a página inicial (login)
    response.sendRedirect("../index.html");
%>