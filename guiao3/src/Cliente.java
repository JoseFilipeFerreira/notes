public class Cliente implements Runnable{
        private Banco banco;
        private int contaO;
        private int contaD;
        private double valor;
        private double levantar;

        public void run(){
            this.banco.transferir(this.contaO, this.contaD, this.valor);
            this.banco.levantar(this.contaO, this.levantar);
        }

    public Cliente(Banco banco, int contaO, int contaD, double valor, double levantar) {
        this.banco = banco;
        this.contaO = contaO;
        this.contaD = contaD;
        this.valor = valor;
        this.levantar = levantar;
    }

    public static void main(String [] args){
            Banco b = new Banco(2);

            Cliente cli1 = new Cliente(b, 0, 1, 1000, 0);
            Cliente cli2 = new Cliente(b, 1, 0, 0, 1000);

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
