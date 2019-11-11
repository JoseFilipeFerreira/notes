package Ex1;

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;

public class BoundedBuffer {
    private int[] values;
    private int poswrite;
    private ReentrantLock lock;
    private Condition notEmpty;
    private Condition notFull;

    public BoundedBuffer(int l) {
        this.values = new int[l];
        this.poswrite = 0;
        this.lock = new ReentrantLock();
        this.notEmpty = this.lock.newCondition();
        this.notFull = this.lock.newCondition();
    }

    public void put(int v) throws InterruptedException{
        lock.lock();
        try {
            while (this.values.length == this.poswrite)
                this.notFull.await();
            this.values[this.poswrite] = v;
            this.poswrite++;
            this.notEmpty.signal();
        } finally {
            lock.unlock();
        }
    }

    public int get() throws InterruptedException{
        lock.lock();
        try {
            while (this.poswrite == 0)
                this.notEmpty.await();
            this.poswrite--;
            int r = this.values[this.poswrite];
            this.notFull.signal();
            return r;
        } finally {
            lock.unlock();
        }
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
