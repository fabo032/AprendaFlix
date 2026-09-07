package UsuDAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo.Categoria;
import Conexao.ConectaDB;

public class CategoriaDAO {

   public List<Categoria> listarCategorias() {
    List<Categoria> lista = new ArrayList<>();

    String sql = "SELECT id, nome_categoria FROM categorias ORDER BY nome_categoria";

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        con = ConectaDB.conectar();
        ps = con.prepareStatement(sql);
        rs = ps.executeQuery();

        while (rs.next()) {
            Categoria cat = new Categoria();
            cat.setId(rs.getInt("id"));
            cat.setNome(rs.getString("nome_categoria"));
            lista.add(cat);
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception ignored) {}
        try { if (ps != null) ps.close(); } catch (Exception ignored) {}
        try { if (con != null) con.close(); } catch (Exception ignored) {}
    }

    return lista;
}
}