package Ex2;

public class Produtor implements Runnable{
    private int n;
    private String[] items;
    private Warehouse wh;

    public Produtor(Warehouse wh, int n, String[] items) {
        this.n = n;
        this.items = items;
        this.wh = wh;
    }

    @Override
    public void run() {
        for(int i = 0; i< this.n; i++){
            try {
                for(String item : this.items) {
                    this.wh.supply(item, 2);
                    Thread.sleep(1000);
                }
            } catch (InterruptedException ignored) {}

        }
    }
}
