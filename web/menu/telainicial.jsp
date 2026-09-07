<%@ page import="modelo.Conteudo" %>
<%@ page import="UsuDAO.ConteudoDAO" %>
<%@ page import="UsuDAO.UsuarioDAO" %>
<%@ page import="modelo.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (session.getAttribute("autorizado") == null || !"sim".equals(session.getAttribute("autorizado"))) {
        response.sendRedirect("../index.html");
        return;
    }
%>

<%
    ConteudoDAO conteudoDAO = new ConteudoDAO();
    UsuarioDAO usuarioDAO = new UsuarioDAO();
    java.util.List<Conteudo> listaConteudos = conteudoDAO.listarTodosConteudos();
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>AprendaFlix</title>
    
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
  
  <style>
    html, body {
      margin: 0;
      padding: 0;
      height: 100%;
      background-color: #f1f1f1;
      font-family: Arial, Helvetica, sans-serif;
    }

    body {
      display: flex;
    }

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

/* FOTO DO USUÁRIO */
    .sidebar-photo-container {
    width: 100%;
    text-align: center;
    margin-top: 20px;
    margin-bottom: 15px;
}

    .sidebar-photo {
    width: 90px;
    height: 90px;
    border-radius: 50%;
    border: 3px solid #ff0000;
    object-fit: cover;
}

/* BOTÃO PERFIL */
    .sidebar-item-profile {
    background-color: #272727;
    color: white !important;
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
      margin-left: 240px;
      width: 100%;
      min-height: 100vh;
    }

    .topbar {
      background-color: white;
      border-bottom: 1px solid #ddd;
      padding: 0.6rem 1.2rem;
      position: sticky;
      top: 0;
      z-index: 1000;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .topbar .logo {
      font-size: 1.4rem;
      font-weight: bold;
      color: #ff0000;
    }

    .search-box input {
      border-radius: 20px 0 0 20px;
    }

    .search-box button {
      border-radius: 0 20px 20px 0;
      border: 1px solid #ccc;
      background-color: #f1f1f1;
    }

    .search-box button:hover {
      background-color: #e5e5e5;
    }

    .btn-login {
      background-color: #ff0000;
      color: white;
      border: none;
      padding: 6px 14px;
      border-radius: 20px;
      font-size: 0.9rem;
    }

    .btn-login:hover {
      background-color: #cc0000;
    }

    .videos-area {
      padding: 1.5rem;
    }

    .video-card {
      background: white;
      padding: 10px;
      border-radius: 12px;
      box-shadow: 0 2px 5px rgba(0,0,0,0.05);
      transition: 0.2s;
      height: 100%;
      display: flex;
      flex-direction: column;
    }

    .video-card:hover {
      transform: translateY(-3px);
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }

    .video-thumb {
      width: 100%;
      height: 180px;
      border-radius: 10px;
      margin-bottom: 10px;
      overflow: hidden;
    }

    .video-thumb iframe {
      width: 100%;
      height: 180px;
      border: none;
    }

    .video-title {
      font-size: 0.95rem;
      font-weight: 600;
      margin-bottom: 4px;
      color: #0f0f0f;
      flex-grow: 1;
    }

    .video-meta {
      font-size: 0.85rem;
      color: #606060;
    }
  </style>
</head>
<script>
// Função buscar
function buscar() {
    let termo = document.getElementById("barraPesquisa").value;
    if (termo.trim() !== "") {
        window.location.href = "../conteudo/buscar_video.jsp?titulo=" + encodeURIComponent(termo);
    }
}

// AUTOCOMPLETE
document.getElementById("barraPesquisa").addEventListener("keyup", function() {
    let termo = this.value;

    if (termo.length < 1) {
        document.getElementById("sugestoes").innerHTML = "";
        return;
    }

    fetch("../conteudo/buscar_sugestoes.jsp?titulo=" + encodeURIComponent(termo))
        .then(resp => resp.json())
        .then(dados => {

            let lista = "";

            dados.forEach(item => {
                lista += `
                    <li class="list-group-item list-group-item-action" 
                        style="cursor:pointer;"
                        onclick="selecionar('${item}')">
                        ${item}
                    </li>`;
            });

            document.getElementById("sugestoes").innerHTML = lista;
        });
});

function selecionar(titulo) {
    document.getElementById("barraPesquisa").value = titulo;
    document.getElementById("sugestoes").innerHTML = "";
}
</script>

<body>

  <!-- SIDEBAR -->
<aside class="sidebar">

    <!-- FOTO DO USUÁRIO -->
    <div class="sidebar-photo-container">
        <img src="../img/icone.png" class="sidebar-photo">
    </div>

    <!-- BOTÃO SEU PERFIL (IGUAL AO DA BUSCA) -->
    <a href="../usuario/perfil.jsp" class="sidebar-item-profile">
        Seu Perfil
    </a>

    <!-- MENU -->
    <a href="../menu/telainicial.jsp" class="active">🏠 Início</a>

    <hr class="text-secondary">

    <a href="../conteudo/conteudo_cadas.jsp">🎬 Cadastrar Conteúdo</a>
   


</aside>

<style>
    /* FOTO */
    .sidebar-photo-container {
        width: 100%;
        text-align: center;
        margin-top: 20px;   /* espaço acima */
        margin-bottom: 15px;
    }

    .sidebar-photo {
        width: 90px;             /* menor que o perfil */
        height: 90px;
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
</style>

  <!-- ÁREA PRINCIPAL -->
  <div class="main-content">

    <!-- HEADER -->
   <div class="topbar">
    <div class="logo">AprendaFlix</div>

    <!-- BARRA DE PESQUISA FUNCIONAL -->
    <form class="d-flex position-relative w-50" role="search" autocomplete="off" onsubmit="buscar(); return false;">
        <input 
            id="barraPesquisa"
            class="form-control me-2"
            type="search"
            placeholder="Buscar vídeos..."
            aria-label="Search">

        <button type="button" class="btn btn-danger" onclick="buscar()">
            🔍
        </button>

        <!--Lista de sugestões-->
        <ul id="sugestoes" 
            class="list-group position-absolute w-100"
            style="top: 100%; z-index: 999;">
        </ul>
    </form>


</div>

    <!-- VÍDEOS -->
    <div class="videos-area">
      <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4">

        <% for (Conteudo c : listaConteudos) { 
              // Pega o usuário que cadastrou o vídeo
              Usuario user = usuarioDAO.buscarPorId(c.getIdUsuario());

              // Extrai vídeo do YouTube do link, para iframe
              String videoId = "";
              String url = c.getUrl();
              if (url != null && url.contains("youtu")) {
                // Extrair ID via regex simples
                java.util.regex.Pattern pattern = java.util.regex.Pattern.compile("(?:v=|\\/)([\\w-]{11})");
                java.util.regex.Matcher matcher = pattern.matcher(url);
                if (matcher.find()) {
                  videoId = matcher.group(1);
                }
              }
        %>
        <div class="col">
          <div class="video-card">
            <div class="video-thumb">
              <% if (!videoId.isEmpty()) { %>
                <iframe src="https://www.youtube.com/embed/<%= videoId %>" allowfullscreen></iframe>
              <% } else { %>
                <div style="display:flex; align-items:center; justify-content:center; height: 180px; background:#cfcfcf; border-radius: 10px; color:#555; font-weight:bold;">
                  Sem vídeo
                </div>
              <% } %>
            </div>
            <div class="video-title"><%= c.getTitulo() %></div>
            <div class="video-meta">
              <%= (user != null) ? user.getNome_exi() : "Usuário desconhecido" %> • Categoria: <%= c.getNomeCategoria() %>
            </div>
          </div>
        </div>
        <% } %>

      </div>
    </div>

  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
