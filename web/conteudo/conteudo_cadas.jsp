<<%-- 
    Document   : conteudo_cadas
    Created on : 27 de nov. de 2025
    Author     : Fábio
--%>

<%@page import="modelo.Usuario"%>
<%@page import="UsuDAO.UsuarioDAO"%>
<%@page import="modelo.Conteudo"%>
<%@page import="UsuDAO.ConteudoDAO"%>
<%@page import="modelo.Categoria"%>
<%@page import="UsuDAO.CategoriaDAO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Verifica login
    if (session.getAttribute("id_usuario") == null) {
        response.sendRedirect("../index.html");
        return;
    }

    int idLogado = (int) session.getAttribute("id_usuario");

    UsuarioDAO udao = new UsuarioDAO();
    Usuario user = udao.buscarPorId(idLogado);
%>

%>

<%
    CategoriaDAO categoriaDAO = new CategoriaDAO();
    List<Categoria> categorias = categoriaDAO.listarCategorias();

    boolean sucesso = false;
    boolean tentouCadastrar = false;

    if (request.getMethod().equalsIgnoreCase("POST")) {

        tentouCadastrar = true;

        String titulo = request.getParameter("titulo");
        String descricao = request.getParameter("descricao");
        String link = request.getParameter("link");
        int idCategoria = Integer.parseInt(request.getParameter("categoria"));

        // usa o mesmo ID que vem da sessão
       Integer idUsuario = (Integer) session.getAttribute("id_usuario");


        Conteudo cont = new Conteudo();
        cont.setTitulo(titulo);
        cont.setDescricao(descricao);
        cont.setUrl(link);
        cont.setIdCategoria(idCategoria);
        cont.setIdUsuario(idUsuario);

        ConteudoDAO cdao = new ConteudoDAO();  // ← nome diferente, sem duplicação
        sucesso = cdao.inserirConteudo(cont);
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Cadastrar Conteúdo - AprendaFlix</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        html, body {
            height: 100%;
            margin: 0; padding: 0;
            background-color: #f1f1f1;
            font-family: Arial, Helvetica, sans-serif;
        }
        body { display: flex; }
        .sidebar {
        width: 240px;
        background-color: #0f0f0f;
        color: white;
        min-height: 100vh;
        position: fixed;
        top: 0;
        left: 0;
        padding: 1rem;
        }
        
        .sidebar h4 {
            color: #ff0000; font-weight: 700;
            margin-bottom: 2rem; font-size: 1.6rem;
        }
        .sidebar a {
        display: block;
        color: #e5e5e5;
        text-decoration: none;
        padding: 10px;
        border-radius: 8px;
        margin-bottom: 5px;
        transition: 0.2s;
        }
        .sidebar a:hover,
        .sidebar a.active {
        background-color: #272727;
        color: white;
        }
        .sidebar-photo-container {
    width: 100%;
    text-align: center;
    margin-top: 20px;
    margin-bottom: 15px;
    }

    .sidebar-photo {
        width: 95px;
        height: 95px;
        border-radius: 50%;
        border: 3px solid #ff0000;
        object-fit: cover;
    }

    /* BOTÃO PERFIL */
    .sidebar-item-profile {
        background-color: #272727;
        color: #ffffff !important;
        font-weight: bold;
        border-radius: 8px;
        padding: 10px;
        margin-bottom: 15px;
        display: block;
        text-align: center;
        transition: 0.2s;
    }

    .sidebar-item-profile:hover {
        background-color: #3a3a3a;
        transform: translateX(4px);
    }
        .main-content {
            margin-left: 240px; flex-grow: 1;
            min-height: 100vh; background: white;
            padding: 2rem 3rem; box-shadow: inset 0 0 10px #ddd;
        }
        .topbar {
            background-color: white; border-bottom: 1px solid #ddd;
            padding: 0.7rem 0; position: sticky; top: 0;
            z-index: 1000; margin-bottom: 2rem;
            display: flex; align-items: center;
            justify-content: space-between;
        }
        .topbar .logo {
            font-size: 1.6rem; font-weight: 700;
            color: #ff0000; user-select: none;
        }
        #preview {
            margin-bottom: 1rem; border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 6px rgba(0,0,0,0.15);
        }
    </style>
</head>

<body>

    <!-- SIDEBAR PADRÃO DO MENU -->
<aside class="sidebar">

    <!-- FOTO DO USUÁRIO -->
    <div class="sidebar-photo-container">
        <img src="../img/icone.png" class="sidebar-photo">
    </div>

    <!-- BOTÃO PERFIL -->
    <a href="../usuario/perfil.jsp" class="sidebar-item-profile">Seu Perfil</a>

    <!-- MENU -->
    <a href="../menu/telainicial.jsp" class="active">🏠 Início</a>

    <hr class="text-secondary">

    <a href="../conteudo/conteudo_cadas.jsp">🎬 Cadastrar Conteúdo</a>
    <a href="#">📁 Seus Vídeos</a>

</aside>


    <div class="main-content">

        <div class="topbar">
            <div class="logo">AprendaFlix</div>
        </div>

        <h2>Cadastrar Conteúdo</h2>

        <% if (tentouCadastrar) { %>
            <% if (sucesso) { %>
                <div class="alert alert-success">Conteúdo cadastrado com sucesso!</div>
                <script>
                    setTimeout(() => {
                        window.location.href = "<%= request.getContextPath() %>/menu/telainicial.jsp";
                    }, 2000);
                </script>
            <% } else { %>
                <div class="alert alert-danger">Erro ao cadastrar conteúdo.</div>
            <% } %>
        <% } %>

        <form method="POST" class="mt-4">

            <div class="mb-3">
                <label class="form-label">Título</label>
                <input type="text" class="form-control" name="titulo" required />
            </div>

            <div class="mb-3">
                <label class="form-label">Descrição</label>
                <textarea class="form-control" name="descricao" rows="3" required></textarea>
            </div>

            <div class="mb-3">
                <label class="form-label">Link/URL</label>
                <input type="text" class="form-control" id="link" name="link" required />
            </div>

            <div id="preview" style="display:none;">
                <iframe id="videoPreview" width="100%" height="315" allowfullscreen></iframe>
            </div>

            <div class="mb-3">
                <label class="form-label">Categoria</label>
                <select class="form-select" name="categoria" required>
                    <option disabled selected>Selecione</option>
                    <% for (Categoria c : categorias) { %>
                        <option value="<%= c.getId() %>"><%= c.getNome() %></option>
                    <% } %>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Usuário</label>
                <input type="text" class="form-control" readonly
                       value="<%= user.getNome_exi() %>">
            </div>

            <button type="submit" class="btn btn-danger">Cadastrar</button>
        </form>
    </div>

    <script>
        const inputLink = document.getElementById("link");
        const previewDiv = document.getElementById("preview");
        const frame = document.getElementById("videoPreview");

        inputLink.addEventListener("input", () => {
            const url = inputLink.value.trim();
            const id = url.match(/(?:v=|youtu\.be\/)([\w\-]+)/);

            if (id) {
                frame.src = "https://www.youtube.com/embed/" + id[1];
                previewDiv.style.display = "block";
            } else {
                frame.src = "";
                previewDiv.style.display = "none";
            }
        });
    </script>

</body>
</html>
