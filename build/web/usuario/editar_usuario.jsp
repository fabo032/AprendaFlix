<%-- 
    Document   : editar_usuario
    Created on : 28 de nov. de 2025, 15:08:14
    Author     : Fábio
--%>
<%-- 
    Document   : editar_usuario
    Created on : 28 de nov. de 2025
    Author     : Fábio
--%>

<%-- 
    Document   : editar_usuario
    Created on : 28 de nov. de 2025
    Author     : Fábio
--%>

<%-- 
    Document   : editar_usuario
    Author     : Fábio
--%>

<%@page import="modelo.Usuario"%>
<%@page import="UsuDAO.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("autorizado") == null ||
        !"sim".equals(session.getAttribute("autorizado"))) {
        response.sendRedirect("../index.html");
        return;
    }

    int idLogado = Integer.parseInt(session.getAttribute("id_usuario").toString());

    UsuarioDAO dao = new UsuarioDAO();
    Usuario user = dao.buscarPorId(idLogado);

    if (user == null) {
        out.println("Erro: usuário não encontrado!");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Editar Perfil</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f5f5f5;
            background-image: url('../img/marcadagua.png');
            background-repeat: no-repeat;
            background-position: center;
            background-size: 45%;
        }

        .card-edit {
            max-width: 600px;
            margin: auto;
            margin-top: 60px;
            padding: 30px;
            border-radius: 15px;
            background-color: #000; /* CARD PRETO */
            color: white;
            box-shadow: 0 0 15px rgba(0,0,0,0.4);
        }

        .titulo-vermelho {
            color: #ff2b2b;
            font-weight: bold;
        }

        label {
            font-weight: bold;
            color: #f2f2f2;
        }

        .form-control {
            background-color: #222;
            border: 1px solid #444;
            color: white;
        }

        .form-control:focus {
            background-color: #222;
            color: white;
            border-color: #ff2b2b;
            box-shadow: 0 0 7px rgba(255,0,0,0.5);
        }

        .btn-vermelho {
            background-color: #d60000;
            border: none;
            color: white;
        }

        .btn-vermelho:hover {
            background-color: #b30000;
        }

        .btn-cinza {
            background-color: #666;
            border: none;
            color: white;
        }

        .btn-cinza:hover {
            background-color: #555;
        }
    </style>

</head>

<body>

<div class="card shadow card-edit">

    <h2 class="text-center mb-4 titulo-vermelho">
        Editar Seus Dados
    </h2>

    <form action="editar_usuario_processa.jsp" method="post">

        <input type="hidden" name="id_usuario" value="<%= user.getIdUsuario() %>">

        <div class="mb-3">
            <label>Nome de Usuário (Login):</label>
            <input type="text" name="nome_usu" class="form-control"
                   value="<%= user.getNome_usu() %>" required>
        </div>

        <div class="mb-3">
            <label>Nome de Exibição:</label>
            <input type="text" name="nome_exi" class="form-control"
                   value="<%= user.getNome_exi() %>" required>
        </div>

        <div class="mb-3">
            <label>E-mail:</label>
            <input type="email" name="email" class="form-control"
                   value="<%= user.getEmail() %>" required>
        </div>

        <div class="mb-3">
            <label>Senha (deixe vazio para manter a atual):</label>
            <input type="password" name="senha" class="form-control">
        </div>

        <button type="submit" class="btn btn-vermelho w-100 mt-2 btn-lg">
            Salvar Alterações
        </button>

    </form>

    <a href="perfil.jsp" class="btn btn-cinza w-100 mt-3 btn-lg">
        Voltar para o Perfil
    </a>

</div>

</body>
</html>
