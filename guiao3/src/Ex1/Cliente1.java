package Ex1;

public class Cliente1 implements Runnable{
        private Banco1 banco;
        private int contaO;
        private int contaD;
        private double valor;
        private double levantar;

        public void run(){
            this.banco.transferir(this.contaO, this.contaD, this.valor);
            this.banco.levantar(this.contaO, this.levantar);
        }

    public Cliente1(Banco1 banco, int contaO, int contaD, double valor, double levantar) {
        this.banco = banco;
        this.contaO = contaO;
        this.contaD = contaD;
        this.valor = valor;
        this.levantar = levantar;
    }

    public static void main(String [] args){
            Banco1 b = new Banco1(2);

            Cliente1 cli1 = new Cliente1(b, 0, 1, 1000, 0);
            Cliente1 cli2 = new Cliente1(b, 1, 0, 0, 1000);

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
