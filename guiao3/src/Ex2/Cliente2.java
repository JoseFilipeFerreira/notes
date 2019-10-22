package Ex2;

import Exceptions.ContaInvalida;

public class Cliente2 implements Runnable{
    private Banco2 banco;
    private int valorInicial;

    private int[] consultar;
    private boolean fecharConta;

    public Cliente2(Banco2 banco, int valorInicial, int[] consultar, boolean fecharConta) {
        this.banco = banco;
        this.valorInicial = valorInicial;
        this.consultar = consultar;
        this.fecharConta = fecharConta;
    }

    public void run(){
        int conta = this.banco.criarConta(this.valorInicial);

        if (this.consultar.length > 0) {
            this.banco.consultarTotal(this.consultar);
        }
        if (this.fecharConta){
            try {
                this.banco.fecharConta(conta);
            } catch (ContaInvalida ignored){}
        }
    }

    public static void main(String [] args){
            Banco2 b = new Banco2();

            Cliente2 cli1 = new Cliente2(b, 0, new int[]{0, 1, 2}, false);
            Cliente2 cli2 = new Cliente2(b, 0, new int[0], true );

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
