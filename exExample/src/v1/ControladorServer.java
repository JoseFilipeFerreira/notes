package v1;

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;

public class ControladorServer implements Controlador {
    private int terminal;
    private int passageiros;
    private int[] passageirosParaSair;
    private int nTerminals;
    private ReentrantLock lock;
    private Condition mudaTerminal;
    private Condition esperaSaidaPassageiros;

    public ControladorServer(int nTerminals) {
        this.terminal = 1;
        this.passageiros = 0;
        this.nTerminals = nTerminals;
        this.passageirosParaSair = new int [nTerminals];
        this.lock = new ReentrantLock();
        this.mudaTerminal = this.lock.newCondition();
        this.esperaSaidaPassageiros = this.lock.newCondition();
    }

    @Override
    public void requesita_viagem(int origem, int destino) throws InterruptedException {
        this.lock.lock();
        while(this.terminal != origem){
            mudaTerminal.await();
        }
        passageirosParaSair[destino]++;
        lock.unlock();
    }

    @Override
    public void espera(int destino) throws InterruptedException {
        lock.lock();
        while(this.terminal != destino){
            mudaTerminal.await();
        }
        passageirosParaSair[destino]--;
        esperaSaidaPassageiros.signalAll();

        lock.unlock();
    }

    public void parte() throws InterruptedException {
        this.lock.lock();
        this.terminal = (this.terminal % this.nTerminals) + 1;

        mudaTerminal.signalAll();

        while (passageirosParaSair[this.terminal] > 0){
            esperaSaidaPassageiros.await();
        }

    }

    public int nextStop(){
        this.terminal++;
        if (this.terminal == 6)
            this.terminal = 1;
        return this.terminal;
    }
}
