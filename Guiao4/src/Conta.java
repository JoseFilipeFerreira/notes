import java.util.concurrent.locks.ReentrantLock;

public class Conta {
    private double balanco;
    private ReentrantLock lockConta;

    public Conta() {
        this.balanco = 0;
    }

    public Conta(double balanco) {
        this.balanco = balanco;
    }

    public void depositar(double valor){
        this.balanco += valor;
    }

    public void levantar(double valor){
        this.balanco -= valor;
    }

    public double consultar(){
        return this.balanco;
    }

    public void lock(){
        this.lockConta.lock();
    }

    public void unlock(){
        this.lockConta.unlock();
    }

}
