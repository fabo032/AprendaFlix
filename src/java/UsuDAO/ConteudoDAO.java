package UsuDAO;

import Conexao.ConectaDB;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo.Conteudo;

public class ConteudoDAO {

    public List<Conteudo> listarPorUsuario(int idUsuario) {
    List<Conteudo> lista = new ArrayList<>();

    String sql = "SELECT c.id_conteudo, c.titulo, c.descricao, c.url, "
               + "c.id_categoria, cat.nome_categoria "
               + "FROM conteudo c "
               + "LEFT JOIN categorias cat ON c.id_categoria = cat.id "
               + "WHERE c.id_usuario = ? "
               + "ORDER BY c.id_conteudo DESC";

    try (Connection con = ConectaDB.conectar();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, idUsuario);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Conteudo c = new Conteudo();
            c.setIdConteudo(rs.getInt("id_conteudo"));
            c.setTitulo(rs.getString("titulo"));
            c.setDescricao(rs.getString("descricao"));
            c.setUrl(rs.getString("url"));
            c.setIdCategoria(rs.getInt("id_categoria"));
            c.setNomeCategoria(rs.getString("nome_categoria"));

            lista.add(c);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return lista;
}

    public List<Conteudo> buscarConteudosPorTitulo(String titulo) {
        List<Conteudo> lista = new ArrayList<>();

        String sql = "SELECT * FROM conteudo WHERE titulo LIKE ? ORDER BY id_conteudo DESC";

        try (Connection con = ConectaDB.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, "%" + titulo + "%");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Conteudo c = new Conteudo();
                    c.setIdConteudo(rs.getInt("id_conteudo"));
                    c.setTitulo(rs.getString("titulo"));
                    c.setDescricao(rs.getString("descricao"));
                    c.setUrl(rs.getString("url"));
                    c.setIdCategoria(rs.getInt("id_categoria"));
                    c.setIdUsuario(rs.getInt("id_usuario"));
                    lista.add(c);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    public List<String> buscarSugestoes(String titulo) {
        List<String> lista = new ArrayList<>();

        String sql = "SELECT titulo FROM conteudo WHERE titulo LIKE ? LIMIT 8";

        try (Connection con = ConectaDB.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, "%" + titulo + "%");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(rs.getString("titulo"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    public boolean inserirConteudo(Conteudo cont) {
        String sql = "INSERT INTO conteudo (titulo, descricao, url, id_categoria, id_usuario) VALUES (?, ?, ?, ?, ?)";

        try (Connection con = ConectaDB.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, cont.getTitulo());
            ps.setString(2, cont.getDescricao());
            ps.setString(3, cont.getUrl());
            ps.setInt(4, cont.getIdCategoria());
            ps.setInt(5, cont.getIdUsuario());

            int linhas = ps.executeUpdate();
            return linhas > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Conteudo> listarTodosConteudos() {
        List<Conteudo> lista = new ArrayList<>();

        String sql = "SELECT c.id_conteudo, c.titulo, c.descricao, c.url, "
                   + "c.id_categoria, c.id_usuario, "
                   + "cat.nome_categoria AS nome_categoria "
                   + "FROM conteudo c "
                   + "LEFT JOIN categorias cat ON c.id_categoria = cat.id "
                   + "ORDER BY c.id_conteudo DESC";

        try (Connection con = ConectaDB.conectar();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Conteudo c = new Conteudo();
                c.setIdConteudo(rs.getInt("id_conteudo"));
                c.setTitulo(rs.getString("titulo"));
                c.setDescricao(rs.getString("descricao"));
                c.setUrl(rs.getString("url"));
                c.setIdCategoria(rs.getInt("id_categoria"));
                c.setIdUsuario(rs.getInt("id_usuario"));

                // agora está correto ✔
                c.setNomeCategoria(rs.getString("nome_categoria"));

                lista.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }
    public Conteudo buscarPorId(int id) {
    Conteudo c = null;
    String sql = "SELECT * FROM conteudo WHERE id_conteudo = ?";

    try (Connection con = ConectaDB.conectar();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, id);

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            c = new Conteudo();
            c.setIdConteudo(rs.getInt("id_conteudo"));
            c.setTitulo(rs.getString("titulo"));
            c.setDescricao(rs.getString("descricao"));
            c.setUrl(rs.getString("url"));
            c.setIdCategoria(rs.getInt("id_categoria"));
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return c;
    }


}
