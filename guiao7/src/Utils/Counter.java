package Utils;

public class Counter {
    private int count;

    public Counter() {this.count=0;}

    public int inc() {
        synchronized (this) {
            this.count++;
        }
        return this.count;
    }

    public int get(){return this.count;}

}
