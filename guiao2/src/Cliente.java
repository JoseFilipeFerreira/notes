public class Cliente implements Runnable{
    private Banco banco;
    private int nOps;
    private int conta;
    private double valor;

    public void run(){
        for (int i = 0; i < this.nOps; i++) {
            this.banco.depositar(this.conta, this.valor);
        }
    }

    public Cliente(Banco banco, int nOps, int conta, double valor) {
        this.banco = banco; this.nOps = nOps; this.conta = conta; this.valor = valor;
    }

    public static void main(String [] args){
        Banco b = new Banco(2);

        Cliente cli1 = new Cliente(b, 100000, 0, 5);
        Cliente cli2 = new Cliente(b, 100000, 0, -5);

        Thread t1 = new Thread(cli1);
        Thread t2 = new Thread(cli2);

        t1.start();
        t2.start();

        try {
            t1.join();
            t2.join();
        } catch (InterruptedException ignored) {}

        System.out.println(b.consultar(0));
    }


    }
