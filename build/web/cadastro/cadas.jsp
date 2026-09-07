<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.math.BigInteger" %>
<%@page import="modelo.Usuario"%>
<%@page import="UsuDAO.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    try {

        // Recebe dados
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        String nome_usu = request.getParameter("nome_usu");
        String nome_exi = request.getParameter("nome_exi");

        // Criptografa em MD5
        MessageDigest md5 = MessageDigest.getInstance("MD5");
        md5.update(senha.getBytes(), 0, senha.length());
        String senhaCript = new BigInteger(1, md5.digest()).toString(16);

        // Prepara objeto
        Usuario u = new Usuario();
        u.setEmail(email);
        u.setSenha(senhaCript);
        u.setNome_usu(nome_usu);
        u.setNome_exi(nome_exi);

        // Salva
        UsuarioDAO dao = new UsuarioDAO();
        boolean ok = dao.cadastrar(u);

        if (ok) {
%>
            <h3>Usuário cadastrado com sucesso!</h3>
            <script>
                setTimeout(() => { window.location.href = "../index.html"; }, 1500);
            </script>
<%
        } else {
%>
            <h3>Erro ao cadastrar usuário!</h3>
<%
        }

    } catch (Exception e) {
        out.print("Erro: " + e.getMessage());
    }
%>
