package Ex1;

public class Produtor implements Runnable{
    private int n;
    BoundedBuffer bf;

    public Produtor(BoundedBuffer bf, int n) {
        this.n = n;
        this.bf = bf;
    }

    @Override
    public void run() {
        for(int i = 0; i< this.n; i++){
            try {
                Thread.sleep(20);  //para "exagerar" os possiveis problemas
                this.bf.put(i);
            } catch (InterruptedException ignored) {}

        }
    }
}
