package Ex1;

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
                System.out.println("Too Full");
                this.wait();
            }
            System.out.println("Escreveu: " + v + "\tPosição: " + this.poswrite);
            this.values[this.poswrite] = v;
            this.poswrite++;

            this.notifyAll();
        } catch (InterruptedException ignored) {}
    }

    public synchronized int get() {
        try {
            while (this.poswrite == 0) {
                System.out.println("Nothing");
                this.wait();
            }
        }catch (InterruptedException ignored) {}

        this.poswrite--;
        int r = this.values[this.poswrite];
        System.out.println("Leu: " + r + "\tPosição: " + this.poswrite);
        this.notifyAll();
        return r;

    }

    public static void main(String[]atgs){
        BoundedBuffer bf = new BoundedBuffer(10);

        Consumidor c = new Consumidor(bf,20);
        Produtor p = new Produtor(bf, 20);

        Thread t1 = new Thread(c);
        Thread t2 = new Thread(p);

        t1.start();
        t2.start();

        try {
            t1.join();
            t2.join();
        } catch (InterruptedException ignored) {}
    }
}
