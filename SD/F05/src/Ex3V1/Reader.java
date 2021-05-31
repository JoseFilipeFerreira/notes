package Ex3V1;

public class Reader implements Runnable{
    private RWLock rwlock;

    public Reader(RWLock rw) {
        this.rwlock = rw;
    }

    @Override
    public void run() {
        this.rwlock.readLock();
        System.out.println("Lock Read");
        try {
            Thread.sleep(100);
        } catch (InterruptedException ignored) {}
        System.out.println("Unlock Read");
        this.rwlock.readUnlock();

    }
}
