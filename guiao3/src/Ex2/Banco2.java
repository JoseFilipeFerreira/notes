package Ex2;

import Exceptions.ContaInvalida;
import Exceptions.SaldoInsuficiente;

import java.util.HashMap;
import java.util.concurrent.locks.ReentrantLock;

public class Banco2 {
    private HashMap<Integer, Conta2> contas;
    private ReentrantLock lockBanco;
    int lastId;

    public Banco2(int size) {
        this.lastId = 0;
        this.lockBanco = new ReentrantLock();
        this.contas = new HashMap<>();
        for(int i = 0; i < size ; i++) {
            this.criarConta(0);
        }
    }
    public Banco2() {
        this.lastId = 0;
        this.lockBanco = new ReentrantLock();
        this.contas = new HashMap<>();
    }

    public double consultar(int conta) throws ContaInvalida{
        if (!this.contas.containsKey(conta)){
            throw new ContaInvalida();
        }
        this.lockBanco.lock();
        double r = this.contas.get(conta).consultar();
        this.lockBanco.unlock();
        return r;
    }

    public double consultarTotal(int contas[]){
        double total = 0;
        this.lockBanco.lock();
        for (int c: contas){
            try{
                total += this.consultar(c);
            }
            catch (ContaInvalida ignored) {}
        }
        this.lockBanco.unlock();
        return total;
    }

    public int criarConta(double saldoInicial){
        this.lockBanco.lock();
        int id = this.lastId++;
        this.contas.put(id, new Conta2(saldoInicial));
        this.lockBanco.unlock();
        return id;
    }

    public double fecharConta(int id) throws ContaInvalida {
        this.lockBanco.lock();
        if (!this.contas.containsKey(id)){
            this.lockBanco.unlock();
            throw new ContaInvalida();
        }
        Conta2 c = this.contas.remove(id);
        this.lockBanco.unlock();
        return c.consultar();
    }

    public void depositar(int conta, double valor) throws ContaInvalida{
        this.lockBanco.lock();
        if (!this.contas.containsKey(conta)){
            this.lockBanco.unlock();
            throw new ContaInvalida();
        }
        this.contas.get(conta).lock();
        this.lockBanco.unlock();
        this.contas.get(conta).depositar(valor);
        this.contas.get(conta).unlock();

    }

    public void levantar(int conta, double valor) throws ContaInvalida, SaldoInsuficiente{
        this.lockBanco.lock();
        if (!this.contas.containsKey(conta)){
            this.lockBanco.unlock();
            throw new ContaInvalida();
        }
        if (this.consultar(conta) < valor){
            this.lockBanco.unlock();
            throw new SaldoInsuficiente();
        }
        this.contas.get(conta).lock();
        this.lockBanco.unlock();
        this.contas.get(conta).levantar(valor);
        this.contas.get(conta).unlock();
    }

    public void transferir(int contaO, int contaD, double valor) throws ContaInvalida, SaldoInsuficiente {
        this.lockBanco.lock();
        if (!this.contas.containsKey(contaD) || !this.contas.containsKey(contaO)){
            this.lockBanco.unlock();
            throw new ContaInvalida();
        }
        if (this.consultar(contaO) < valor){
            this.lockBanco.unlock();
            throw new SaldoInsuficiente();
        }
        this.contas.get(contaO).lock();
        this.contas.get(contaD).lock();
        this.lockBanco.unlock();
        this.levantar(contaO, valor);
        this.depositar(contaD, valor);
        this.contas.get(contaO).unlock();
        this.contas.get(contaD).unlock();
    }
}
