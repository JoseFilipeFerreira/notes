package v4;

public interface Controlador {
    void requesita_viagem(int origem, int destino) throws InterruptedException;
    void espera(int destino) throws InterruptedException;
}
