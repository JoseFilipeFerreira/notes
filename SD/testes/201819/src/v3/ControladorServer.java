package v3;

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;

public class ControladorServer implements Controlador {
    //limitaçoes
    private int nTerminals;
    private int tamanhoShuttle;
    private int ocupacaoMinima;

    //estado da aplicação
    private int terminal;
    private int ocupacao;
    private int[] passageirosParaSair;
    private int[] passageirosParaEntrar;

    //lock e condições
    private ReentrantLock lock;
    private Condition esperaParaEntrar;
    private Condition esperaParaSair;
    private Condition esperaSaidaPassageiros;
    private Condition esperaEntradaPassageiros;

    public ControladorServer(int nTerminals, int tamanhoShuttle, int ocupacaoMinima) {
        this.nTerminals = nTerminals;
        this.tamanhoShuttle = tamanhoShuttle;
        this.ocupacaoMinima = ocupacaoMinima;

        this.terminal = 1;
        this.ocupacao = 0;
        this.passageirosParaSair = new int [nTerminals];
        this.passageirosParaEntrar = new int [nTerminals];

        this.lock = new ReentrantLock();
        this.esperaParaEntrar = this.lock.newCondition();
        this.esperaParaSair = this.lock.newCondition();
        this.esperaSaidaPassageiros = this.lock.newCondition();
        this.esperaEntradaPassageiros = this.lock.newCondition();
    }

    @Override
    public void requesita_viagem(int origem, int destino) throws InterruptedException {
        this.lock.lock();

        this.passageirosParaEntrar[origem]++;
        while(this.terminal != origem || this.ocupacao >= this.tamanhoShuttle)
            this.esperaParaEntrar.await();

        this.passageirosParaEntrar[origem]++;
        this.passageirosParaSair[destino]++;
        this.ocupacao++;

        this.esperaEntradaPassageiros.signalAll();
        this.lock.unlock();
    }

    @Override
    public void espera(int destino) throws InterruptedException {
        lock.lock();
        while(this.terminal != destino)
            this.esperaParaSair.await();

        this.passageirosParaSair[destino]--;
        this.ocupacao--;

        this.esperaSaidaPassageiros.signalAll();
        this.lock.unlock();
    }

    public void parte() throws InterruptedException {
        this.lock.lock();
        this.terminal = - this.terminal;

        this.esperaParaSair.signalAll();

        while (passageirosParaSair[this.terminal - 1] > 0)
            esperaSaidaPassageiros.await();

        esperaParaEntrar.signalAll();

        while (this.ocupacao < this.ocupacaoMinima
                || (this.passageirosParaEntrar[this.terminal] > 0 && this.ocupacao < this.tamanhoShuttle))
            this.esperaEntradaPassageiros.await();

        if (this.terminal == 5)
            this.terminal = -1;
        else
            this.terminal = -(this.terminal + 1);

    }
}