import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class EncEficiente {
    private String nomeCliente;
    private int nFiscal;
    private String morada;
    private int nEncomenda;
    private LocalDateTime dataEndomenda;
    private List<LinhaEncomenda> encomendas;

    public EncEficiente() {
        this.nomeCliente = "n/a";
        this.nFiscal = 0;
        this.morada = "n/a";
        this.nEncomenda = 0;
        this.dataEndomenda = LocalDateTime.now();
        this.encomendas = new ArrayList<LinhaEncomenda>();
    }

    public EncEficiente(String nomeCliente, int nFiscal, String morada, int nEncomenda, LocalDateTime dataEndomenda, List<LinhaEncomenda> encomendas) {
        this.nomeCliente = nomeCliente;
        this.nFiscal = nFiscal;
        this.morada = morada;
        this.nEncomenda = nEncomenda;
        this.dataEndomenda = dataEndomenda;
        for(LinhaEncomenda le: encomendas){
            this.encomendas.add(le.clone());
        }

    }

    public double calculaValorTotal(){
        int r = 0;
        for (LinhaEncomenda le : this.getEncomendas()){
            r += le.calculaValorLinhaEnc();
        }
        return r;
    }

    public double calculaValorDesconto(){
        int r = 0;
        for (LinhaEncomenda le : this.getEncomendas()){
            r += le.calculaValorDesconto();
        }
        return r;
    }

    public int numeroTotalProdutos(){
        int r = 0;
        for (LinhaEncomenda le : this.getEncomendas()){
            r += le.getQuantidade();
        }
        return r;
    }



    public String getNomeCliente() {
        return this.nomeCliente;
    }

    public int getnFiscal() {
        return this.nFiscal;
    }

    public String getMorada() {
        return this.morada;
    }

    public int getnEncomenda() {
        return this.nEncomenda;
    }

    public LocalDateTime getDataEndomenda() {
        return this.dataEndomenda;
    }

    public List<LinhaEncomenda> getEncomendas() {
        return this.encomendas;
    }

    public void setNomeCliente(String nomeCliente) {
        this.nomeCliente = nomeCliente;
    }

    public void setnFiscal(int nFiscal) {
        this.nFiscal = nFiscal;
    }

    public void setMorada(String morada) {
        this.morada = morada;
    }

    public void setnEncomenda(int nEncomenda) {
        this.nEncomenda = nEncomenda;
    }

    public void setDataEndomenda(LocalDateTime dataEndomenda) {
        this.dataEndomenda = dataEndomenda;
    }

    public void setEncomendas(List<LinhaEncomenda> encomendas) {
        this.encomendas = encomendas;
    }


}
