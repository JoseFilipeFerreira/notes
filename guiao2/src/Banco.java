public class Banco {
    private double [] contas;

    public Banco(int size) {
        this.contas = new double[size];
    }

    public double consultar(int conta) {
        return this.contas[conta];
    }

    public synchronized void depositar(int conta, double valor) {
        this.contas[conta] += valor;
    }

    public synchronized void levantar(int conta, double valor) {
        this.contas[conta] -= valor;
    }

    public void transferir(int contaO, int contaD, double valor){
        this.levantar(contaO, valor);
        this.depositar(contaD, valor);
    }
}
