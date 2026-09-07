<%@ page import="java.util.List" %>
<%@ page import="modelo.Conteudo" %>
<%@ page import="UsuDAO.ConteudoDAO" %>
<%@ page import="UsuDAO.UsuarioDAO" %>
<%@ page import="modelo.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String termo = request.getParameter("titulo");

    ConteudoDAO conteudoDAO = new ConteudoDAO();
    UsuarioDAO usuarioDAO = new UsuarioDAO();

    List<Conteudo> resultados = conteudoDAO.buscarConteudosPorTitulo(termo);
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="utf-8" />
  <title>Resultados da Busca - AprendaFlix</title>

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

    /* --- SIDEBAR --- */
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
      color: #ff0000;
      font-weight: bold;
      margin-bottom: 2rem;
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

    /* BOTÃO PERFIL IGUAL HOME */
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

    /* --- PRINCIPAL --- */
    .main-content {
      margin-left: 240px;
      width: 100%;
      min-height: 100vh;
    }

    /* --- TOPBAR --- */
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

    .logo {
      font-size: 1.4rem;
      font-weight: bold;
      color: #ff0000;
    }

    /* --- VÍDEOS --- */
    .video-card {
      background: white;
      padding: 10px;
      border-radius: 12px;
      box-shadow: 0 2px 5px rgba(0,0,0,0.05);
      transition: 0.2s;
      height: 100%;
    }

    .video-card:hover {
      transform: translateY(-3px);
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }

    .video-thumb iframe {
      width: 100%;
      height: 180px;
      border-radius: 10px;
    }

    .video-title {
      font-size: 1rem;
      font-weight: 600;
      margin-top: 8px;
    }

    .video-meta {
      font-size: 0.85rem;
      color: #606060;
    }
  </style>
</head>

<body>

<!-- SIDEBAR -->
<aside class="sidebar">

    <!-- FOTO DO USUÁRIO -->
    <div class="sidebar-photo-container">
        <img src="../img/icone.png" class="sidebar-photo">
    </div>

    <!-- BOTÃO SEU PERFIL IGUAL A HOME -->
    <a href="../usuario/perfil.jsp" class="sidebar-item-profile">
        Seu Perfil
    </a>

    <a href="../menu/telainicial.jsp">🏠 Início</a>

    <hr class="text-secondary">

    <a href="../conteudo/conteudo_cadas.jsp">🎬 Cadastrar Conteúdo</a>
   

</aside>


<!-- CONTEÚDO -->
<div class="main-content">

    
  <div class="topbar">

    <!-- LOGO ESQUERDA -->
    <div class="logo me-auto">AprendaFlix</div>

    <!-- BARRA DE PESQUISA CENTRALIZADA -->
    <form class="d-flex position-relative" style="width: 40%; margin: 0 auto;" 
          onsubmit="buscar(); return false;">
        <input id="barraPesquisa" class="form-control me-2" type="text"
               placeholder="Buscar vídeos..." value="<%= termo %>">
        <button type="button" class="btn btn-danger" onclick="buscar()">🔍</button>

        <ul id="sugestoes" class="list-group position-absolute w-100"
            style="top:100%; z-index:999;"></ul>
            <div>
            </div>
    </form>

</div>



    <!-- RESULTADOS -->
    <div class="videos-area p-4">

        <h3 class="mb-4">Resultados para: <strong>"<%= termo %>"</strong></h3>

        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4">

            <% if (resultados.isEmpty()) { %>
                <p>Nenhum vídeo encontrado.</p>
            <% } else { %>

            <% for (Conteudo c : resultados) {

                Usuario user = usuarioDAO.buscarPorId(c.getIdUsuario());

                String videoId = "";
                String url = c.getUrl();

                if (url != null && url.contains("youtu")) {
                    java.util.regex.Pattern pattern =
                        java.util.regex.Pattern.compile("(?:v=|\\/)([\\w-]{11})");
                    java.util.regex.Matcher matcher = pattern.matcher(url);
                    if (matcher.find()) videoId = matcher.group(1);
                }
            %>

            <div class="col">
                <div class="video-card">

                    <div class="video-thumb">
                        <% if (!videoId.isEmpty()) { %>
                            <iframe src="https://www.youtube.com/embed/<%= videoId %>" allowfullscreen></iframe>
                        <% } else { %>
                            <div style="display:flex;justify-content:center;align-items:center;height:180px;background:#ccc;border-radius:10px;">
                                Sem vídeo
                            </div>
                        <% } %>
                    </div>

                    <div class="video-title"><%= c.getTitulo() %></div>
                    <div class="video-meta">
                        <%= (user != null) ? user.getNome_exi() : "Autor desconhecido" %>
                        • Categoria <%= c.getIdCategoria() %>
                    </div>

                </div>
            </div>

            <% } %>

            <% } %>

        </div>

    </div>

</div>

<script>
function buscar() {
    let termo = document.getElementById("barraPesquisa").value.trim();
    if (termo !== "") {
        window.location.href = "buscar_video.jsp?titulo=" + encodeURIComponent(termo);
    }
}
</script>

</body>
</html>
