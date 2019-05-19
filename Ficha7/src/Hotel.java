import java.util.Objects;

public class Hotel {


    private String id;
    private String nome;
    private String localidade;
    private int categoria;
    private int nQuartosDisp;
    private int pQuarto;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getLocalidade() {
        return localidade;
    }

    public void setLocalidade(String localidade) {
        this.localidade = localidade;
    }

    public int getCategoria() {
        return categoria;
    }

    public void setCategoria(int categoria) {
        this.categoria = categoria;
    }

    public int getnQuartosDisp() {
        return nQuartosDisp;
    }

    public void setnQuartosDisp(int nQuartosDisp) {
        this.nQuartosDisp = nQuartosDisp;
    }

    public int getpQuarto() {
        return pQuarto;
    }

    public void setpQuarto(int pQuarto) {
        this.pQuarto = pQuarto;
    }

    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Hotel hotel = (Hotel) o;
        return categoria == hotel.categoria &&
                nQuartosDisp == hotel.nQuartosDisp &&
                pQuarto == hotel.pQuarto &&
                Objects.equals(id, hotel.id) &&
                Objects.equals(nome, hotel.nome) &&
                Objects.equals(localidade, hotel.localidade);
    }


}
