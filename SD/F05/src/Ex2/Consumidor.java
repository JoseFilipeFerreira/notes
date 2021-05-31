package Ex2;

import com.sun.source.tree.WhileLoopTree;

public class Consumidor implements Runnable{
    private int n;
    private String[] items;
    private Warehouse wh;

    public Consumidor(Warehouse wh, int n, String[] items) {
        this.n = n;
        this.items = items;
        this.wh = wh;
    }

    @Override
    public void run() {
        for(int i = 0; i< this.n; i++){
            try {
                this.wh.consume(this.items);
                Thread.sleep(1000);
            }
            catch (InterruptedException ignored) {}
        }
    }
}
