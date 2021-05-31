package Ex1;

public class Conta1 {
    private double balanco;

    public Conta1() {
        this.balanco = 0;
    }

    public Conta1(double balanco) {
        this.balanco = balanco;
    }

    public synchronized void depositar(double valor){
        this.balanco += valor;
    }

    public synchronized void levantar(double valor){
        this.balanco -= valor;
    }

    public synchronized double consultar(){
        return this.balanco;
    }
}
