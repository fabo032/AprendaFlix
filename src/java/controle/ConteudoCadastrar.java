package controle;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import modelo.Conteudo;
import UsuDAO.ConteudoDAO;

public class ConteudoCadastrar extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer idUsuario = (Integer) session.getAttribute("idUsuario");

        if (idUsuario == null) {
            response.sendRedirect("../login/index.jsp");
            return;
        }

        String titulo = request.getParameter("titulo");
        String descricao = request.getParameter("descricao");
        String link = request.getParameter("link");
        int idCategoria = Integer.parseInt(request.getParameter("categoria")); // campo do formulário

        Conteudo cont = new Conteudo();
        cont.setTitulo(titulo);
        cont.setDescricao(descricao);
        cont.setUrl(link);
        cont.setIdCategoria(idCategoria);
        cont.setIdUsuario(idUsuario);

        ConteudoDAO dao = new ConteudoDAO();
        boolean ok = dao.inserirConteudo(cont);

        if (ok) {
            response.sendRedirect(request.getContextPath() + "/telainicial.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/conteudo_erro.jsp");
        }
    }
}
