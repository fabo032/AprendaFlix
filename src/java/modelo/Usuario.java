package modelo;

public class Usuario {
    
    private int idUsuario;
    private String email;
    private String nome_exi;
    private String nome_usu;
    private String senha;

    // GETTERS E SETTERS
    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNome_exi() {
        return nome_exi;
    }

    public void setNome_exi(String nome_exi) {
        this.nome_exi = nome_exi;
    }

    public String getNome_usu() {
        return nome_usu;
    }

    public void setNome_usu(String nome_usu) {
        this.nome_usu = nome_usu;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }
}
