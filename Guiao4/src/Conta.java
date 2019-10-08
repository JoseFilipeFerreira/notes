public class Conta {
    private double balanco;

    public Conta() {
        this.balanco = 0;
    }

    public Conta(double balanco) {
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
