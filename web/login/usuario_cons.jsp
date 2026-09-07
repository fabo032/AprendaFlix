<%@page import="java.math.BigInteger"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="modelo.Usuario"%>  
<%@page import="UsuDAO.UsuarioDAO"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    UsuarioDAO usuDAO = new UsuarioDAO();

    String email = request.getParameter("email");
    String senha = request.getParameter("senha");

    // Gerar MD5
    MessageDigest md5 = MessageDigest.getInstance("MD5");
    md5.update(senha.getBytes(), 0, senha.length());
    String senha_cript = new BigInteger(1, md5.digest()).toString(16);

    Usuario usuarioLogado = usuDAO.logar(email, senha_cript);

    if (usuarioLogado != null) {
        out.println("Acesso Permitido!");

       
        session.setAttribute("autorizado", "sim");
        session.setAttribute("id_usuario", usuarioLogado.getIdUsuario());
        session.setAttribute("nome_exi", usuarioLogado.getNome_exi());
        session.setAttribute("nome_usu", usuarioLogado.getNome_usu());
        session.setAttribute("email", usuarioLogado.getEmail());

%>
        <script>
            window.location.href='../menu/telainicial.jsp';
        </script>

<%
    } else {
        out.println("Acesso Negado!");
        session.setAttribute("autorizado", "não");
    }
%>
