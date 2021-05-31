package Ex1;

public class Consumidor implements Runnable{
    private int n;
    BoundedBuffer bf;

    public Consumidor(BoundedBuffer bf, int n) {
        this.n = n;
        this.bf = bf;
    }

    @Override
    public void run() {
        for(int i = 0; i< this.n; i++){
            try {
                Thread.sleep(10); //para "exagerar" os possiveis problemas
                this.bf.get();
            } catch (InterruptedException ignored) {}
        }
    }
}
