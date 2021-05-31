package Banco;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.locks.ReentrantLock;

public class Conta {
    private double balanco;
    private List<Movimento> movimentos;
    private ReentrantLock lockConta;

    public Conta() {
        this.balanco = 0;
        this.movimentos = new ArrayList<>();
        this.lockConta = new ReentrantLock();
    }

    public Conta(double balanco) {
        this.balanco = balanco;
        this.movimentos = new ArrayList<>();
        this.lockConta = new ReentrantLock();
    }

    public double depositar(double valor){
        this.balanco += valor;
        return this.balanco;
    }

    public double levantar(double valor){
        this.balanco -= valor;
        return this.balanco;
    }

    public double consultar(){
        return this.balanco;
    }

    public void addMovimento(Movimento mov){
        this.movimentos.add(mov);
    }

    public List<Movimento> getMovimentos() {
        return new ArrayList<>(this.movimentos);
    }

    public void lock(){
        this.lockConta.lock();
    }

    public void unlock(){
        this.lockConta.unlock();
    }

}
