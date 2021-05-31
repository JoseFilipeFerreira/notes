package Ex3V1;

public class Writer implements Runnable{
    private RWLock rwlock;

    public Writer(RWLock rw) {
        this.rwlock = rw;
    }

    @Override
    public void run() {
        this.rwlock.writeLock();
        System.out.println("Lock Write");
        try {
            Thread.sleep(100);
        } catch (InterruptedException ignored) {}
        System.out.println("Unlock Write");
        this.rwlock.writeUnlock();
    }
}
