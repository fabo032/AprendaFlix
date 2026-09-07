<%-- 
    Document   : perfil
    Created on : 28 de nov. de 2025, 15:28:31
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
%>

<!DOCTYPE html>
<html>
<head>
    <title>Perfil do Usuário</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>

        body {
            background-color: #f1f1f1;
            font-family: Arial, Helvetica, sans-serif;
        }

        
        .profile-card {
            max-width: 550px;
            margin: auto;
            margin-top: 60px;
            padding: 25px;
            border-radius: 15px;
            background-color: #0f0f0f;
            color: white;
            position: relative;
        }


        .marcaagua {
            font-size: 1.8rem;
            font-weight: bold;
            color: #ff0000;
            text-align: center;
            margin-bottom: 10px;
        }

        .form-control {
            background-color: #272727;
            color: white;
            border: 1px solid #444;
        }

        .btn-gray {
            background-color: #6c757d !important;
            border: none;
            color: white;
        }
        .btn-gray:hover {
            background-color: #565e64 !important;
        }

        .btn-red {
            background-color: #ff0000;
            color: white;
            border: none;
        }

        .btn-red:hover {
            background-color: #cc0000;
        }

    </style>
</head>

<body>

<div class="card shadow profile-card">

    <div class="marcaagua">AprendaFlix</div>

    <h2 class="text-center mb-4">Meu Perfil</h2>

    <div class="text-center mb-4">
        <img src="../img/icone.png" width="120"
             class="rounded-circle border shadow-sm">
    </div>

    <div class="mb-3">
        <label class="fw-bold">Nome de Exibição:</label>
        <p class="form-control"><%= user.getNome_exi() %></p>
    </div>

    <div class="mb-3">
        <label class="fw-bold">Nome de Usuário:</label>
        <p class="form-control"><%= user.getNome_usu() %></p>
    </div>

    <div class="mb-3">
        <label class="fw-bold">E-mail:</label>
        <p class="form-control"><%= user.getEmail() %></p>
    </div>


    <div class="d-grid gap-2 mt-4">

       
        <a href="editar_usuario.jsp" class="btn btn-gray btn-lg">
             Editar Perfil
        </a>

  
        <a href="../menu/telainicial.jsp" class="btn btn-gray btn-lg">
            Tela inicial
        </a>

        <a href="logout_usu.jsp" class="btn btn-gray btn-lg">
            Sair
        </a>
     

     
        <button class="btn btn-red btn-lg" data-bs-toggle="modal" data-bs-target="#modalExcluir">
            EXCLUIR CONTA
        </button>

    </div>

</div>

<div class="modal fade" id="modalExcluir" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">

      <div class="modal-header">
        <h5 class="modal-title">Confirmar Exclusão</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body">
        Tem certeza que deseja excluir sua conta?
        <b>Essa ação não pode ser desfeita.</b>
      </div>

      <div class="modal-footer">
        <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <a href="excluir_usu.jsp?id=<%= idLogado %>" class="btn btn-danger">Excluir</a>
      </div>

    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
