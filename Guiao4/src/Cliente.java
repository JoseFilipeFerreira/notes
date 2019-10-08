public class Cliente implements Runnable{
    private Banco banco;
    private int valorInicial;

    private int[] consultar;
    private boolean fecharConta;

    public void run(){
        int conta = this.banco.criarConta(this.valorInicial);

        if (this.consultar.length > 0) {
            this.banco.consultarTotal(this.consultar);
        }
        if (this.fecharConta){
            this.banco.fecharConta(conta);
        }
    }

    public static void main(String [] args){
            Banco b = new Banco();

            Cliente cli1 = new Cliente(b, 0, , [0,1,2], false);
            Cliente cli2 = new Cliente(b, 0, , [], true );

            Thread t1 = new Thread(cli1);
            Thread t2 = new Thread(cli2);

            t1.start();
            t2.start();

            try {
                t1.join();
                t2.join();
            } catch (InterruptedException ignored) {}
        }


    }
