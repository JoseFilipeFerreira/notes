public class Counter {
    private int count;

    public Counter(int i) {count=i;}

    public void inc() {
        synchronized (this) {
            this.count++;
        }
    }

    public int get(){return this.count;}
}
