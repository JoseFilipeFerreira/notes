package Ex2;

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;

public class Item {
    private ReentrantLock lock;
    private Condition notEmpty;
    private Condition notFull;
    private int quantity;
    private int maxQuantity;

    public Item(int maxQuantity, int quantity) {
        this.lock = new ReentrantLock();
        this.notEmpty = lock.newCondition();
        this.notFull = lock.newCondition();
        this.quantity = quantity;
        this.maxQuantity = maxQuantity;
    }

    public void supply(int add){
        lock.lock();
        try {
            while (add > 0) {
                while (this.quantity == this.maxQuantity)
                    this.notFull.await();

                int cadd = Math.min(add, (this.maxQuantity - this.quantity));
                System.out.println("Had: " + this.quantity + "/" + this.maxQuantity + " Added: " + cadd);
                this.quantity += cadd;
                add -= cadd;
                this.notEmpty.signal();
            }
        } catch (InterruptedException ignored) {}
        finally {
            lock.unlock();
        }
    }

    public void consume() throws InterruptedException{
        lock.lock();
        try {
            while (this.quantity == 0)
                this.notEmpty.await();
            this.quantity--;
            this.notFull.signal();
        } finally {
            lock.unlock();
        }
    }

    public int getQuantity() throws InterruptedException{
        lock.lock();
        try {
            return this.quantity;
        } finally {
            lock.unlock();
        }
    }
}
