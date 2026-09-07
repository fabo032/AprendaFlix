package UsuDAO;

import java.sql.*;
import modelo.Usuario;
import Conexao.ConectaDB;

public class UsuarioDAO {

    // LOGIN - retorna o objeto Usuario completo
    public Usuario logar(String email, String senha) {
        try (Connection conn = ConectaDB.conectar()) {
            String sql = "SELECT * FROM usuarios WHERE email = ? AND senha = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, senha);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Usuario u = new Usuario();
                u.setIdUsuario(rs.getInt("id_usuario"));
                u.setEmail(rs.getString("email"));
                u.setSenha(rs.getString("senha"));
                u.setNome_usu(rs.getString("nome_usu"));
                u.setNome_exi(rs.getString("nome_exi"));
                return u;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // login incorreto
    }

    // CADASTRAR - insere um novo usuário no banco
    public boolean cadastrar(Usuario u) {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = ConectaDB.conectar();
            String sql = "INSERT INTO usuarios (email, senha, nome_usu, nome_exi) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, u.getEmail());
            stmt.setString(2, u.getSenha());
            stmt.setString(3, u.getNome_usu());
            stmt.setString(4, u.getNome_exi());
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (stmt != null) stmt.close();
            } catch (Exception e) {
                // ignorar
            }
            try {
                if (conn != null) conn.close();
            } catch (Exception e) {
                // ignorar
            }
        }
    }
public Usuario buscarPorId(int idUsuario) {
    String sql = "SELECT * FROM usuarios WHERE id_usuario = ?";
    try (Connection con = ConectaDB.conectar();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, idUsuario);

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                Usuario u = new Usuario();

                u.setIdUsuario(rs.getInt("id_usuario"));

                // SEUS CAMPOS DO BANCO:
                u.setNome_exi(rs.getString("nome_exi"));
                u.setNome_usu(rs.getString("nome_usu"));
                u.setEmail(rs.getString("email"));
                u.setSenha(rs.getString("senha"));

                return u;
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}
public boolean excluir(int idUsuario) {
    String sql = "DELETE FROM usuarios WHERE id_usuario = ?";

    try (Connection con = ConectaDB.conectar();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, idUsuario);

        int linhas = ps.executeUpdate();
        return linhas > 0;

    } catch (Exception e) {
        e.printStackTrace();
    }

    return false;
}

}




