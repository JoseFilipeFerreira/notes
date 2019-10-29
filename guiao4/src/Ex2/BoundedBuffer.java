package Ex2;

public class BoundedBuffer {
    private int[] values;
    int poswrite;

    public BoundedBuffer(int l) {
        this.values = new int[l];
        this.poswrite = 0;
    }

    public synchronized void put(int v){
        try {
            while (this.values.length == this.poswrite) {
                //System.out.println("Too Full");
                this.wait();
            }
            //System.out.println("Escreveu: " + v + "\tPosição: " + this.poswrite);
            this.values[this.poswrite] = v;
            this.poswrite++;

            this.notifyAll();
        } catch (InterruptedException ignored) {}
    }

    public synchronized int get() {
        try {
            while (this.poswrite == 0) {
                //System.out.println("Nothing");
                this.wait();
            }
        }catch (InterruptedException ignored) {}

        this.poswrite--;
        int r = this.values[this.poswrite];
        //System.out.println("Leu: " + r + "\tPosição: " + this.poswrite);
        this.notifyAll();
        return r;

    }

    public static void main(String[]atgs){
        BoundedBuffer bf = new BoundedBuffer(10);

        int total_ops = 100;
        int N = 10; //Número total de threads
        int P; // numero de produtores
        int C; // Número de consumidores

        for(P = 1; P <= N - 1; P++) {
            C = N - P;

            //gerar Produtores
            int opsProducer = total_ops/P;
            int restProducer = total_ops%P;
            Produtor[] prod = new Produtor[P];
            for (int i = 0; i < P - 1; i++)
                prod[i] = new Produtor(bf, opsProducer);
            prod[P-1] = new Produtor(bf, opsProducer + restProducer);

            //gerar consumidores
            int opsConsumer = total_ops/C;
            int restConsumer = total_ops%C;
            Consumidor[] cons = new Consumidor[C];
            for (int i = 0; i < C - 1; i++)
                cons[i] = new Consumidor(bf, opsConsumer);
            cons[C-1] = new Consumidor(bf, opsConsumer + restConsumer);

            // gerar threads de produtores
            Thread[] Tprod = new Thread[P];
            for (int i = 0; i < P; i++)
                Tprod[i] = new Thread(prod[i]);

            // gerar threads de consumidores
            Thread[] Tcons = new Thread[C];
            for (int i = 0; i < C; i++)
                Tcons[i] = new Thread(cons[i]);

            long startTime = System.currentTimeMillis();

            // arrancar as threads
            for (int i = 0; i < P; i++)
                Tprod[i].start();
            for (int i = 0; i < C; i++)
                Tcons[i].start();

            try {
                for (int i = 0; i < P; i++)
                    Tprod[i].join();
                for (int i = 0; i < C; i++)
                    Tcons[i].join();
            }
            catch (InterruptedException e) {}

            long endTime = System.currentTimeMillis();

            long time = endTime - startTime;

            System.out.println("Produtores: " + P + " | Consumidores: " + C + " | Tempo: " + time + " ms");
        }
    }
}
