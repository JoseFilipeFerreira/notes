public class Banco {
    private Conta [] contas;

    public Banco(int size) {
        this.contas = new Conta[size];
        for(int i = 0; i < size ; i++){
            this.contas[i] = new Conta();
        }
    }

    public double consultar(int conta) {
        return this.contas[conta].consultar();
    }

    public void depositar(int conta, double valor) {
        this.contas[conta].depositar(valor);
    }

    public void levantar(int conta, double valor) {
        this.contas[conta].levantar(valor);
    }

    public void transferir(int contaO, int contaD, double valor){
        this.levantar(contaO, valor);
        this.depositar(contaD, valor);
    }
}
