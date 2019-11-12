package Ex3V1;

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;

public class RWLock {
    private ReentrantLock lock;
    private Condition readerCondition;
    private Condition writerCondition;
    private int nWriters; // número de escritores a correr (não pode ser maior do que zero)
    private int nReaders; // número de leitores a correr
    private int nReadersRequests; // número de pedidos de leitura
    private int nWritersRequests; // número de pedidos de escrita
    private int nWritersExecutions; // número de escritas consecutivas
    private int nReadersExecutions; // número de leituras consecutivas


    public RWLock() {
        this.lock = new ReentrantLock();
        this.readerCondition = this.lock.newCondition();
        this.writerCondition = this.lock.newCondition();
        this.nWriters = 0;
        this.nReaders = 0;
        this.nReadersRequests = 0;
        this.nWritersRequests = 0;
        this.nReadersExecutions = 0;
        this.nWritersExecutions = 0;
    }

    public void readLock(){
        this.lock.lock();
        this.nReadersRequests++;
        while(this.nWriters > 0 || (this.nWritersRequests > 0 && this.nReadersExecutions > 3)) {
            try {
                this.readerCondition.await();
            } catch (InterruptedException ignored) {}
        }
        this.nWritersExecutions = 0; // COMBO BREAK
        this.nReadersExecutions++;
        this.nReaders++;
        this.nReadersRequests--;
        this.lock.unlock();
    }

    public void readUnlock(){
        this.lock.lock();
        this.nReaders--;
        if (this.nReaders == 0)
            this.writerCondition.signal();
        this.lock.unlock();
    }

    public void writeLock(){
        this.lock.lock();
        this.nWritersRequests++;
        while (this.nReaders > 0 || this.nWriters > 0 || (this.nReadersRequests > 0 && this.nWritersExecutions > 3)) {
            try {
                this.writerCondition.await();
            } catch (InterruptedException ignored) {}
        }
        this.nReadersExecutions = 0; // COMBO BREAK
        this.nWritersExecutions++;
        this.nWriters++;
        this.nWritersRequests--;
        this.lock.unlock();
    }

    public void writeUnlock(){
        this.lock.lock();
        this.nWriters--;
        this.readerCondition.signal();
        this.writerCondition.signal();
        this.lock.unlock();
    }

    public static void main(String[] args) {
        int nWriters = 15;
        int nReaders = 15;
        RWLock rw = new RWLock();

        //gerar Threads
        Thread[] ltreader = new Thread[nReaders];
        for(int i = 0; i < nReaders; i++)
            ltreader[i] = new Thread(new Writer(rw));
        Thread[] ltwriter = new Thread[nWriters];
        for(int i = 0; i < nWriters; i++)
            ltwriter[i] = new Thread(new Reader(rw));

        //iniciar Threads
        for(int i = 0; i < nReaders; i++)
            ltreader[i].start();
        for(int i = 0; i < nWriters; i++)
            ltwriter[i].start();

        try {
            for(int i = 0; i < nReaders; i++)
                ltreader[i].join();
            for(int i = 0; i < nWriters; i++)
                ltwriter[i].join();
        } catch (InterruptedException ignored) {}
    }
}
