package Ex3V2;

import Ex3V2.Reader;
import Ex3V2.Writer;

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;

public class RWLock {
    ReentrantLock lock;
    int nWriters;
    int nReaders;
    Condition readerCondition;
    Condition writerCondition;

    public RWLock() {
        this.lock = new ReentrantLock();
        this.readerCondition = this.lock.newCondition();
        this.writerCondition = this.lock.newCondition();
        this.nWriters = 0;
        this.nReaders = 0;
    }

    public void readLock(){
        this.lock.lock();
        while(this.nWriters > 0) {
            try {
                this.readerCondition.await();
            } catch (InterruptedException ignored) {}
        }
        this.nReaders++;
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
        while (this.nReaders > 0 || this.nWriters > 0) {
            try {
                this.writerCondition.await();
            } catch (InterruptedException ignored) {}
        }
        this.nWriters++;
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

        Thread[] ltreader = new Thread[nReaders];
        for(int i = 0; i < nReaders; i++)
            ltreader[i] = new Thread(new Writer(rw));
        Thread[] ltwriter = new Thread[nWriters];
        for(int i = 0; i < nWriters; i++)
            ltwriter[i] = new Thread(new Reader(rw));

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
