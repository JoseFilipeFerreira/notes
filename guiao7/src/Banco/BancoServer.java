package Banco;

import Exceptions.ContaInvalida;
import Exceptions.SaldoInsuficiente;
import Utils.Counter;
import InterfaceBanco;

import java.util.HashMap;
import java.util.List;
import java.util.concurrent.locks.ReentrantLock;

public class BancoServer implements InterfaceBanco {
    private HashMap<Integer, Conta> contas;
    private ReentrantLock lockBanco;
    private Counter lastId;

    public BancoServer(int size) {
        this.lastId = new Counter();
        this.lockBanco = new ReentrantLock();
        this.contas = new HashMap<>();
        for(int i = 0; i < size ; i++) {
            this.criarConta(i * 10);
        }
    }
    public BancoServer() {
        this.lastId = new Counter();
        this.lockBanco = new ReentrantLock();
        this.contas = new HashMap<>();
    }

    public double consultar(int conta)
            throws ContaInvalida{
        if (!this.contas.containsKey(conta)){
            throw new ContaInvalida();
        }
        this.lockBanco.lock();
        double r = this.contas.get(conta).consultar();
        this.lockBanco.unlock();
        return r;
    }

    public double consultarTotal(int contas[])
            throws ContaInvalida{
        double total = 0;
        this.lockBanco.lock();
        try {
            for (int c : contas) {
                total += this.consultar(c);
            }
        }
        finally {
            this.lockBanco.unlock();
        }
        return total;
    }

    public int criarConta(double saldoInicial){
        this.lockBanco.lock();
        this.contas.put(this.lastId.inc(), new Conta(saldoInicial));
        this.lockBanco.unlock();
        return this.lastId.get();
    }

    public double fecharConta(int id)
            throws ContaInvalida{
        this.lockBanco.lock();
        if (!this.contas.containsKey(id)){
            this.lockBanco.unlock();
            throw new ContaInvalida();
        }
        Conta c = this.contas.remove(id);
        this.lockBanco.unlock();
        return c.consultar();
    }

    public void depositar(int conta, double valor)
            throws ContaInvalida{
        this.lockBanco.lock();
        if (!this.contas.containsKey(conta)){
            this.lockBanco.unlock();
            throw new ContaInvalida();
        }
        this.contas.get(conta).lock();
        this.lockBanco.unlock();
        double saldo_resultante = this.contas.get(conta).depositar(valor);
        this.contas.get(conta).addMovimento(
                new Movimento(+1 ,"Depósito", valor, saldo_resultante)
        );
        this.contas.get(conta).unlock();

    }

    public void levantar(int conta, double valor)
            throws ContaInvalida, SaldoInsuficiente{
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
        double saldo_resultante = this.contas.get(conta).levantar(valor);
        this.contas.get(conta).addMovimento(
                new Movimento(-1 ,"Depósito", valor, saldo_resultante)
        );
        this.contas.get(conta).unlock();

    }

    public void transferir(int contaO, int contaD, double valor)
            throws ContaInvalida, SaldoInsuficiente{
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
        this.contas.get(contaO).addMovimento(
                new Movimento(
                        -1,
                        "Transferência para conta " + contaD,
                        valor,
                        this.contas.get(contaO).consultar())
        );

        this.depositar(contaD, valor);
        this.contas.get(contaO).addMovimento(
                new Movimento(
                        +1,
                        "Transferência de conta " + contaO,
                        valor,
                        this.contas.get(contaD).consultar())
        );

        this.contas.get(contaO).unlock();
        this.contas.get(contaD).unlock();
    }

    public List<Movimento> movimentos(int id)
            throws ContaInvalida{
        if (!this.contas.containsKey(id)){
            throw new ContaInvalida();
        }
        this.lockBanco.lock();
        List<Movimento> r = this.contas.get(id).getMovimentos();
        this.lockBanco.unlock();
        return r;
    }
}
