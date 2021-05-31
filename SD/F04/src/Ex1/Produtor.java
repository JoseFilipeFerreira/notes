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
            this.bf.put(i);
        }
    }
}
