<%-- 
    Document   : buscar_sugestoes
    Created on : 28 de nov. de 2025
    Author     : Fábio
--%>

<%@page import="java.util.List"%>
<%@page import="UsuDAO.ConteudoDAO"%>
<%@page contentType="application/json" pageEncoding="UTF-8"%>

<%
    String termo = request.getParameter("titulo");

    ConteudoDAO dao = new ConteudoDAO();
    List<String> sugestoes = dao.buscarSugestoes(termo);

    String json = "[";

    for (int i = 0; i < sugestoes.size(); i++) {
        json += "\"" + sugestoes.get(i) + "\"";
        if (i < sugestoes.size() - 1) json += ",";
    }

    json += "]";

    out.print(json);
%>
